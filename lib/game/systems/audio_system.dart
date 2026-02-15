import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class AudioSystem {
  static final AudioSystem _instance = AudioSystem._internal();

  factory AudioSystem() => _instance;

  AudioSystem._internal();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playClick() async {
    await _player.play(AssetSource('sounds/pop2.wav'));
  }

  Future<void> playWin() async {
    await _player.play(AssetSource('sounds/win.mp3'));
  }

  Future<void> playLose() async {
    await _player.play(AssetSource('sounds/game_over.mp3'));
  }

  Future<void> playBackgroundMusic() async {
    Random random = Random();
    int trackNumber = random.nextInt(3) + 1; // Genera un número entre 1 y 3
    String trackPath = 'sounds/bg$trackNumber.mp3';
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource(trackPath));
  }
}