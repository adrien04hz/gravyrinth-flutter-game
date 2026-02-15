import 'package:ball_game/game/systems/accelerometer_controller.dart';
import 'package:flame/game.dart';
import 'game_state.dart';
import 'systems/timer_system.dart';
import 'package:ball_game/utils/constants.dart';
import 'levels/level_generator.dart';
import 'components/wall.dart';
import 'package:ball_game/models/level_data.dart';
import 'components/ball.dart';


class BallGame extends FlameGame {
  late final GameState gameState;

  late AccelerometerController accelerometer;

  late Ball ball;

  late LevelData currentLevelData;
  final List<Wall> _walls = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final timer = TimerSystem( initialTime: initialGameTime );
    accelerometer = AccelerometerController();
    gameState = GameState( timer: timer );

    accelerometer.start();
    gameState.startGame();

    loadLevel( gameState.currentLevel );
  }

  @override
  void update( double dt ) {
    super.update( dt );

    final oldPosition = ball.position.clone();

    ball.position += ball.velocity * dt;

    _handleCollisions( oldPosition );
    _keepInsideScreen();

    const sensitivity = 50.0;

    ball.velocity.x = -accelerometer.tilt.x * sensitivity;
    ball.velocity.y = accelerometer.tilt.y * sensitivity;

    gameState.update( dt );

    if ( gameState.levelCompleted ) {
      pauseEngine();
      overlays.add( overlayLevelComplete );
    }

    if ( gameState.isGameOver ) {
      pauseEngine();
      overlays.add( overlayGameOver );
    }

    if ( gameState.isVictory ) {
      pauseEngine();
      overlays.add( overlayVictory );
    }
  }

  // Cargar nivel
  void loadLevel( int level ) {
    // Limpiar paredes anteriores
    for ( final wall in _walls ) {
      wall.removeFromParent();
    }

    _walls.clear();

    // Generar nuevo nivel
    currentLevelData = LevelGenerator.generate( level );

    final rows = currentLevelData.rows;
    final cols = currentLevelData.cols;

    // Tamaño de cada celda segun pantalla
    final cellWidth = size.x / cols;
    final cellHeight = size.y / rows;

    for ( int r = 0; r < rows; r++ ) {
      for ( int c = 0; c < cols; c++ ) {
        
        final cell = currentLevelData.grid[r][c];

        final x = c * cellWidth;
        final y = r * cellHeight;

        if ( cell.top ) {
          final wall = Wall(
            position: Vector2(x, y),
            size: Vector2( cellWidth, wallThickness ),
          );

          _walls.add( wall );
          add( wall );
        }

        if ( cell.left ) {
          final wall = Wall(
            position: Vector2(x, y),
            size: Vector2( wallThickness, cellHeight ),
          );
          _walls.add( wall );
          add( wall );
        }

        // Evitar duplicar border externos
        if ( r == rows - 1 && cell.bottom ) {
          final wall = Wall(
            position: Vector2(x, y + cellHeight - wallThickness),
            size: Vector2(cellWidth, wallThickness),
          );
          _walls.add( wall );
          add( wall );
        }

        if ( c == cols - 1 && cell.right ) {
          final wall = Wall(
            position: Vector2(x + cellWidth - wallThickness, y),
            size: Vector2(wallThickness, cellHeight),
          );
          _walls.add( wall );
          add( wall );
        }
      }
    }

    final satartX = cellWidth / 2;
    final startY = cellHeight / 2;

    ball = Ball(
      position: Vector2( satartX, startY ),
      radius: cellWidth * 0.25,
    );
    add( ball );
  }

  void _handleCollisions( Vector2 oldPosition ) {
    for ( final wall in _walls ) {
      if ( ball.toRect().overlaps( wall.toRect() ) ) {
        ball.position = oldPosition;
        break;
      }
    }
  }

  void _keepInsideScreen() {
    ball.position.x = ball.position.x.clamp(
      ball.radius,
      size.x - ball.radius,
    );

    ball.position.y = ball.position.y.clamp(
      ball.radius,
      size.y - ball.radius,
    );
  }
}