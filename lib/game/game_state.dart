import 'package:ball_game/utils/constants.dart';
import 'systems/timer_system.dart';

class GameState {
  int _currentLevel = 1;
  bool _isGameOver = false;
  bool _isVictory = false;

  bool _levelCompleted = false;

  final TimerSystem timer;

  GameState({ required this.timer });

  // Inicia el juego desde cero
  void startGame() {
    _currentLevel = 1;
    _isGameOver = false;
    _isVictory = false;
    timer.reset(initialGameTime); // 5 minutos
    timer.start();
  }

  // Nivel completo
  void completeLevel() {
    // Bonus por mundo
    final bonus = _bonusForLevel( _currentLevel );
    timer.addBonus( bonus );

    _levelCompleted = true;
    timer.pause();
  }

  // Llamadas continuas
  void update( double dt ) {
    if ( _isGameOver || _isVictory ) return;

    timer.update(dt);

    if( timer.isTimeUp ) {
      _isGameOver = true;
      timer.pause();
    }
  }

  // Reiniciar todo el juego
  void reset() {
    startGame();
  }

  // Bonus segun el nivel o mundo
  double _bonusForLevel( int lvl ) {
    if ( lvl <= 5 ) return bonusWorld1;
    if ( lvl <= 10 ) return bonusWorld2;
    if ( lvl <= 15 ) return bonusWorld3;
    return bonusWorld4; 
  }

  // Continuar al siguiente nivel
  void continueToNextLevel() {
    _levelCompleted = false;
    _currentLevel++;

    if ( _currentLevel > maxLevels ) {
      _isVictory = true;
      timer.pause();
    } else {
      timer.resume();
    }
  }

  // Mundo actual (1 a 4)
  int get currentWorld {
    if ( _currentLevel <= 5 ) return 1;
    if ( _currentLevel <= 10 ) return 2;
    if ( _currentLevel <= 15 ) return 3;
    return 4;
  }

  int get currentLevel => _currentLevel;
  bool get isGameOver => _isGameOver;
  bool get isVictory => _isVictory;

  bool get levelCompleted => _levelCompleted;
  double get lastBonus => _bonusForLevel( _currentLevel );
}