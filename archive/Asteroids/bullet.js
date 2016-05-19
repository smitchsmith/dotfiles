(function (root) {
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  var MovingObject = Asteroids.MovingObject
  var Asteroid = Asteroids.Asteroid

  var Bullet = Asteroids.Bullet = function(pos,vel){
    MovingObject.call(this, pos, calcVel(vel), this.RADIUS, this.COLOR)
  }

  Bullet.inherits(MovingObject);

  Bullet.SPEED = 20
  Bullet.prototype.COLOR = "white";
  Bullet.prototype.RADIUS = 5;

  var calcVel = function(vel){
    var shipSpeed = Math.sqrt((vel[0] * vel[0]) + (vel[1] * vel[1]));
    var multiplier = Bullet.SPEED/shipSpeed;
    return [multiplier * vel[0], multiplier * vel[1]];
  }

  var calcPos = function(pos){
    var shipSpeed = Math.sqrt((vel[0] * vel[0]) + (vel[1] * vel[1]));
    var multiplier = Bullet.SPEED/shipSpeed;
    return [multiplier * vel[0], multiplier * vel[1]];
  }

  Bullet.prototype.hitAsteroids = function(asteroids) {
    for (var i = 0; i < asteroids.length; i++){
      if (this.isCollidedWith(asteroids[i])){
       return i
      }
    }

  }

})(this);