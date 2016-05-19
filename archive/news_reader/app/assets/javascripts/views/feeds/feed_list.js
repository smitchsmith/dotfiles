NewReader.Views.FeedList = Backbone.View.extend({
  initialize: function (options) {
    this.feed = options.feed;
  },
  tagName: "li",
  template: JST["feeds/list"],

  render: function () {
    var content = this.template({ feed: this.feed });
    this.$el.html(content);
    return this;
  }

});