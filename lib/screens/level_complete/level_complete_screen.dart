import 'package:flutter/material.dart';
import 'package:ball_game/game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';

class LevelCompleteScreen extends StatelessWidget {
  final BallGame game;

  const LevelCompleteScreen({ super.key, required this.game });

  @override
  Widget build( BuildContext context ) {
    final time = game.gameState.timer.timeRemaining;
    final minutes = ( time ~/ 60 ).toString().padLeft( 2, '0' );
    final seconds = ( time % 60 ).toString().padLeft( 2, '0' );

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withValues( alpha: 0.8 ),
          borderRadius: BorderRadius.circular(16),
        ),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '¡Nivel Completado!',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox( height: 16 ),
            Text(
              'Mundo ${game.gameState.currentWorld}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox( height: 8),
            Text(
              '+${ game.gameState.lastBonus }s de tiempo extra',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tiempo restante: $minutes:$seconds',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox( height: 24 ),
            ElevatedButton(
              onPressed: () {
                game.gameState.continueToNextLevel();
                game.overlays.remove( overlayLevelComplete );
                game.resumeEngine();
              },
              child: const Text('CONTINUAR'),
            ),
          ],
        ),
      ),
    );
  }
}