import 'package:flutter/foundation.dart';

class TimerSystem {
  // Tiempo restante en segundos
  double _timeRemaining;

  //Estado del timer
  bool _isRunning = false;

  // Notificador para la UI
  final ValueNotifier<double> timeNotifier;

  TimerSystem({ required double initialTime })
    : _timeRemaining = initialTime,
      timeNotifier = ValueNotifier<double>(initialTime);

  // Iniciar timer
  void start() {
    _isRunning = true;
  }

  // Pausar timer
  void pause() {
    _isRunning = false;
  }

  void resume() {
    _isRunning = true;
  }

  // Reanudar timer
  void reset( double newTime ) {
    _timeRemaining = newTime;
    timeNotifier.value = newTime;
    _isRunning = false;
  }

  // Actualizar timer
  void update( double dt ) {
    if( !_isRunning ) return;

    _timeRemaining -= dt;

    if( _timeRemaining < 0 ){
      _timeRemaining = 0;
    }

    // Avisar a la UI
    timeNotifier.value = _timeRemaining;
  }

  // Tiempo bonus
  void addBonus( double seconds ) {
    _timeRemaining += seconds;
    timeNotifier.value = _timeRemaining;
  }

  // Getter: tiempo restante
  double get timeRemaining => _timeRemaining;

  // Getter: si ha acabado el tiempo
  bool get isTimeUp => _timeRemaining <= 0;

  // Getter: estado del timer
  bool get isRunning => _isRunning;
}