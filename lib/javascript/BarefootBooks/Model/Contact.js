var util          = require('../../util')
  , Model         = require('../Model')
  ;

module.exports = Model.declare(
  /**
   * Contact Constructor
   */
  function Contact(attributes) {
    this.superMethods().constructor.call(this, attributes);
  }, 
  null,
  function(Contact, superMethods, method) {
    Contact.belongsTo = {
    },
    Contact.hasMany = {
    }

  },
  function(ContactService, superMethods, method) {
    method.requestById = function(id, callback) {
      return this.request(Model.baseUrl + "events/" + id, {}, callback);
    }
  }
);
