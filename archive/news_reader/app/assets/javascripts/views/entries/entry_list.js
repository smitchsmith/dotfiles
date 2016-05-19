NewReader.Views.EntryList = Backbone.View.extend({
  tagName: "li",
  template: JST["entries/list"],

  render: function () {
    var content = this.template({ entry: this.model });

    this.$el.html(content);
    return this;
  }

});