NewReader.Routers.Feeds = Backbone.Router.extend({
  routes: {
    "" : "feedsIndex",
    ":feedId/entries" : "feedView",
    ":feedId/entries/:entryId" : "entryView"
  },

  initialize: function (context) {
    this.element = context;
  },

  feedsIndex: function () {
    var view = new NewReader.Views.FeedsIndex();
    this._swapView(view);
  },

  feedView: function (feedId) {
    var feed = NewReader.feeds.get(feedId);
    var view = new NewReader.Views.FeedView({ model: feed });
    this._swapView(view);
  },

  entryView: function (feedId, entryId) {
    var feed = NewReader.feeds.get(feedId);
    var entry = feed.get("entries").get(entryId);
    var view = new NewReader.Views.EntryView({ model: entry });
    this._swapView(view);
  },

  _swapView: function(newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.element.html(newView.render().$el);
  }

});
