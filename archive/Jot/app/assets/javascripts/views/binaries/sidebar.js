Jot.Views.BinariesSidebar = Backbone.View.extend({

  initialize: function (model, options) {
    this.$el = options.el;
    this.listenTo(this.collection, "add remove", this.render);
  },

  events: {
    "click .delete_binary" : "deleteBinary",
    "click #open_upload_modal" : "openUploadModal"
  },

  template: JST['binaries/sidebar'],

  render: function () {
    this.$el.html(this.template({
      binaries: this.collection
    }));
    return this;
  },

  deleteBinary: function (event) {
    event.preventDefault();
    var data_id = $(event.target).attr("data-id");
    var binary = this.collection.get(data_id)
    binary.destroy();
  },

  openUploadModal: function (event) {
    var uploadModal = new Jot.Views.BinariesModal({collection: this.collection})
    uploadModal.render();
  }

});