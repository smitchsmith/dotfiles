(function(root){

  var PT = root.PT = (root.PT || {});

  var PhotoListView = PT.PhotoListView = function() {
    this.$el = $("<div></div>");
    var that = this;

    PT.Photo.on("add", function() {
      that.render();
    });

    this.$el.on("click", "li", function (event) {
      var photoId = $(event.currentTarget).attr("data-id");
      var photo = PT.Photo.find(photoId);
      PT.showPhotoDetail(photo);
    });
  };

  PhotoListView.prototype.showDetail = function(event) {
    event.preventDefault();

  }


  PhotoListView.prototype.render = function () {
    this.$el.empty();
    var $ul = $("<ul></ul>");

    _.each(PT.Photo.all, function(ele){
      $ul.append("<li data-id='" + ele.attributes.id + "'>" +
      "<a href='#'>" +
        ele.attributes.title +
      "</a></li>");
    });

    this.$el.append($ul);
    return this.$el;
  }

  PT.initialize = function() {
    this.showPhotosIndex();
  }

  PT.showPhotosIndex = function () {
    var user_id = JSON.parse($("#currentUserId").html()).id;
    var allPhotos = PT.Photo.fetchByUserId(user_id, function (allPhotos) {
      var view = new PhotoListView ();
      PT.Photo.all = allPhotos;

      var result = view.render();
      $("#content").append(result);
    });
    var newPhoto = new PT.PhotoFormView();
    $("#content").append(newPhoto.render());
  }

  PT.showPhotoDetail = function(photo) {
    var view = new PT.PhotoDetailView (photo);
    console.log(view);
    $("#content").append(view.render());
  }

})(this);