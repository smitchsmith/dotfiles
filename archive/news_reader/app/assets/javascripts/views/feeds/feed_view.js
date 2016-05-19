NewReader.Views.FeedView = Backbone.View.extend({

  initialize: function () {
    this.listenTo(
      this.model.get("entries"),
      "add",
      this.render
    );
  },

  tagName: 'ul',
  // this.$el = $("<ul></ul>");
  template: JST["feeds/view"],
  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.prepend(content);

    var that = this;

    this.model.get("entries").each(function (entry) {
      var view = new NewReader.Views.EntryList({ model: entry });
      that.$el.append(view.render().$el);
    });
    return this;
  },

  events: {
    "click #refresh-feed": "refreshList"
  },

  refreshList: function (event) {
    event.preventDefault();
    var that = this;
    this.model.get("entries").fetch();
  }

});