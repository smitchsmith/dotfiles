Jot.Routers.Jots = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.rootEl;
  },

  routes: {
    ':urlFragment' : 'editJot'
  },

  editJot: function (urlFragment) {
    var that = this;
    this._getPage(urlFragment, function (page) {
      var view = new Jot.Views.Container({ model: page }, { el: that.$rootEl })
      that._renderView(view);
    })
  },

  _getPage: function (urlFragment, callback) {
    var page = Jot.pages.findWhere({ url_fragment: urlFragment })
    if (!page) {
      page = new Jot.Models.Page();
      page.set("url_fragment", urlFragment);
      page.fetch({
        success: function () {
          Jot.pages.add(page);
          callback(page);
        }
       })
    } else {
      callback(page);
    }
  },

  _renderView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    view.render();
   }

});
