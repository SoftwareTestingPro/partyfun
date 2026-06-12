import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../core/utils.dart';

mixin GameLogicMixin<T extends StatefulWidget> on State<T> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioPlayer effectPlayer = AudioPlayer();
  Timer? timer;
  int secondsLeft = 0;
  bool timerRunning = false;

  void checkForTimer(String text) {
    final duration = GameUtils.parseTimerDuration(text);
    setState(() {
      secondsLeft = duration ?? 0;
    });
  }

  void startTimer(VoidCallback onTick) {
    setState(() => timerRunning = true);
    timer?.cancel();
    playTimerSound();
    
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
          if (secondsLeft > 0) {
            playTimerSound();
          } else {
            stopTimer();
          }
        });
      } else {
        stopTimer();
      }
      onTick();
    });
  }

  void playTimerSound() {
    String soundPath = 'sounds/tick.mp3';
    if (secondsLeft <= 3) {
      soundPath = 'sounds/end.mp3';
    } else if (secondsLeft <= 8) {
      soundPath = 'sounds/warning.mp3';
    }
    _playLocal(soundPath);
  }

  void _playLocal(String path) {
    audioPlayer.play(AssetSource(path));
  }

  void playSpinSound() {
    effectPlayer.setReleaseMode(ReleaseMode.loop);
    effectPlayer.play(AssetSource('sounds/spin.mp3'), mode: PlayerMode.lowLatency).catchError((e) {
      // Spin sound failed
    });
  }

  void playFlipSound() {
    _playEffect('sounds/flip.mp3');
  }

  void playSwipeSound() {
    _playEffect('sounds/swipe.mp3');
  }

  void _playEffect(String path) {
    effectPlayer.play(AssetSource(path), mode: PlayerMode.lowLatency);
  }

  void stopSpinSound() {
    effectPlayer.stop();
  }

  void stopTimer() {
    timer?.cancel();
    audioPlayer.stop();
    setState(() => timerRunning = false);
  }

  @override
  void dispose() {
    timer?.cancel();
    audioPlayer.dispose();
    effectPlayer.dispose();
    super.dispose();
  }
}
