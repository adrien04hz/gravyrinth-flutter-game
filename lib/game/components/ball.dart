import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent {
  Ball({
    required Vector2 position,
    required double radius,
  }) : super (
    position: position,
    radius: radius,
    paint: Paint()..color = Colors.orange,
    anchor: Anchor.center,
  );

  Vector2 velocity = Vector2.zero();

  @override
  void update( double dt ) {
    super.update( dt );

    position += velocity * dt;
  }
}