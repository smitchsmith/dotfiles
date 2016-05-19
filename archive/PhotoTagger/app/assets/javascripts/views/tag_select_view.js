(function(root) {
  var PT = root.PT = (root.PT || {});
  var TagSelectView = PT.TagSelectView = function (photo, event) {
    this.photo = photo;
    this.event = event;
    $el = $("<div></div>");
  };

  TagSelectView.prototype.render = function () {
    this.$el.empty();
    var $div = $("<div class='photo-tag'></div>");



    this.$el.append($div);
  };


})