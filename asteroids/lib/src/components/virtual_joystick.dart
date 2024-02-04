import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class VirtualJoystick extends PositionComponent 
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  Vector2 _initalPosition = Vector2.zero();
  Vector2 _newPosition = Vector2.zero();

  VirtualJoystick({
    required this.innerRadius,
    required this.outerRadius,
    required super.position,
  }) {
    _initalPosition = Vector2(position.x, position.y);
  }

  final double innerRadius;
  final double outerRadius;


  final _paintInner = Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 2.0
        ..color = Colors.cyan;

  final _paintOuter = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = Colors.cyan;

  @override 
  Future<void> onLoad() async {
    super.onLoad();
  }

  // TODO: this moves the entire component, and I only wanna move the inner one
  // Maybe I record the initial summon location coordinates somewhere and save those?

  // TODO: isDragged is not actually used here
  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    _newPosition = position + event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(_newPosition.x, _newPosition.y), innerRadius, _paintInner);
    canvas.drawCircle(const Offset(0.0, 0.0), outerRadius, _paintOuter);
  }
 
  /*
  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position = position + event.localDelta;
  }
  */

}
