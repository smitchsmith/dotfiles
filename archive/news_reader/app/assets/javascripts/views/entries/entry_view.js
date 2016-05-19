NewReader.Views.EntryView = Backbone.View.extend({
  // model: entry
  template: JST["entries/view"],
  render: function () {
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    return this;
  }
});