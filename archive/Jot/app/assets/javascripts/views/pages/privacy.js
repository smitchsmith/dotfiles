Jot.Views.PagePrivacy = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "change:is_public", this.render)
  },

  template: JST['pages/privacy'],

  attributes: {
    id: "privacy"
  },

  events: {
    "click #is_public input" : "togglePublic",
    "click #save_password" : "savePassword"
  },

  render: function () {
    this.$el.html(this.template({ page: this.model }));
    if (!Jot.current_user.id) {
      this.hideIsPublic();
    }
    if (!this.is_public()) {
      this.hidePassword();
    }
    return this;
  },

  is_public: function () {
    return this.model.get("is_public");
  },

  togglePublic: function (event) {
    var that = this;
    this.model.save({ is_public: !that.is_public()});
  },

  savePassword: function (event) {
    var pwd1 = this.$("#password1").val()
    var pwd2 = this.$("#password2").val()
    if (( pwd1 === pwd2 ) && (pwd1.length >= 6) ) {
      var that = this;
      this.model.save({password: pwd1}, {success: function () {
        that.changeSaveIcon("/assets/save_green.png");
        window.setTimeout(that.hidePassword, 1000)
      }});
    } else {
      this.changeSaveIcon("/assets/save_red.png");
    }
  },

  hidePassword: function () {
    this.$("#password").addClass("hidden");
  },

  hideIsPublic: function () {
    this.$("#is_public").addClass("hidden");
  },

  changeSaveIcon: function (src) {
    this.$("#password img").attr("src", src)
  }

});
