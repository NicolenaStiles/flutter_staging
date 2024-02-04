import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class VirtualJoystick extends PositionComponent 
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  Vector2 initalPosition = Vector2.zero();
  Vector2 newPosition = Vector2.zero();

  VirtualJoystick({
    required super.key,
    required this.innerRadius,
    required this.outerRadius,
    required super.position,
  }) {
    super.size = Vector2(outerRadius * 2, outerRadius * 2);
    super.anchor = Anchor.center;
    initalPosition = Vector2(position.x, position.y);
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

  /*
  @override
  bool containsLocalPoint(Vector2 point) {

  }
  */

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
    canvas.drawCircle(Offset(outerRadius, outerRadius), innerRadius, _paintInner);
    canvas.drawCircle(Offset(outerRadius, outerRadius), outerRadius, _paintOuter);
  }

  @override
  void update(dt) {
    super.update(dt);
    game.oldPos.text = initalPosition.toString();
    game.newPos.text = newPosition.toString();
  }
 
  /*
  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position = position + event.localDelta;
  }
  */

}