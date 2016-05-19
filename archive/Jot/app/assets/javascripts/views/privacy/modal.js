Jot.Views.PrivacyModal = Backbone.View.extend({

  initialize: function () {
    this.$el = Jot.modal_$el;
  },

  template: JST['pages/privacy'],

  events: {
    "ajax:success" : "render",
    "click #close_modal" : "hideModal"
  },

  render: function () {
    var that = this;
    if (this.model.get("password_digest")) {
      $.ajax(this.model.get("url_fragment") + "/change_password", {success: function (response) {
        that.$el.html(response);
        that.$el.removeClass("hidden");
        that.$("div").prepend('<img id="close_modal" src="assets/plus.png">');
      }})
    } else {
      var view = new Jot.Views.PagePrivacy({model: this.model})
      this.$el.html(view.render().$el)
      this.$el.removeClass("hidden");
      this.$("div").prepend('<img id="close_modal" src="assets/plus.png">');
    }
    return this;
  },

  hideModal: function (event) {
    this.$el.addClass("hidden");
  }

});