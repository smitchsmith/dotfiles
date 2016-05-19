Jot.Collections.Comments = Backbone.Collection.extend({

  initialize: function (models, options) {
    this.page = options.page;
  },

  model: Jot.Models.Comment,

  url: "/comments",

  comparator: function (model1, model2) {
    if (model1.get("created_at") > model2.get("created_at")) {
      return -1
    } else if (model1.get("created_at") == model2.get("created_at")) {
      return 0
    } else {
      return 1
    }
  }

});
