Jot.Views.Container = Backbone.View.extend({

  initialize: function (model, options) {
    this.$el = options.el;
  },

  events: {
    "change #version_dropdown" : "swapVersionByEvent",
    "change #syntax_highlighting" : "handleSyntax",
    "submit #closest_jot" : "fetchClosestJot"
  },

  render: function () {
    this.$el.append($("#header"))

    this.sidebar_view = new Jot.Views.Sidebar({ model: this.model })
    this.$el.append(this.sidebar_view.render().$el);

    this.main_view = new Jot.Views.EditJot({ model: this.model })
    this.$el.append(this.main_view.render().$el);
    this.main_view.page_view.version_edit.postInitialRender();

    return this;
  },

  swapVersionByEvent: function (event) {
    var version_id = $(event.target).find(":selected").attr("data-id");
    var version = this.model.versions.get(version_id);
    this.swapVersion(version);
  },

  swapVersion: function (version) {
    this.main_view.page_view.version_edit.changeModel(version).render();
  },

  handleSyntax: function (event) {
    var syntax_id = $(event.target).find(":selected").attr("data-id");
    syntax_id = parseInt(syntax_id);
    var syntax = Jot.syntaxes.get(syntax_id);

    this.model.syntax = syntax;
    var that = this;
    this.model.save({ syntax_id: syntax_id }, {success: function () {
      that.main_view.page_view.version_edit.render();
    }});
  },

  fetchClosestJot: function (event) {
    event.preventDefault();
    var close_time = $(event.target[0]).val();
    // var version = new Jot.Models.Version({ created_at: close_time });
    // version.fetchClosest();
    var version = this.model.versions.getClosest(close_time);
    this.swapVersion(version);
    this.sidebar_view.$("#version_dropdown").val(version.id);
  }

});

