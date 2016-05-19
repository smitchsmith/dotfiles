(function (root) {
  var Asteroids = root.Asteroids = (root.Asteroids || {});
  var MovingObject = Asteroids.MovingObject
  var Asteroid = Asteroids.Asteroid
  var Ship = Asteroids.Ship

  var Game = Asteroids.Game = function(canvasEl, background){
    this.ctx = canvasEl.getContext("2d");
    this.background = background
    this.asteroids = [];
    this.addAsteroids(20);
    this.ship = new Ship();
    this.bullets = [];
    this.timerId = null;
    this.bindKeyHandlers();
  }

  Game.prototype.DIM_X = 600;
  Game.prototype.DIM_Y = 450;

  Game.prototype.bindKeyHandlers = function(){
    key('q', this.togglePause.bind(this));
    key('up', this.ship.power.bind(this.ship, [0,-1]));
    key('down', this.ship.power.bind(this.ship, [0,1]));
    key('left', this.ship.power.bind(this.ship, [-1,0]));
    key('right', this.ship.power.bind(this.ship, [1,0]));
    key('space', this.fireBullet.bind(this));
  }

  Game.prototype.addAsteroids = function(numAsteroids){
    for(var i = 0; i < numAsteroids; i ++){
      this.asteroids.push(Asteroid.randomAsteroid(this.DIM_X, this.DIM_Y))
    }
  }

  Game.prototype.fireBullet = function(){
    var bullet = this.ship.fireBullet();
    if (bullet) {
      this.bullets.push(bullet);
    }
  }

  Game.prototype.draw = function(){
    this.ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    this.ctx.drawImage(this.background, 0, 0);

    for (var i = 0; i < this.asteroids.length; i++){
      this.asteroids[i].draw(this.ctx);
    }
    this.ship.draw(this.ctx);
    for (var i = 0; i < this.bullets.length; i++){
      this.bullets[i].draw(this.ctx);
    }
  }

  Game.prototype.move = function(){
    for (var i = 0; i < this.asteroids.length; i++){
      this.asteroids[i].move();
    }

    this.ship.move();

    for (var i = 0; i < this.bullets.length; i++){
      this.bullets[i].move();
    }
  }

  Game.prototype.checkCollisions = function(){
    for(var i = 0; i< this.asteroids.length; i++){
      if(this.asteroids[i].isCollidedWith(this.ship)){
        alert("Game over!");
        this.stop();
      }
    }
  }

  Game.prototype.step = function(){
    this.move();
    this.draw();
    this.checkCollisions();
    this.bulletHitAsteroids();
    this.cleanUp();
    if (this.asteroids.length === 0) {
      alert("You won!");
      this.stop();
    }
  }

  Game.prototype.start = function(){
    this.timerId = setInterval(this.step.bind(this), 30);
  }

  Game.prototype.stop = function(){
    clearInterval(this.timerId);
    this.timerId = null;
  }

  Game.prototype.togglePause = function(){
    if (this.timerId === null){
      this.start();
    } else{
      this.stop();
    }
  }

  Game.prototype.bulletHitAsteroids = function(){
    for (var i = 0; i < this.bullets.length; i++){
      var asteroidIndex = this.bullets[i].hitAsteroids(this.asteroids);
      if (asteroidIndex || asteroidIndex === 0) {
        this.removeAsteroid(asteroidIndex);
        this.removeBullet(i);
      }
    }
  }

  Game.prototype.removeAsteroid = function(i){
    var result = [];
    for(var j = 0; j < this.asteroids.length; j ++){
      if(j !== i){
        result.push(this.asteroids[j]);
      }
    }
    this.asteroids = result;
  }

  Game.prototype.removeBullet = function(i){
    var result = [];
    for(var j = 0; j < this.bullets.length; j ++){
      if(j !== i){
        result.push(this.bullets[j]);
      }
    }
    this.bullets = result;
  }

  Game.prototype.isOutOfBounds = function(obj){
    return (obj.pos[0] < 0 || obj.pos[0] > this.DIM_X ||
     obj.pos[1] < 0 || obj.pos[1] > this.DIM_Y)
  }

  Game.prototype.cleanUp = function(){
    for(var i = 0; i < this.bullets.length; i ++){
      if (this.isOutOfBounds(this.bullets[i])) {
        this.removeBullet(i);
      }
    }

    for(var i = 0; i < this.asteroids.length; i ++){
      if (this.isOutOfBounds(this.asteroids[i])) {
        wrapObject(this.asteroids[i]);
      }
    }

    if (this.isOutOfBounds(this.ship)) {
      wrapObject(this.ship);
    }

  }

  var wrapObject = function(object){
    if (object.pos[0] < 0){
      object.pos[0] += Game.prototype.DIM_X;
    } else if (object.pos[0] > Game.prototype.DIM_X){
      object.pos[0] -= Game.prototype.DIM_X;
    }

    if (object.pos[1] < 0) {
      object.pos[1] += Game.prototype.DIM_Y;
    } else if (object.pos[1] > Game.prototype.DIM_Y){
      object.pos[1] -= Game.prototype.DIM_Y;
    }
  }

})(this);