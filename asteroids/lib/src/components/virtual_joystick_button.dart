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
    required this.outerRadius,
  }) : super (
    radius : radius,
    anchor : Anchor.center,
    paint: Paint() 
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0
        ..color = Colors.cyan);

  final double outerRadius;
  double dist = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    initalPosition.x = position.x;
    initalPosition.y = position.y;
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
  void render(canvas) {
    super.render(canvas);
    if (_isDragged) {
      if (dist > outerRadius) {
        paint.color = Colors.red;
      } else {
        paint.color = Colors.green;
      }
    } else {
      paint.color = Colors.cyan;
    }
  }

  @override
  void update(dt) {
    super.update(dt);
    dist = initalPosition.distanceTo(position);
    game.oldPos.text = initalPosition.toString();
    game.newPos.text = position.toString();
    game.dist.text = dist.toString();
  }

}

