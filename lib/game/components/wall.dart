import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Wall extends RectangleComponent {
  Wall({
    required Vector2 position,
    required Vector2 size,
    required Color color,
  }) : super(
    position: position,
    size: size,
    paint: Paint()..color = color,
  );
}