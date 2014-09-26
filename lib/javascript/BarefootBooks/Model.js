var uuid      = require('uuid')
  , inherits  = require('inherits')
  , extend    = require('extend')
  , EventEmitter      = require('events').EventEmitter
  , util    = require('../util')
  , xhr     = require('xhr-browserify')
  , Uri     = require('url')
  , http = require('http');

var package = function() {
  function Model(attributes) {
    superClass.constructor.call(this);

    this.setMaxListeners(50);

    this.id = attributes.id;
    this.attributes = {};
    this.refreshAttributes(attributes || {});
  }
  var klass   = Model;

  inherits(klass, EventEmitter);
  var superClass  = klass.super_.prototype;
  var method      = klass.prototype;

  method.refreshAttributes = function(attributes) {
    var updatedAt = this.attributes.updatedAt || -1;
    attributes.updatedAt = attributes.updatedAt || 0;

    if(updatedAt < attributes.updatedAt) {
      this.attributes = extend({}, attributes);
      this.updatedAt = this.attributes.updatedAt;
      this.refreshReferences();
      this.emit("updated");
    }
    else {
      this.refreshReferences(attributes, false);
    }
  }

  method.refreshReferences = function(attributes, assign) {
    if(assign == null) assign = true;
    if(attributes == null) attributes = this.attributes;

    if(this.static().hasMany) {
      for(var key in this.static().hasMany) {
        if(attributes[key] != null) {
          var config = this.static().hasMany[key];
          var collection = [];

          attributes[key].forEach(function(itemAttributes) {
            collection.push(config.type.service().newFromAttributes(itemAttributes));
          });
          if(assign) this[key] = collection;
        }
      }
    }

    if(this.static().belongsTo) {
      for(var key in this.static().belongsTo) {
        if(attributes[key] != null) {
          var config = this.static().belongsTo[key];
          var itemAttributes = attributes[key];
          if(assign) this[key] = config.type.service().newFromAttributes(itemAttributes);
        }
      }
    }
  }

  method.reload = function(callback) {
    var service = this.service;
    service.find(this.id, callback, true);
  }

  klass.service = function() {
    if(this._service == null) {
      var serviceClass = this.serviceClass();
      this._service = new serviceClass();
    }
    return this._service;
  }

  return klass;
}();
module.exports = package;

package.Service = function() {
  function Service() {
    superClass.constructor.call(this);

    this._cache = {};
    this._activeLookups = {}; // maps id to an event emitter
  }
  var klass   = Service;
  inherits(klass, EventEmitter);
  var superClass  = klass.super_.prototype;
  var method      = klass.prototype;

  method.request = function(url, data, callback) {
    if(window && url.matches(/^https?:/)) {
      var uri = Uri.parse(url);
      xhr(uri, {jsonp: true}, function(err, data) {
        if(err) {
          self.emit('error', err);
        }
        else {
          callback(JSON.parse(data));
        }
      });
    }
    else {
      http.get(url, function (res) {
        res.on('data', function (buf) {
          callback(JSON.parse(buf));
        });
      });
    }
  }

  method.requestById = function(id, callback) {
    throw new Error("not implemented");
  }

  method.requestBy = function(query, callback) {
    throw new Error("not implemented");
  }

  method.newFromAttributes = function(attributes) {
    var modelClass = this.static().modelClass();

    if(attributes.id) {
      var instance = this._cache[attributes.id];
      if(instance) {
        instance.refreshAttributes(attributes);
      }
      else {
        instance = this.set(new modelClass(attributes));
      }
      return instance;
    }
    else {
      return new modelClass(attributes);
    }
  }

  method.findBy = function(query, callback) {
    var self = this;
    self.requestBy(query, function(attributes) {
      if(attributes) callback.bind(self)(self.newFromAttributes(attributes));
    });
  }

  method.find = function(id, callback, noCache) {
    var self = this;
    var instance = self._cache[id];
    if(instance == null || noCache) {

      var lookup = self._activeLookups[id];
      if(lookup == null) {
        lookup = new EventEmitter().setMaxListeners(50);
        lookup.on('success', callback.bind(self));

        self.requestById(id, function(attributes) {
          if(attributes) {
            var instance = self.newFromAttributes(attributes);
            lookup.emit('success', instance);
          }
          delete self._activeLookups[id];
        });
      }
      else {
        lookup.on('success', callback.bind(self));
      }
    }
    else {
      callback.bind(self)(instance);
    }
  }

  method.set = function(instance) {
    this._cache[instance.id] = instance;
    this._cache[instance.id].service = this;
    return instance;
  }


  return klass;
}();

package.declare = function(klass, superClass, modelDeclarations, serviceDeclarations, serviceConstructor) {
  superClass = superClass || package;

  util.subclass(klass, superClass, modelDeclarations);
  klass.service = function() {
    if(klass._service == null) {
      var serviceClass = klass.Service;
      klass._service = new serviceClass();
    }
    return klass._service;
  }


  serviceConstructor = serviceConstructor || function newService() {
    this.superMethods().constructor.call(this);
  };
  eval("klass.Service = function " + klass.name + "Service() { return serviceConstructor.bind(this)(); }");
  klass.Service.modelClass = function() { return klass; }

  util.subclass(klass.Service, superClass.Service, serviceDeclarations);

  return klass;
}

package.baseUrl = '/';
