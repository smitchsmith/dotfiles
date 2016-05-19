Jot.Views.HelpModal = Backbone.View.extend({

  initialize: function () {
    this.$el = Jot.modal_$el;
  },

  events: {
    "click #close_modal" : "hideModal"
  },

  template: JST['help/modal'],

  render: function () {
    this.$el.html(this.template());
    this.$("div").first().prepend('<img id="close_modal" src="assets/plus.png">');
    this.$el.removeClass("hidden");
    return this;
  },

  hideModal: function () {
    this.$el.addClass("hidden");
  }

});