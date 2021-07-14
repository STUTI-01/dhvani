import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Test extends StatefulWidget {
  final double start;
  final double end;
  const Test({Key? key, required this.start, required this.end})
      : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  late AudioPlayer player;
  void initialisePlayer() async {
    player = AudioPlayer();
    await player.setUrl(
        'https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/NAVAGRAHA_MANTRAS.mp3?alt=media&token=0e7913fc-c82c-4c39-b3a3-3c1064e2f0a4');
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Text("PLAY"),
        onTap: () {
          initialisePlayer();
        },
      ),
    );
  }
}
