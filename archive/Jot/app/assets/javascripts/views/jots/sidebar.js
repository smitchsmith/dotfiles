Jot.Views.Sidebar = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model.versions, "add", this.render)
    this.listenTo(this.model, "change:is_public", this.render)
  },

  events: {
    "click .open_sharing" : "openSharing",
    "click #help" : "openHelp"
  },

  template: JST['jots/sidebar'],

  attributes: {
    id: "sidebar"
  },

  tagName: "ul" ,

  render: function () {
    this.$el.html(this.template({
      page: this.model,
      versions: this.model.versions,
      syntaxes: Jot.syntaxes
    }));

    if (Jot.current_user.id) {
      var favorites_el = this.$("#favorites_li")
      var favorites_view = new Jot.Views.FavoritesSidebar({ model: this.model }, { el: favorites_el })
      favorites_view.render()
    }

    var binaries_el = this.$("#binaries")
    var binaries_view = new Jot.Views.BinariesSidebar({ collection: this.model.binaries }, { el: binaries_el})
    binaries_view.render()

    this.tourCheck();
    return this;
  },

  openSharing: function (event) {
    event.preventDefault();
    var view = new Jot.Views.ShareModal({model: this.model});
    view.render();
  },

  openHelp: function (event) {
    event.preventDefault();
    var view = new Jot.Views.HelpModal({model: this.model});
    view.render();
  },

  tourCheck: function () {
    var tour = JSON.parse($("#had_tour").html())
    if (!tour.had_tour) {
      this.$("#help").click();
    }
  }

});