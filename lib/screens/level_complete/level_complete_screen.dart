import 'package:flutter/material.dart';
import 'package:ball_game/game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';

class LevelCompleteScreen extends StatefulWidget {
  final BallGame game;

  const LevelCompleteScreen({
    super.key,
    required this.game,
  });

  @override
  State<LevelCompleteScreen> createState() =>
      _LevelCompleteScreenState();
}

class _LevelCompleteScreenState
    extends State<LevelCompleteScreen> {

  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    final time = game.gameState.timer.timeRemaining;
    final totalSeconds = time.floor();
    final minutes =
        (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds =
        (totalSeconds % 60).toString().padLeft(2, '0');

    return Stack(
      children: [

        // Fondo fade
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _visible ? 0.8 : 0,
          child: Container(
            color: Colors.black,
          ),
        ),

        // Panel animado
        Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            scale: _visible ? 1 : 0.85,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _visible ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      '¡Nivel ${game.gameState.currentLevel} Completado!',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Mundo ${game.gameState.currentWorld}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '+${game.gameState.lastBonus}s de tiempo extra',
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

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {
                        game.gameState.continueToNextLevel();
                        game.overlays.remove(overlayLevelComplete);
                        game.loadLevel(
                          game.gameState.currentLevel + 1,
                        );
                        game.resumeEngine();
                      },
                      child: const Text('CONTINUAR'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
