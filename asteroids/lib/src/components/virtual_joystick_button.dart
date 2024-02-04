import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class VirtualJoystickButton extends CircleComponent 
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  Vector2 initalPosition = Vector2.zero();
  Vector2 newPosition = Vector2.zero();

  VirtualJoystickButton({
    required ComponentKey key,
    required super.position,
    required double radius,
  }) : super (
    radius : radius,
    anchor : Anchor.center,
    paint: Paint() 
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0
        ..color = Colors.cyan);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    initalPosition = position;
  }

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
    position = initalPosition;
  }

  @override
  void update(dt) {
    super.update(dt);
    game.oldPos.text = initalPosition.toString();
    game.newPos.text = position.toString();
  }

}

