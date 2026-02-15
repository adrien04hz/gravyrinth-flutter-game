import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flame/components.dart';

class AccelerometerController {
  Vector2 tilt = Vector2.zero();

  StreamSubscription? _subscription;

  void start() {
    _subscription = accelerometerEventStream().listen( ( event ) {
      tilt.x = event.x;
      tilt.y = event.y;
    });
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}