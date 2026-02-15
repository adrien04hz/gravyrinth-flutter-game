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
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    "GravyRinth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Completa cada laberinto inclinando tu dispositivo. ¡Desafía tus habilidades y diviértete!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Desarrollado por:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  Text(
                    "Adrien Hernández Sánchez",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Versión: 1.0.0",
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
