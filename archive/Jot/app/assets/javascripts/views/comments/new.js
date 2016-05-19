Jot.Views.NewComment = Backbone.View.extend({

  initialize: function () {
    this.setModel();
  },

  template: JST['comments/new'],

  attributes: {
    id: "new_comment"
  },

  className: "hidden",

  events: {
    "focus textarea" : "clearNewComment",
    "click #save_comment" : "saveComment"
  },

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  setModel: function () {
    this.model = new Jot.Models.Comment ()
    this.model.set("page_id", this.collection.page.id)
  },

  saveComment: function (event) {
    var that = this;
    this.model.save( { body: this.$("#comment_body").val() } , {
      success: function () {
        that.collection.add(that.model);
        that.$("#comment_body").val('New Comment');
        that.setModel();
      }
    });
  },

  clearNewComment: function (event) {
    if (event.target.value === "New Comment") {
      $(event.target).val('');
    }
  }

});
