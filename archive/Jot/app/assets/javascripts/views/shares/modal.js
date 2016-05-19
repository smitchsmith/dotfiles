Jot.Views.ShareModal = Backbone.View.extend({

  initialize: function () {
    this.$el = Jot.modal_$el;
  },

  events: {
    "ajax:success" : "render",
    "click #close_modal" : "hideModal"
  },

  render: function () {
    var that = this;
    $.ajax(this.model.get("url_fragment") + "/shares", {success: function (response) {
      that.$el.html(response);
      that.$el.removeClass("hidden");
      that.$("div").first().prepend('<img id="close_modal" src="assets/plus.png">');
    }})
    return this;
  },

  hideModal: function (event) {
    this.$el.addClass("hidden");
  }

});