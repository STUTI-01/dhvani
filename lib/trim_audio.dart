import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class TrimAudio extends StatefulWidget {
  final double start;
  final double end;
  const TrimAudio({Key? key, required this.start, required this.end})
      : super(key: key);

  @override
  _TrimAudioState createState() => _TrimAudioState();
}

class _TrimAudioState extends State<TrimAudio> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  void player() async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(
            "https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/NAVAGRAHA_MANTRAS.mp3?alt=media&token=0e7913fc-c82c-4c39-b3a3-3c1064e2f0a4"),
      );
    } catch (t) {
      //mp3 unreachable
    }
  }

  void pause() async {
    await assetsAudioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    player();
  }

  var path = 'assets/Audio/Ganesha_Chant_108_Times_Ganapathi_Mantra.mp3';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GestureDetector(
        onTap: () {
          pause();
        },
        child: Text("STOP"),
      ),
    ));
  }
}
