import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../../game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';
import 'package:ball_game/screens/level_complete/level_complete_screen.dart';
import 'package:ball_game/screens/pause_menu/pause_menu_screen.dart';
import 'package:ball_game/screens/victory/victory_screen.dart';
import 'package:ball_game/screens/end_game/game_over_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({ super.key });

  @override
  Widget build( BuildContext context ) {
    final game = BallGame();

    return Scaffold(
      body: GameWidget<BallGame>(
        game: game,
        overlayBuilderMap: {
          overlayHud: ( context, BallGame game) {
            return _Hud( game: game );
          },
          overlayGameOver: ( context, BallGame game ) {
            return VictoryScreen( game: game );
          },
          overlayVictory: ( context, BallGame game ) {
            return VictoryScreen( game: game );
          },
          overlayLevelComplete: ( context, BallGame game ) {
            return LevelCompleteScreen( game: game );
          },
          overlayPauseMenu: ( context, BallGame game ) {
            return PauseMenuScreen( game: game );
          }
        },
        initialActiveOverlays: const [overlayHud],
      ),
    );
  }
}


class _Hud extends StatelessWidget {
  final BallGame game;

  const _Hud({ required this.game });

  @override
  Widget build( BuildContext context ) {
    return ValueListenableBuilder<double>(
      valueListenable: game.gameState.timer.timeNotifier,
      builder: ( context, time, _ ) {
        final totalSeconds = time.floor();
        final minutes = ( totalSeconds ~/ 60).toString().padLeft( 2, '0' );
        final seconds = ( totalSeconds % 60).toString().padLeft( 2, '0' );

        return Positioned(
          top: 30,
          left: 20,
          right: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiempo: $minutes:$seconds',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox( height: 6 ),
                    Text(
                      'Nivel: ${ game.gameState.currentLevel }',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Mundo: ${ game.gameState.currentWorld }',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.pause, color: Colors.white),
                onPressed: () {
                  game.pauseEngine();
                  game.gameState.timer.pause();
                  game.overlays.add(overlayPauseMenu);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}