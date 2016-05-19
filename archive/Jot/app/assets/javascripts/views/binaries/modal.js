Jot.Views.BinariesModal = Backbone.View.extend({

  initialize: function () {
    this.$el = Jot.modal_$el;
  },

  events: {
    "submit #upload_file" : "uploadBinary",
    "click #close_modal" : "hideModal"
  },

  template: JST['binaries/modal'],

  render: function () {
    this.$el.html(this.template());
    this.$("div").first().prepend('<img id="close_modal" src="assets/plus.png">');
    this.$el.removeClass("hidden");
    return this;
  },

  uploadBinary: function (event) {
    event.preventDefault();
    var that = this;
    var binary = new Jot.Models.Binary;

    var formData = new FormData();
    formData.append('file', event.target[1].files[0])
    formData.append('title', event.target[0].value || event.target[1].files[0].name )
    formData.append('page_id', this.collection.page.id)

    binary.save(null, {
      data: formData,
      contentType: false,
      processData: false,
      success: function () {
        that.collection.add(binary);
        that.hideModal();
      }
    })
  },

  hideModal: function () {
    this.$el.addClass("hidden");
  }

});