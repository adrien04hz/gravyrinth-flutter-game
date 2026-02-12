import 'package:flame/game.dart';
import 'game_state.dart';
import 'systems/timer_system.dart';
import 'package:ball_game/utils/constants.dart';
import 'package:flame/components.dart';
import 'levels/level_generator.dart';
import 'components/wall.dart';
import 'package:ball_game/models/level_data.dart';
import 'package:flutter/material.dart';


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
    final cols = currentLevelData.columns;

    // Tamaño de cada celda segun pantalla
    final cellWidth = size.x / cols;
    final cellHeight = size.y / rows;

    for ( int r = 0; r < rows; r++ ) {
      for ( int c = 0; c < cols; c++ ) {
        // Pared real
        if ( currentLevelData.grid[r][c] == 1 ) {
          final wall = Wall(
            position: Vector2(
              c * cellWidth,
              r * cellHeight,
            ),
            size: Vector2(
              cellWidth,
              cellHeight,
            ),
          );

          _walls.add( wall );
          add( wall );
        }
      }
    }
  }
}