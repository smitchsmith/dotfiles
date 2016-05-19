Jot.Models.Version = Backbone.Model.extend({
  urlRoot: "/versions",

  fetchClosest: function (options) {
    data = { version: { created_at: this.get("created_at") }}
    _options = { url: this.urlRoot + "/closest", data: data }
    options = options ? options.extend(_options) : _options
    return Backbone.Model.prototype.fetch.call(this, options);
  }
});
