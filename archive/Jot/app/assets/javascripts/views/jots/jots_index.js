Jot.Views.JotsIndex = Backbone.View.extend({

  template: JST['jots/index'],

  render: function () {
    this.$el.html(this.template());
    return this;
  }

});
