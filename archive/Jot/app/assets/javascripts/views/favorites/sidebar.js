Jot.Views.FavoritesSidebar = Backbone.View.extend({

  initialize: function (model, options) {
    this.$el = options.el
    this.listenTo(Jot.current_user.favorites, "add remove", this.render)
  },

  events: {
    "click #favorite_buttons img" : "toggleFavorite"
  },

  template: JST['favorites/sidebar'],

  render: function () {
    this.$el.html(this.template({
      isFavorite: this.isFavorite()
    }));
    return this;
  },

  isFavorite: function () {
    var that = this;
    return Jot.current_user.favorites.select(function (favorite) {
      return favorite.get("page_id") === that.model.id
    }).length === 1
  },

  toggleFavorite: function (event) {
    var that = this;
    if (this.isFavorite()) {
      favorite = Jot.current_user.favorites.findWhere({ page_id: that.model.id })
      Jot.current_user.favorites.remove(favorite);
      favorite.destroy();
    } else {
      Jot.current_user.favorites.create({ page_id: this.model.id, user_id: Jot.current_user.id })
    }
  }

});