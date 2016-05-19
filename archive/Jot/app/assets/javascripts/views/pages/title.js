Jot.Views.PageTitle = Backbone.View.extend({

  template: JST['pages/title'],

  attributes: {
    id: "page_title"
  },

  events: {
    "click input" : "editTitle",
    "blur input" : "saveTitle"
  },

  render: function () {
    this.$el.html(this.template({ page: this.model }));
    return this;
  },

  editTitle: function (event) {
    if (event.target.value === "New Jot"){
      $(event.target).val('');
    }
  },

  saveTitle: function (event) {
    this.model.save({title: event.target.value});
    this.render();
  }

});
