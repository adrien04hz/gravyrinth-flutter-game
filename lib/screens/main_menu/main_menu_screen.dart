import 'package:flutter/material.dart';
import '../game/game_screen.dart';
import 'package:ball_game/screens/about/about_screen.dart';
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool _visible = false;
  bool _showAbout = false;

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
    return Scaffold(
      body: Stack(
        children: [

          // Fondo con gradiente
          AnimatedOpacity(
            duration: const Duration(milliseconds: 600),
            opacity: _visible ? 1 : 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              scale: _visible ? 1 : 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "MAZE TILT",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _MenuButton(
                    text: "JUGAR",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GameScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  _MenuButton(
                    text: "CRÉDITOS",
                    onPressed: () {
                      setState(() {
                        _showAbout = true;
                      });
                    },
                  ),


                  const SizedBox(height: 16),

                  _MenuButton(
                    text: "SALIR",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  if (_showAbout)
                    AboutScreen(
                      onClose: () {
                        setState(() {
                          _showAbout = false;
                        });
                      },
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

