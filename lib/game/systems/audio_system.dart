import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class AudioSystem {
  static final AudioSystem _instance = AudioSystem._internal();
  factory AudioSystem() => _instance;
  AudioSystem._internal();

  final AudioPlayer _musicPlayer = AudioPlayer(playerId: 'music');
  final AudioPlayer _sfxPlayer = AudioPlayer(playerId: 'sfx');

  bool _musicStarted = false;

  Future<void> startGlobalMusic() async {
    Random random = Random();
    int trackNumber = random.nextInt(3) + 1; // 1, 2 o 3
    if (_musicStarted) return;

    _musicStarted = true;

    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(0.6);
    await _musicPlayer.play(
      AssetSource('sounds/bg$trackNumber.mp3'),
    );
  }

  Future<void> stopMusic() async {
    await _musicPlayer.stop();
    _musicStarted = false;
  }

  Future<void> playClick() async {
    await _sfxPlayer.stop();
    await _sfxPlayer.play(AssetSource('sounds/pop2.wav'));
  }

  Future<void> playWin() async {
    await stopMusic();
    await _sfxPlayer.play(AssetSource('sounds/win.mp3'));
  }

  Future<void> playLose() async {
    await stopMusic();
    await _sfxPlayer.play(AssetSource('sounds/game_over.wav'));
  }
}
