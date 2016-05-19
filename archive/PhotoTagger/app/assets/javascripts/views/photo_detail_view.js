(function(root) {

  var PT = root.PT = (root.PT || {});
  var PhotoDetailView = PT.PhotoDetailView = function (photo) {
    var that = this;
    this.$el = $("<div></div>");
    this.photo = photo;
    this.$el.on("click", "img", function (event) {
      that.popTagSelectView(event);
      alert("You clicked me!");
    });
  };

  PhotoDetailView.prototype.render = function () {
    this.$el.append(JST["photo_detail"]({photo: this.photo.attributes}));
    return this.$el;
  };

  PhotoDetailView.prototype.popTagSelectView = function (event) {
    console.log(event.offsetX, event.offsetY);
  };

})(this)