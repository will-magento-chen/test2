var Model = require('./BarefootBooks/Model');
Model.Event = require('./BarefootBooks/Model/Event');

window.BarefootBooks = {
  Model: Model
};

Model.baseUrl = "http://localhost.barefootbooks.com:3001/";
