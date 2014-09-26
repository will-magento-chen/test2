var inherits = require('inherits')

function subclass(klass, superClass, declarations) {
  inherits(klass, superClass);

  var superMethods = klass.super_.prototype;
  var method = klass.prototype;

  method.static = function() {
    return klass;
  }

  method.superMethods = function() {
    return superMethods;
  }

  if(declarations) declarations.bind(this)(klass, superMethods, method);

  return klass;
}


module.exports = {
  subclass: subclass
};
