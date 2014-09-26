var util          = require('../../util')
  , Model         = require('../Model')
  ;

module.exports = Model.declare(
  /**
   * Event Constructor
   */
  function Event(attributes) {
    this.superMethods().constructor.call(this, attributes);
  }, 
  null,
  function(Event, superMethods, method) {
    Event.belongsTo = {
    },
    Event.hasMany = {
    }

  },
  function(EventService, superMethods, method) {
    method.requestById = function(id, callback) {
      return this.request(Model.baseUrl + "events/" + id, {}, callback);
    }
  }
);
