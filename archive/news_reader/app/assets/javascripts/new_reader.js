window.NewReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var content = $('#content');
    NewReader.feeds = new NewReader.Collections.Feeds();
    NewReader.feeds.fetch({
      success: function () {
        new NewReader.Routers.Feeds(content);
        Backbone.history.start();
      }
    });
  }
};

$(document).ready(function(){
  NewReader.initialize();
});
