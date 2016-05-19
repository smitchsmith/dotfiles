Jot.Views.EditPage = Backbone.View.extend({

  attributes: {
    id: "page"
  },

  render: function () {
    this.title_view = new Jot.Views.PageTitle ({model: this.model});
    this.$el.append(this.title_view.render().$el);

    if (this.model.isNew()) {
      this.privacy_view = new Jot.Views.PagePrivacy ({model: this.model});
      this.$el.append(this.privacy_view.render().$el);
    }

    version = this.model.versions.first() || new Jot.Models.Version ({page_id: this.model.id, number: 1 })
    this.model.versions.add(version); // won't add again
    this.version_edit = new Jot.Views.EditVersion ({ model: version, collection: this.model.versions })
    this.$el.append(this.version_edit.render().$el);

    return this;
  }

});