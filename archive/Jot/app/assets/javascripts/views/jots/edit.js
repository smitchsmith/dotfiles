Jot.Views.EditJot = Backbone.View.extend({

  attributes: {
    id: "main"
  },

  render: function () {
    this.page_view = new Jot.Views.EditPage ({model: this.model});
    this.$el.append(this.page_view.render().$el);

    this.comments_view = new Jot.Views.CommentsSection ({collection: this.model.comments})
    this.$el.append(this.comments_view.render().$el);

    return this;
  }

});