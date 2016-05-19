NewReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function (models, options) {
    this.url = "/feeds/" + options.id + "/entries";
  },
  model: NewReader.Models.Entry
});
