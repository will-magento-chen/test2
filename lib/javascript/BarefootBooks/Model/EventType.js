var util          = require('../../util')
  , Model         = require('../Model')
  ;

module.exports = Model.declare(
  /**
   * EventType Constructor
   */
  function EventType(attributes) {
    this.superMethods().constructor.call(this, attributes);
  }, 
  null,
  function(EventType, superMethods, method) {
    EventType.belongsTo = {
    },
    EventType.hasMany = {
    }

  },
  function(EventTypeService, superMethods, method) {
    method.requestById = function(id, callback) {
      return this.request(Model.baseUrl + "events/" + id, {}, callback);
    }
  }
);
