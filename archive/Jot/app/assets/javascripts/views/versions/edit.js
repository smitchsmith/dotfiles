Jot.Views.EditVersion = Backbone.View.extend({

  template: JST['versions/edit'],

  attributes: {
    id: "version"
  },

  events: {
    "focus #text textarea" : "autoSaveOn",
    "blur #text textarea" : "handleBlur"
  },

  render: function () {
    this.checkSyntax();

    if (this.$el.is(':empty')) {
      this.$el.html(this.template({ version: this.model }));
    }

    if (this.syntax.get("highlighting") === "plaintext") {
      this.$el.html(this.template({ version: this.model }));
      this.removeCodeMirror();
    } else {
      this.removeCodeMirror();
      this.addCodeMirror();
      this.CodeMirror.setValue(this.model.get("body"));
    }
    return this;
  },

  postInitialRender: function () {
    (this.CodeMirror && this.CodeMirror.refresh())
  },

  handleBlur: function (event) {
    window.clearInterval(this.intervalId);
    this.saveBody();
  },

  saveBody: function () {
    var body = this.pullBody()
    if (body === this.model.get("body")) {
      return
    }

    this.model = new Jot.Models.Version();
    var that = this;

    this.checkId();
    if (this.model.get("page_id")) {
      this.model.set("body", body)
      this.model.save({}, {success: function () {
        that.collection.add(that.model);
      }});
    } else {
      alert('Give Jot a title!')
    }
  },

  pullBody: function () {
    return (this.CodeMirror ? this.CodeMirror.doc.getValue() : this.$("#text textarea").val())
  },

  changeModel: function (model) {
    this.model = model;
    return this;
  },

  addCodeMirror: function () {
    if (!this.CodeMirror) {
      var textarea = this.$("#jot_body").get(0)
      this.CodeMirror = CodeMirror.fromTextArea(textarea, {
        lineNumbers: true,
        mode: this.syntax.get("highlighting"),
        matchBrackets: true
      });
    }
  },

  removeCodeMirror: function () {
    (this.CodeMirror && this.CodeMirror.toTextArea())
    this.CodeMirror = null;
  },

  checkSyntax: function () {
    this.syntax = this.model.collection.page.syntax ||
      Jot.syntaxes.findWhere({ highlighting: "plaintext" })
  },

  checkId: function () {
    this.model.set("page_id", this.collection.page.id);
  },

  autoSaveOn: function (event) {
    this.intervalId = window.setInterval(this.saveBody.bind(this), 5000);
  }

});
