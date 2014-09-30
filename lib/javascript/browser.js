var Model = require('./BarefootBooks/Model');
Model.Event = require('./BarefootBooks/Model/Event');

window.BarefootBooks = {
  Model: Model
};

Model.baseUrl = "https://my.barefootbooks.com/";
//Model.baseUrl = "http://localhost.barefootbooks.com:3001/";

var q   = require('jquery')
  , dot = require('dot')

q(document).ready(function() {
  q('[data-type=EventView]').each(function(i, el) {
    var source = q(el).find('script[type="text/x-dot-template"]').html();
    var container = q(el).find('[role="container"]');
    var template = dot.template(source);

    (function(template, container) {
      var event = Model.Event.service().find(el.getAttribute('data-id'), function(event) {
        var refreshUi = function() {
          container.html(template({event: event}));
        };

        refreshUi();
        event.on("updated", function() { refreshUi(); });

      });
    })(template, container);
  });
});
