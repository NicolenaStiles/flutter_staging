import 'package:flame/components.dart';

import 'package:flutter/material.dart';

class VirtualButton extends PositionComponent {

  VirtualButton({
    required this.cornerRadius,
    required super.key,
    required super.size,
    required super.position,
  }) : super ( 
    anchor: Anchor.center,
  );

  final Radius cornerRadius;
  bool isPressed = false;

  final _paintInactive = Paint() 
    ..color = Colors.cyan
    ..style = PaintingStyle.stroke;

  final _paintActive = Paint() 
    ..color = Colors.cyan
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isPressed) {
      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Offset.zero & size.toSize(),
            cornerRadius,
          ),
          _paintActive);
    } else {
      canvas.drawRRect(
          RRect.fromRectAndRadius(
            Offset.zero & size.toSize(),
            cornerRadius,
          ),
          _paintInactive);

    }
  }
}
