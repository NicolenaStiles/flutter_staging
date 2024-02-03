import 'package:flame/game.dart';

class GameCfg {

  // (optional) arguments
  double screenX = 0;
  double screenY = 0;

  // common
  int respawnTimer = 30; 
  int playerLives = 3;
  
  static const int largeAsteroidPoints = 200;
  static const int mediumAsteroidPoints = 100;
  static const int smallAsteroidPoints = 50;

  // TODO: change this into an upper and lower bound instead
  static double asteroidSpeed = 120.0;

  // shared
  double playerWidth = 36;
  double playerHeight = 60;

  double playerRotationSpeed = 4; 
  Vector2 playerAcceleration = Vector2(4,4);      // untested
  int playerMaxSpeed = 400;                       // untested

  double livesWidth = 30;
  double livesHeight = 50;
  double livesOffset = 6;

  double fontSize = 48.0;

  // mobile scalars
  static double playerShipMobileScalar = 16;
  static double livesMobileScalar = 32;

  // asteroids
  
  // Desktop constructor
  GameCfg.desktop();

  // Mobile constructor
  GameCfg.mobile(this.screenX, this.screenY) {
    // player height/width
    double shipHeight = (screenY / playerShipMobileScalar);
    double shipWidth = (playerWidth * shipHeight) / playerHeight;
    playerWidth = shipWidth;
    playerHeight = shipHeight;

    // lives display height/width
    shipHeight = (screenY / livesMobileScalar);
    shipWidth = (livesWidth * shipHeight) / livesHeight;
    double shipOffset = shipWidth / 2; // TODO: check if this makes any sense
    livesWidth = shipWidth;
    livesHeight = shipHeight;
    livesOffset = shipOffset;

    // font size for scoreboard
    fontSize = screenY / 16;
  }
}
  const double largeAsteroidMobileScalar = 8;
  const double mediumAsteroidMobileScalar = 16;
  const double smallAsteroidMobileScalar = 32;

   const int largeAsteroidPoints = 200;
   const int mediumAsteroidPoints = 100;
   const int smallAsteroidPoints = 50;

  // TODO: change this into an upper and lower bound instead
   double asteroidSpeed = 120.0;

  // shared
  double playerWidth = 36;
  double playerHeight = 60;

  double livesWidth = 30;
  double livesHeight = 42;
  double livesOffset = 8;

  // mobile scalars
   double playerShipMobileScalar = 16;

const int respawnTimer = 30;
const int playerLives = 3;

// player settings
double playerRotationSpeed = 4; 
Vector2 playerAcceleration = Vector2(4,4);      // untested
int playerMaxSpeed = 400;                       // untested

// shot
const double shotRadiusDesktop = 4;
const double shotSpeed = 600;        // how fast bullets go
const double shotTimer = 100;        // how long bullets live
const double shotCooldown = 64;      // how long until shoot bullets

// asteroids
const double largeAsteroidDesktop = 128.0; 
const double mediumAsteroidDesktop = 64.0; 
const double smallAsteroidDesktop = 32.0; 

// alien
// WARN : I pulled these numbers out of my ass
const alienWidthDesktop = 60;
const alienHeightDesktop = 36;

// I'm doing powers of 2 here
// only tested on desktop
const double asteroidMinVelocity = 32;
const double asteroidMaxVelocity = 256;

