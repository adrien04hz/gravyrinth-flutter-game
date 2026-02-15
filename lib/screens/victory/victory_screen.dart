import 'package:ball_game/game/systems/audio_system.dart';
import 'package:flutter/material.dart';
import 'package:ball_game/game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';

class VictoryScreen extends StatefulWidget {
  final BallGame game;

  const VictoryScreen({
    super.key,
    required this.game,
  });

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    AudioSystem().playWin();

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

        // Fondo dorado con fade
        AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: _visible ? 0.9 : 0,
          child: Container(
            color: Colors.amber.shade900,
          ),
        ),

        Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            scale: _visible ? 1 : 0.7,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Icon(
                    Icons.emoji_events,
                    size: 60,
                    color: Colors.amber,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "¡VICTORIA!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Has completado todos los mundos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove( overlayVictory );
                      game.resumeEngine();
                      Navigator.of(context).pop();
                    },
                    child: const Text("MENÚ PRINCIPAL"),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      game.overlays.remove( overlayVictory );
                      game.gameState.reset();
                      game.loadLevel(1);
                      game.resumeEngine();
                    },
                    child: const Text("JUGAR DE NUEVO"),
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
