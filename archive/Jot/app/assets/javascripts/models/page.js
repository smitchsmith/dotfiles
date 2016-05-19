Jot.Models.Page = Backbone.Model.extend({

  urlRoot: '',

  url: function() {
    return this.get("url_fragment")
  },

  parse: function (response, options) {
    this.syntax = Jot.syntaxes.get(response.syntax_id)
    this.versions = this.versions || new Jot.Collections.Versions(response.versions, { page: this });
    this.comments = this.comments || new Jot.Collections.Comments(response.comments, { page: this });
    this.binaries = this.binaries || new Jot.Collections.Binaries(response.binaries, { page: this });
    return response;
  }

});