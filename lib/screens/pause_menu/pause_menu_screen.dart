import 'package:flutter/material.dart';
import 'package:ball_game/game/ball_game.dart';
import 'package:ball_game/utils/constants.dart';

class PauseMenuScreen extends StatefulWidget {
  final BallGame game;

  const PauseMenuScreen({
    super.key,
    required this.game,
  });

  @override
  State<PauseMenuScreen> createState() => _PauseMenuScreenState();
}

class _PauseMenuScreenState extends State<PauseMenuScreen> {
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

    return Stack(
      children: [

        // Fondo con fade
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _visible ? 0.7 : 0,
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
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    _PauseButton(
                      text: "Continuar",
                      onPressed: () {
                        game.overlays.remove(overlayPauseMenu);
                        game.gameState.timer.resume();
                        game.resumeEngine();
                      },
                    ),

                    const SizedBox(height: 12),

                    _PauseButton(
                      text: "Reiniciar",
                      onPressed: () {
                        game.overlays.remove(overlayPauseMenu);
                        game.gameState.reset();
                        game.resumeEngine();
                        game.loadLevel(1);
                      },
                    ),

                    const SizedBox(height: 12),

                    _PauseButton(
                      text: "Menú Principal",
                      onPressed: () {
                        game.overlays.remove(overlayPauseMenu);
                        game.resumeEngine();
                        Navigator.of(context).pop();
                      },
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


class _PauseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _PauseButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}