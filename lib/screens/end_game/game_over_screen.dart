import 'package:ball_game/game/systems/audio_system.dart';
import 'package:flutter/material.dart';
import 'package:ball_game/game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';

class GameOverScreen extends StatefulWidget {
  final BallGame game;

  const GameOverScreen({
    super.key,
    required this.game,
  });

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    AudioSystem().playLose();

    Future.delayed(Duration.zero, () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

    return Stack(
      children: [

        // Fondo rojo fade
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _visible ? 0.85 : 0,
          child: Container(
            color: Colors.red.shade900,
          ),
        ),

        Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            scale: _visible ? 1 : 0.8,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Icon(
                    Icons.close,
                    size: 50,
                    color: Colors.redAccent,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "GAME OVER",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      AudioSystem().playClick();
                      AudioSystem().stopPlayer();
                      game.overlays.remove( overlayGameOver );
                      game.resumeEngine();
                      Navigator.of(context).pop();
                    },
                    child: const Text("MENÚ PRINCIPAL"),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(160, 40),
                    ),
                    onPressed: () {
                      AudioSystem().playClick();
                      AudioSystem().stopPlayer();
                      game.overlays.remove(overlayGameOver);
                      game.gameState.reset();
                      game.loadLevel(1);
                      game.resumeEngine();
                    },
                    child: const Text("REINTENTAR"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
