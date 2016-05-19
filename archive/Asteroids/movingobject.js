(function (root) {
  var Asteroids = root.Asteroids = (root.Asteroids || {});

  var MovingObject = Asteroids.MovingObject = function(pos, vel, radius, color) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
  }

  MovingObject.prototype.move = function(){
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
  }

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  }

  MovingObject.prototype.isCollidedWith = function(otherObject){
    var distance = Math.sqrt(Math.pow((this.pos[0] - otherObject.pos[0]), 2) +
    Math.pow((this.pos[1] - otherObject.pos[1]), 2));

    return ((this.radius + otherObject.radius) > distance)
  }

  Function.prototype.inherits = function(parent){
    function Surrogate (){};
    Surrogate.prototype = parent.prototype;
    this.prototype = new Surrogate();
  }

})(this);