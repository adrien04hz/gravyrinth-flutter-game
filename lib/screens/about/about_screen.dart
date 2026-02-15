import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  final VoidCallback onClose;

  const AboutScreen({
    super.key,
    required this.onClose,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
    return Stack(
      children: [

        // Fondo oscuro fade
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _visible ? 0.85 : 0,
          child: Container(
            color: Colors.black,
          ),
        ),

        Center(
          child: AnimatedScale(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutBack,
            scale: _visible ? 1 : 0.85,
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  Text(
                    "ACERCA DE",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    "Maze Tilt\n\n"
                    "Juego de laberintos controlado por inclinación.\n\n"
                    "Desarrollado por:\n"
                    "Adrien Hernández\n\n"
                    "Universidad Tecnológica de la Mixteca\n"
                    "Ingeniería en Computación",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Botón cerrar arriba derecha
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: widget.onClose,
          ),
        ),
      ],
    );
  }
}
