import 'package:flame/components.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class VirtualJoystickBase extends PositionComponent 
  with HasGameRef<Asteroids> {

  VirtualJoystickBase({ 
    required super.key,
    required this.radius,
    required super.position
  }) {
    super.size = Vector2(radius * 2, radius * 2);
    super.anchor = Anchor.center;
    super.priority = 2;
  }

  final double radius;

  final _paint = Paint() 
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = Colors.cyan;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(radius, radius), radius, _paint);
  }

}
