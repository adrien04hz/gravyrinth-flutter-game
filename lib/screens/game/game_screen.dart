import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../../game/ball_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({ super.key });

  @override
  Widget build( BuildContext context ) {
    final game = BallGame();

    return Scaffold(
      body: GameWidget<BallGame>(
        game: game,
        overlayBuilderMap: {
          'HUD': ( context, BallGame game) {
            return _Hud( game: game );
          },
          'GameOver': ( context, BallGame game ) {
            return const Center(
              child: Text(
                'GAME OVER',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.red,
                ),
              ),
            );
          },
          'Victory': ( context, BallGame game ) {
            return const Center(
              child: Text(
                '¡GANASTE!',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.green,
                ),
              ),
            );
          },
        },
        initialActiveOverlays: const ['HUD'],
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
          top: 40,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$minutes:$seconds',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        );
      },
    );
  }
}