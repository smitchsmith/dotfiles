Jot.Views.CommentsSection = Backbone.View.extend({

  initialize: function () {
    this.shown = false;
  },

  attributes: {
    id: "comments"
  },

  template: JST['comments/section'],

  events: {
    "click .load_comments" : "toggleComments",
    "click .plus" : "showNewComment",
    "click .x" : "hideNewComment"
  },

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  renderCommentIndex: function () {
    this.comment_index = new Jot.Views.CommentIndex ({collection: this.collection});
    this.$el.append(this.comment_index.render().$el);
  },

  renderNewComment: function () {
    this.new_comment = new Jot.Views.NewComment ({collection: this.collection});
    this.$el.append(this.new_comment.render().$el);
  },

  showNewComment: function () {
    this.$("#new_comment").removeClass("hidden");
    this.$("#plus").removeClass("plus");
    this.$("#plus").addClass("x");
  },

  hideNewComment: function () {
    this.$("#new_comment").addClass("hidden");
    this.$("#plus").addClass("plus");
    this.$("#plus").removeClass("x");
  },

  toggleComments: function () {
    this.render();
    if (!this.shown) {
      this.$("#plus").removeClass("hidden");
      this.renderNewComment();
      this.renderCommentIndex();
      this.shown = true;
    } else {
      this.shown = false;
    }
  }

});
