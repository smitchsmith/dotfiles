Jot.Collections.Favorites = Backbone.Collection.extend({

  initialize: function (models, options) {
    this.user = options.user;
  },

  model: Jot.Models.Favorite,

  url: "favorites"

});
