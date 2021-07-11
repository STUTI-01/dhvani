import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TrimAudio extends StatefulWidget {
  final double start;
  final double end;
  const TrimAudio({Key? key, required this.start, required this.end})
      : super(key: key);

  @override
  _TrimAudioState createState() => _TrimAudioState();
}

class _TrimAudioState extends State<TrimAudio> {
  AudioPlayer audioPlayer = AudioPlayer();
  Future player() async {
    await audioPlayer.play(
        "https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/Ganesha_Chant_108_Times_Ganapathi_Mantra.mp3?alt=media&token=d030ce3e-d586-49f8-8b6b-2ffec22bcef5");
  }

  @override
  void initState() {
    super.initState();
    player();
  }

  var path = 'assets/Audio/Ganesha_Chant_108_Times_Ganapathi_Mantra.mp3';
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
