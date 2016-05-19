window.Jot = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Jot.modal_$el = $("#modal");

    Jot.syntaxes = new Jot.Collections.Syntaxes;
    var syntaxes = JSON.parse($("#bootstrapped_syntaxes").html());
    Jot.syntaxes.reset(syntaxes);

    Jot.current_user = new Jot.Models.CurrentUser;
    Jot.current_user.fetch ({ success: function () {
      new Jot.Routers.Jots ({
        rootEl: $("#container")
      });
      Jot.pages = new Jot.Collections.Pages();
      Backbone.history.start();
    }})
  }
};