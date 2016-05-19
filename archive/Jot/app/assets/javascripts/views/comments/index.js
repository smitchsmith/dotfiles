Jot.Views.CommentIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove" , this.render)
  },

  template: JST['comments/index'],

  events: {
    "click .delete_comment" : "deleteComment"
  },

  attributes: {
    id: "comment_index"
  },

  render: function () {
    this.$el.html(this.template({comments: this.collection}));
    return this;
  },

  deleteComment: function (event) {
    var comment = this.collection.get($(event.target).attr("data-id"));
    var that = this;
    comment.destroy({
      success: function () {
        that.collection.remove(comment);
      }
    })
  }

});
