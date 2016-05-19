(function(root){

  var PT = root.PT = (root.PT || {});

  var Photo = PT.Photo = function (obj) {
    this.attributes = obj;
  };

  Photo.all = [];

  Photo.find = function(photoId) {
    var result = null

    _.each(Photo.all, function(ele) {
      if (ele.attributes.id === parseInt(photoId)) {
         result = ele;
       };
    });

    return result;
  };

  Photo.prototype.get = function(attr_name) {
    return this.attributes[attr_name];
  };

  Photo.prototype.set = function(attr_name, val) {
    return this.attributes[attr_name] = val;
  };

  Photo.prototype.create = function(callback) {
    var that = this;
    $.ajax({
      url: "/api/photos",
      type: "POST",
      data: {photo: that.attributes},

      success: function (res, status) {
        _.extend(that.attributes, res);
        Photo.all.push(that);
        callback(res);
        Photo.trigger("add");
      }
    });
  };

  Photo.prototype.save = function(callback) {

    var that = this.attributes;

    if (that.id) {
      $.ajax({
        url: "/api/photos/" + that.id,
        type: "PUT",
        data: {photo: that},

        success: function (res, status) {
          callback(res);
        }
      });
    } else {
      this.create(callback);
    };

  };

  Photo.fetchByUserId = function (userId, callback) {
    var result = [];

    $.ajax({
      url: "/api/users/" + userId + "/photos",
      type: "GET",

      success: function (res, status) {
        _.each(res, function(ele) {
          result.push(new Photo(ele));
        });
        callback(result);
      }
    })
  };

  Photo._events = {};

  Photo.on = function (eventName, callback) {
    if (this._events[eventName] == null) {
      this._events[eventName] = [];
    };
    this._events[eventName].push(callback);
  };

  Photo.trigger = function (eventName) {
    if (this._events[eventName] !== null) {
      _.each(this._events[eventName], function (ele) {
        ele();
      });
    };
  };
})(this);