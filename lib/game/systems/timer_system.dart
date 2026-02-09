class TimerSystem {
  // Tiempo restante en segundos
  double _timeRemaining;

  //Estado del timer
  bool _isRunning = false;

  TimerSystem({ required double initialTime })
    : _timeRemaining = initialTime;

  // Iniciar timer
  void start() {
    _isRunning = true;
  }

  // Pausar timer
  void pause() {
    _isRunning = false;
  }

  // Reanudar timer
  void reset( double newTime ) {
    _timeRemaining = newTime;
    _isRunning = false;
  }

  // Actualizar timer
  void update( double dt ) {
    if( !_isRunning ) return;

    _timeRemaining -= dt;

    if( _timeRemaining < 0 ){
      _timeRemaining = 0;
    }
  }

  // Tiempo bonus
  void addBonus( double seconds ) {
    _timeRemaining += seconds;
  }

  // Getter: tiempo restante
  double get timeRemaining => _timeRemaining;

  // Getter: si ha acabado el tiempo
  bool get isTimeUp => _timeRemaining <= 0;

  // Getter: estado del timer
  bool get isRunning => _isRunning;
}