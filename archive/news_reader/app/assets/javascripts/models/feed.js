NewReader.Models.Feed = Backbone.Model.extend({
  parse: function (response, options) {

    var entriesCollection = new NewReader.Collections.Entries(
      response.entries,
      { id: response.id }
    );

    var optionsObject = {
      id: response.id,
      title: response.title,
      updated_at: response.updated_at,
      url: response.url,
      entries: entriesCollection
    };

    return optionsObject;
  }
});
