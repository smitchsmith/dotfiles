NewReader.Views.FeedsIndex = Backbone.View.extend({

  tagName: 'ul',
  template: JST['feeds/index'],
  render: function () {
    var content = this.template();
    this.$el.html(content);

    var that = this;

    NewReader.feeds.each(function (feed) {
      var view = new NewReader.Views.FeedList({ feed: feed });
      that.$el.append(view.render().$el);
    });
    return this;
  }

});
