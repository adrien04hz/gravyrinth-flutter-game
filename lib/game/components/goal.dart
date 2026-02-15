import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Goal extends PositionComponent {
  final Paint _fillPaint = Paint();
  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  double _time = 0;

  Goal({
    required Vector2 position,
    required Vector2 size,
  }) {
    this.position = position;
    this.size = size;
  }

  @override
  void update(double dt) {
    super.update(dt);

    _time += dt;

    // Destello interno (alpha variable)
    final alpha = 0.5 + 0.3 * sin(_time * 1.5);
    _fillPaint.color =
        Colors.greenAccent.withValues(alpha: alpha);

    // Borde brillante animado
    final borderAlpha = 0.6 + 0.4 * sin(_time * 2);
    _borderPaint.color =
        Colors.white.withValues(alpha: borderAlpha);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rRect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(size.x * 0.25),
    );

    // Relleno
    canvas.drawRRect(rRect, _fillPaint);

    // Borde brillante
    canvas.drawRRect(rRect, _borderPaint);
  }
}
