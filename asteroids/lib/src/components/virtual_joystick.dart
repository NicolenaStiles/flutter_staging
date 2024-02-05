import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class VirtualJoystick extends PositionComponent
  with HasVisibility, HasGameRef<Asteroids> {

  // radius determines outer ring size.
  // button radius should be calculated
  VirtualJoystick({ 
    required ComponentKey key,
    required this.radius,
    required super.position,
  }) : super ( 
    size: Vector2(radius * 2, radius * 2),
    anchor: Anchor.center,
    priority: 1,
  );

  final _paint = Paint() 
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0
        ..color = Colors.red;

  final double radius;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(radius,radius), 
        width: width, 
        height: height), _paint);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(
      JoystickBase(
        key: ComponentKey.named('base'), 
        radius: radius, 
        position: Vector2(radius, radius)));

    add( 
      JoystickButton(
        key: ComponentKey.named('button'), 
        radius: radius / 2,
        position: size / 2));
  }
}

class JoystickBase extends PositionComponent 
  with HasGameRef<Asteroids> {

  JoystickBase({ 
    required ComponentKey key,
    required this.radius,
    required super.position
  }) : super( 
    size: Vector2(radius * 2, radius * 2),
    anchor: Anchor.center,
    priority: 2,
  );

  final double radius;

  final _paintBorder = Paint() 
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true
          ..strokeWidth = 5.0
          ..color = Colors.yellow;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(radius, radius), radius, _paintBorder);
  }
}

class JoystickButton extends CircleComponent
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  JoystickButton({ 
    required ComponentKey key,
    required super.radius,
    required super.position,
  }) : super ( 
    anchor: Anchor.center,
    priority: 3,
  );

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
      position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_isDragged) {
      paint.color = Colors.green;
    } else {
      paint.color = Colors.cyan;
    }
  }
}

