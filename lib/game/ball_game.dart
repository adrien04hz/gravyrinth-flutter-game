import 'package:flame/game.dart';
import 'game_state.dart';
import 'systems/timer_system.dart';
import 'package:ball_game/utils/constants.dart';
import 'levels/level_generator.dart';
import 'components/wall.dart';
import 'package:ball_game/models/level_data.dart';


class BallGame extends FlameGame {
  late final GameState gameState;

  late LevelData currentLevelData;
  final List<Wall> _walls = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final timer = TimerSystem( initialTime: initialGameTime );
    gameState = GameState( timer: timer );

    gameState.startGame();

    loadLevel( gameState.currentLevel );
  }

  @override
  void update( double dt ) {
    super.update( dt );

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
          add(Wall(
            position: Vector2(x, y),
            size: Vector2( cellWidth, wallThickness ),
          ));
        }

        if ( cell.left ) {
          add(Wall(
            position: Vector2(x, y),
            size: Vector2( wallThickness, cellHeight ),
          ));
        }

        // Evitar duplicar border externos
        if ( r == rows - 1 && cell.bottom ) {
          add(Wall(
            position: Vector2(x, y + cellHeight - wallThickness),
            size: Vector2(cellWidth, wallThickness),
          ));
        }

        if ( c == cols - 1 && cell.right ) {
          add(Wall(
            position: Vector2(x + cellWidth - wallThickness, y),
            size: Vector2(wallThickness, cellHeight),
          ));
        }
      }
    }
  }
}