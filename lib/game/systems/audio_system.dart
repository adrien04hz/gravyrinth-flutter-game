import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class AudioSystem {
  static final AudioSystem _instance = AudioSystem._internal();
  factory AudioSystem() => _instance;
  AudioSystem._internal();

  final AudioPlayer _musicPlayer = AudioPlayer( playerId: 'music' );
  final AudioPlayer _sfxPlayer = AudioPlayer( playerId: 'sfx' );

  // ==========================
  // MÚSICA
  // ==========================

  Future<void> playBackgroundMusic({bool random = true}) async {
    if ( _musicPlayer.state == PlayerState.playing ) _musicPlayer.stop();

    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(0.6);

    String trackPath;

    if (random) {
      final trackNumber = Random().nextInt(3) + 1;
      trackPath = 'sounds/bg$trackNumber.mp3';
    } else {
      trackPath = 'sounds/bg1.mp3';
    }

    await _musicPlayer.play(AssetSource(trackPath));
  }

  Future<void> stopBackgroundMusic() async {
    await _musicPlayer.stop();
  }

  // ==========================
  // EFECTOS
  // ==========================

  Future<void> playWin() async {
    await _musicPlayer.stop();
    await _playSfx('sounds/win.mp3');
  }

  Future<void> playLose() async {
    await _musicPlayer.stop();
    await _playSfx('sounds/game_over.wav');
  }

  Future<void> _playSfx(String path) async {
    await _sfxPlayer.stop();
    await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
    await _sfxPlayer.setVolume(1.0);
    await _sfxPlayer.play(AssetSource(path));
  }
}