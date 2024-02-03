import 'dart:async';

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

// general flutter packages
import 'package:flutter/material.dart';

// player, asteroid, shot 
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;

game_settings.GameCfg testCfg = game_settings.GameCfg.desktop();

class MobileAsteroids extends FlameGame
  with KeyboardEvents, HasCollisionDetection {
  bool isMobile;
  MobileAsteroids(this.isMobile);

  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = 0;

  // displaying score
  static TextComponent scoreboard = TextComponent();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    // populate config object with appropriate settings
    if (!isMobile) {
      testCfg = game_settings.GameCfg.desktop();
    } else {
      testCfg = game_settings.GameCfg.mobile(width, height);
    }

    // be sure to set defaults here first!!
    lives = testCfg.playerLives;

    layoutDebug();
  }

  void layoutDebug() {
    // HUD stuff: scoreboard and lives tracker
    
    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      size : Vector2(testCfg.playerWidth, testCfg.playerHeight),
      shipType: ShipType.player,
    ));

    // scoreboard
    TextStyle scoreStyle = TextStyle(color: Colors.white, 
                                     fontSize: testCfg.fontSize, 
                                     fontFamily: 'Hyperspace');
    final scoreRenderer = TextPaint(style: scoreStyle);

    // score 
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0,0));
    world.add(scoreboard);

    // lives tracker
    for (int n = 0; n < lives; n++) {
      String lifeKey = "life$n";
      double xPos = width - (((n + 1) * testCfg.livesOffset) 
                                 + (n * testCfg.livesWidth) 
                                 + (testCfg.livesWidth / 2));
      double yPos = testCfg.livesOffset + (testCfg.livesHeight / 2);
      world.add(
        Player(
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, yPos),
          size : Vector2(testCfg.livesWidth, testCfg.livesHeight),
          shipType: ShipType.lives,
        )
      );
    }
  }

  // layout all the assets to determine if screen sizing is trash or not
  /*
  void layoutDebug() {

    for (var j = 3; j > 0; j--) {
      Vector2 asteroidPos = Vector2(0, 0);
      asteroidPos.y = (j / 5) * size.y;
      for (var i = 1; i < 4; i++) {
        asteroidPos.x = (i / 4) * size.x;
        world.add(Asteroid(
          isMobile: true,
          objType: AsteroidType.values[i - 1],
          objSize: AsteroidSize.values[j - 1],
          velocity: 0,
          position: asteroidPos, 
          angle: 0,
        ));
      }
    }

    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    world.add(Player(
      isMobile: true,
      key: ComponentKey.named('player'),
      position: shipPos,
      shipType: ShipType.player,
    ));
    
    // double testFontSize = 48.0; 
    double testFontSize = 32.0; 
      
    // TODO: you were here, figure out what to do with
    // scoreboard and lives tracker for HUD
    // TODO: break out HUD init into seperate function?

    // scoreboard
    TextStyle scoreStyle = TextStyle(color: Colors.white, 
                                     fontSize: testFontSize, 
                                     fontFamily: 'Hyperspace');
    final scoreRenderer = TextPaint(style: scoreStyle);

    // score 
    String formattedScore = score.toString().padLeft(4, '0');
    scoreboard = TextComponent(
        key: ComponentKey.named('scoreboard'),
        text: formattedScore, 
        textRenderer: scoreRenderer,
        anchor: Anchor.topLeft,
        position: Vector2(0,0));
    world.add(scoreboard);

    // lives
    for (int n = 0; n < lives; n++) {
      String lifeKey = "life$n";
      double xPos = canvasSize.x - (((n + 1) * game_settings.livesOffset) 
                                 + (n * game_settings.livesWidth) 
                                 + (game_settings.livesWidth / 2));
      world.add(
        Player(
          isMobile: true,
          key: ComponentKey.named(lifeKey),
          position: Vector2(xPos, 
                            game_settings.livesOffset 
                              + (game_settings.livesHeight / 2)),
          shipType: ShipType.lives,
        )
      );
    }
  }
  */
}
