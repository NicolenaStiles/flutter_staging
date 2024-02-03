import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flutter/material.dart';

import '../asteroids.dart';

class DragTest extends PositionComponent 
  with DragCallbacks, HasGameRef<Asteroids> {

  DragTest({
    required this.radius,
    required super.position,
  });

  final double radius;

  @override 
  Future<void> onLoad() async {
    super.onLoad();
  }

 final _paint = Paint()
    ..color = const Color.fromARGB(255, 255, 0, 0)
    ..style = PaintingStyle.stroke;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(position.x, position.y), radius, _paint);
  }
 

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position = position + event.localDelta;
  }

}
