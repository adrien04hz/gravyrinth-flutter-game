import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class AudioSystem {
  static final AudioSystem _instance = AudioSystem._internal();

  factory AudioSystem() => _instance;

  AudioSystem._internal();

  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _bgSoundPlayer = AudioPlayer();

  bool _bgPlaying = false;

  Future<void> playClick() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/pop2.wav'));
  }

  Future<void> playWin() async {
    if ( _bgPlaying ) {
      await stopBackgroundMusic();
    }
    await _player.play(AssetSource('sounds/win.mp3'));
  }

  Future<void> playLose() async {
    if ( _bgPlaying ) {
      await stopBackgroundMusic();
    }
    await _player.play(AssetSource('sounds/game_over.wav'));
  }

  Future<void> playBackgroundMusic() async {
    if ( _bgPlaying ) return;

    _bgPlaying = true;

    Random random = Random();
    int trackNumber = random.nextInt(3) + 1; // Genera un número entre 1 y 3
    String trackPath = 'sounds/bg$trackNumber.mp3';
    await _bgSoundPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgSoundPlayer.play(AssetSource(trackPath));
  }

  Future<void> stopBackgroundMusic() async {
    await _bgSoundPlayer.stop();
    _bgPlaying = false;
  }

  Future<void> stopPlayer() async {
    await _player.stop();
  }
}