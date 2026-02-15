import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Goal extends RectangleComponent {
  Goal({
    required Vector2 position,
    required Vector2 size,
  }) : super(
    position: position,
    size: size,
    paint: Paint()..color = Colors.green.withValues( alpha: 0.5 ),
  );
}