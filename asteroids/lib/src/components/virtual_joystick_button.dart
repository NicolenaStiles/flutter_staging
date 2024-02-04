import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class VirtualJoystickButton extends PositionComponent
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  Vector2 initalPosition = Vector2.zero();
  Vector2 newPosition = Vector2.zero();

  VirtualJoystickButton({
    required super.key,
    required this.radius,
    required super.position,
  }) {
    super.size = Vector2(radius * 2, radius * 2);
    super.anchor = Anchor.center;
    super.priority = 3;
  }

  final double radius;

  final _paint = Paint() 
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0
        ..color = Colors.cyan;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    newPosition = position + event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
  }

  // TODO: using the outer radius for something like this seems weird?
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(radius, radius), radius, _paint);
  }

  @override
  void update(dt) {
    super.update(dt);
    game.oldPos.text = initalPosition.toString();
    game.newPos.text = newPosition.toString();
  }

}

