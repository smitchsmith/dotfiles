Jot.Models.CurrentUser = Backbone.Model.extend({
  urlRoot: "/current_user",

  parse: function (response, options) {
    if (response) {
      this.favorites = new Jot.Collections.Favorites(response.favorites, { user: this })
    }
    return response;
  }
});
