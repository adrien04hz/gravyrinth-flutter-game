import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BallWithAccelerometer(),
    );
  }
}

class BallWithAccelerometer extends StatefulWidget {
  const BallWithAccelerometer({super.key});

  @override
  State<BallWithAccelerometer> createState() => _BallWithAccelerometerState();
}

class _BallWithAccelerometerState extends State<BallWithAccelerometer> {
  // Posición de la pelota
  double xPos = 150;
  double yPos = 300;

  // Tamaño de la pelota
  final double ballSize = 50;

  // Sensibilidad
  final double speed = 15;

  @override
  void initState() {
    super.initState();

    accelerometerEventStream().listen((event) {
      setState(() {
        // event.x: izquierda / derecha
        // event.y: arriba / abajo
        xPos -= event.x * speed;
        yPos += event.y * speed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Limitar a la pantalla
    xPos = xPos.clamp(0.0, size.width - ballSize);
    yPos = yPos.clamp(0.0, size.height - ballSize);

    return Scaffold(
      appBar: AppBar(title: const Text('Pelota + Acelerómetro')),
      body: Stack(
        children: [
          Positioned(
            left: xPos,
            top: yPos,
            child: Container(
              width: ballSize,
              height: ballSize,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
