(function(root){

  var PT = root.PT = (root.PT || {});

  var PhotoFormView = PT.PhotoFormView = function() {
    this.$el = $("<div></div>");
    var that = this

    this.$el.on("submit", "form", function(event) {
      event.preventDefault();
      var formData = $(this).serializeJSON();
      that.submit(formData);
    })
  };

  PhotoFormView.prototype.render = function() {
    this.$el.append(JST["photo_form"]());

    return this.$el;
  };

  PhotoFormView.prototype.submit = function(formData) {
    var that = this

    var photo = new PT.Photo (formData.photo);

    // var log = function (thing) {
    //   console.log(thing);
    // };

    photo.save(function(res) {

    });
  }


})(this);