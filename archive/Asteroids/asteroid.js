(function (root) {
  var Asteroids = root.Asteroids = (root.Asteroids || {});

  var MovingObject = Asteroids.MovingObject

  var Asteroid = Asteroids.Asteroid = function(pos, vel){
    MovingObject.call(this, pos, vel, this.RADIUS, this.COLOR);
  }

  Asteroid.inherits(MovingObject);

  Asteroid.prototype.COLOR = "grey";
  Asteroid.prototype.RADIUS = 10;
  Asteroid.MAXVEL = 3;

  Asteroid.randomAsteroid = function(dimX, dimY){
    var x = Math.floor(Math.random() * dimX)
    var y = Math.floor(Math.random() * dimY)
    var vel = randomVelocity(Asteroid.MAXVEL);
    return new Asteroid([x, y], vel);
  }

  var randomVelocity = function(max){
    var velX = Math.random() * max;
    var velY = Math.random() * max;
    return [velX, velY]
  }

})(this);