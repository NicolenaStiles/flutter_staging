import 'dart:async';

// flame game-related stuff
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';

// general flutter packages
import 'package:flutter/material.dart';

// player, asteroid, shot 
import 'components/components.dart';

// configuration
import 'config.dart' as game_settings;

game_settings.GameCfg testCfg = game_settings.GameCfg.desktop();

class MobileAsteroids extends FlameGame
  with TapDetector, HasCollisionDetection {

  // are we running on mobile?
  bool isMobile;
  MobileAsteroids(this.isMobile);

  double get width => size.x;
  double get height => size.y;

  // game stats
  int score = 0;
  int lives = game_settings.playerLives;

  // displaying debug info 
  static TextComponent tapIdsText = TextComponent();
  static TextComponent tapPosText = TextComponent();

  List<String> tapIdsList = [];
  List<String> tapPosList = []; 

  // gesture input
  late final TestJoystick joystick;
  late final HudButtonComponent buttonShoot;
  late final ButtonComponent buttonComponent;

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

    gestureDebug();
  }

  void gestureDebug() {

    // player's ship
    Vector2 shipPos = Vector2(0, 0);
    shipPos.x = size.x * (1/2);
    shipPos.y = size.y * (4/5);
    world.add(Player(
      key: ComponentKey.named('player'),
      position: shipPos,
      size : Vector2(testCfg.playerWidth, testCfg.playerHeight),
      shipType: ShipType.player,
      isMobileGame: true,
    ));

    // Virtual Joystick ('TestJoystick' class)
    final knobPaint = BasicPalette.white.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.white.withAlpha(100).paint();
    joystick = TestJoystick(
      key: ComponentKey.named('joystick'),
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      position: size * (3 / 4),
    );
    joystick.isVisible = false;
    world.add(joystick);

    // margin for world
    /*
    HudMarginComponent testMargin = HudMarginComponent( 
      margin: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
    );
    add(testMargin);
    */

    // HUD button component
    final buttonUp = BasicPalette.white.withAlpha(200).paint();
    final buttonDown = BasicPalette.gray.withAlpha(200).paint();
    buttonShoot = HudButtonComponent( 
      priority: 1,
      button: CircleComponent(
        radius: 50, 
        paint: buttonUp, 
      ),
      buttonDown: CircleComponent( 
        radius: 50,
        paint: buttonDown,
      ),
      size: Vector2(100, 100),
      margin: const EdgeInsets.only(
        left:  20, 
        bottom: 20
      ),
      onPressed: () {print('hi');},
    );
    add(buttonShoot);

    
    // A button, created from a shape, that adds a scale effect to the player
    // when it is pressed.
    buttonComponent = ButtonComponent(
      button: RectangleComponent(
        size: Vector2(185, 50),
        paint: Paint()
          ..color = Colors.orange
          ..style = PaintingStyle.stroke,
      ),
      buttonDown: RectangleComponent(
        size: Vector2(185, 50),
        paint: BasicPalette.magenta.paint(),
      ),
      position: Vector2(20, 300),
      onPressed: () {
        print('button press!');
      }
    );
    world.add(buttonComponent);
    
    // debug info
    tapIdsText = TextComponent(
        key: ComponentKey.named('tapIds'),
        text: tapIdsList.toString(), 
        anchor: Anchor.topCenter,
        position: Vector2(width / 2, 0));
    world.add(tapIdsText);

    tapPosText = TextComponent(
        key: ComponentKey.named('tapPos'),
        text: tapPosList.toString(), 
        anchor: Anchor.topCenter,
        position: Vector2(width / 2, 40));
    world.add(tapPosText);
  }
  
  // handling tap events
  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (!buttonComponent.containsPoint(info.eventPosition.widget)) {
      joystick.position = info.eventPosition.widget;
      joystick.isVisible = true;
    }
  }

  @override
  void onTapCancel() {
    super.onTapCancel();
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    if (!buttonComponent.containsPoint(info.eventPosition.widget)) {
      joystick.isVisible = false;
    }
  }
  /*
  @override 
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    if (!buttonComponent.containsPoint(info.eventPosition.widget)) {
      joystick.position = info.eventPosition.widget;
      joystick.isVisible = true;
    }
      /*
     if (!buttonShoot.containsPoint(info.eventPosition.widget)) {
      joystick.position = info.eventPosition.widget;
      joystick.isVisible = true;
    } else {
      findByKeyName<Player>('player')!.fireShot = true; 
    }
    tapIdsList.add(pointerId.toString());
    //tapPosList.add(info.eventPosition.widget.toString());
    */
  }

  @override
  void onTapCancel(int pointerId) {
    super.onTapCancel(pointerId);
    tapIdsList.remove(pointerId.toString());
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    if (buttonShoot.containsPoint(info.eventPosition.widget)) {
      findByKeyName<Player>('player')!.fireShot = false; 
    }
    tapIdsList.remove(pointerId.toString());
    //tapPosList.remove(info.eventPosition.widget.toString());
  }
  */

  // main gameplay loop
  @override 
  void update(double dt) {
    super.update(dt);
    tapIdsText.text = tapIdsList.toString();
    tapPosText.text = tapPosList.toString();
  }


}
