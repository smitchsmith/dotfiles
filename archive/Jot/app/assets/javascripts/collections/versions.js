Jot.Collections.Versions = Backbone.Collection.extend({

  initialize: function (models, options) {
    this.page = options.page;
  },

  model: Jot.Models.Version,

  url: "/versions",

  comparator: function (model1, model2) {
    if (model1.get("number") > model2.get("number")) {
      return -1
    } else if (model1.get("number") == model2.get("number")) {
      return 0
    } else {
      return 1
    }
  },

  getClosest: function (datetime) {
    var near = new Date(datetime)
    near = new Date(near.getTime() + ( 300 * 60000))
    var matches = this.select(function (version) {
      var date = new Date(version.get("created_at"))
      return (date < near)
    });
    return matches[0]
  }

});
