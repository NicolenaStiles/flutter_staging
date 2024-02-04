import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';
import 'virtual_joystick_base.dart';

class VirtualJoystickButton extends CircleComponent 
  with DragCallbacks, HasGameRef<Asteroids> {

  bool _isDragged = false;

  Vector2 initalPosition = Vector2.zero();

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
  double ang = 0;

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
    Vector2 nextMove =  position + event.localDelta;
    double nextDist = initalPosition.distanceTo(nextMove);
    double testAng = initalPosition.angleToSigned(position + event.localDelta) * (180 / pi);
    game.ang.text = testAng.toString();
    if (nextDist <= outerRadius) {
      position += event.localDelta;
    } else {
      //initalPosition.angleTo(nextMove);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
    // smooooooth return to center effect
    add(MoveToEffect(
      Vector2(
        initalPosition.x,
        initalPosition.y,
      ),
      EffectController(duration: 0.1),
    ));

  }

  @override 
  void render(canvas) {
    super.render(canvas);
    if (_isDragged) {
      paint.color = Colors.green;
    } else {
      paint.color = Colors.cyan;
    }
  }

  @override
  void update(dt) {
    super.update(dt);
    Vector2 basePos = game.findByKeyName<VirtualJoystickBase>('jbase')!.position;
    dist = position.distanceTo(basePos);
    ang = basePos.angleTo(position);
    game.dist.text = 'Distance: $dist';
    game.ang.text = 'Angle: $ang';
  }

}

