import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent {
  Ball({
    required Vector2 position,
    required double radius,
    required Color color,
  }) : super (
    position: position,
    radius: radius,
    paint: Paint()..color = color,
    anchor: Anchor.center,
  );

  Vector2 velocity = Vector2.zero();
}