import 'package:ball_game/game/components/ball.dart';
import 'package:flutter/material.dart';
import 'package:ball_game/game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';

class PauseMenuScreen extends StatelessWidget{
  final BallGame game;

  const PauseMenuScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build( BuildContext context ) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues( alpha: 0.7 ),
          ),
        ),

        Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "PAUSA",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                _PauseButton(
                  text: "Continuar",
                  onPressed: () {
                    game.overlays.remove( overlayPauseMenu );
                    game.gameState.timer.resume();
                    game.resumeEngine();
                  },
                ),

                const SizedBox(height: 12),

                _PauseButton(
                  text: "Reiniciar",
                  onPressed: () {
                    game.overlays.remove( overlayPauseMenu );
                    game.gameState.reset();
                    game.resumeEngine();
                    game.loadLevel(1);
                  },
                ),

                const SizedBox(height: 12),

                _PauseButton(
                  text: "Menú Principal",
                  onPressed: () {
                    game.overlays.remove( overlayPauseMenu );
                    game.resumeEngine();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

