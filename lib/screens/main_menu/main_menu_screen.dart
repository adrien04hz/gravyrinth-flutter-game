import 'package:ball_game/game/systems/audio_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/game_screen.dart';
import 'package:ball_game/screens/about/about_screen.dart';
import 'package:ball_game/main.dart';
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> with RouteAware{
  bool _visible = false;
  bool _showAbout = false;

  @override
  void initState() {
    super.initState();
    AudioSystem().playBackgroundMusic();
    Future.delayed(Duration.zero, () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    AudioSystem().playBackgroundMusic();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _showAbout ? 0 : 1,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _showAbout = true;
            });
          },
          shape: CircleBorder(),
          child: const Icon(Icons.info_outline),
        ),
      ),

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

                  Image(
                    image: const AssetImage('assets/images/tilt.png'),
                    width: 120,
                    height: 120,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "GRAVYRINTH",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 100),

                  _MenuButton(
                    text: "JUGAR",
                    onPressed: () {
                      AudioSystem().stopBackgroundMusic();
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
                    text: "SALIR",
                    onPressed: () {
                      AudioSystem().playClick();
                      SystemNavigator.pop();
                    },
                  ),
                ],
              ),
            ),
          ),

          if (_showAbout)
            Positioned.fill(
              child: AboutScreen(
                onClose: () {
                  setState(() {
                    _showAbout = false;
                  });
                },
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
      width: 180,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent.withValues( alpha: 0.8 ),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: () {
          AudioSystem().playClick();
          onPressed();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

