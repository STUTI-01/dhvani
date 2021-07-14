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
  final assetsAudioplayAudio = AssetsAudioPlayer();
  void playAudio(int choice) async {
    try {
      await assetsAudioplayAudio.open(
          Audio.network(
              "https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/NAVAGRAHA_MANTRAS.mp3?alt=media&token=0e7913fc-c82c-4c39-b3a3-3c1064e2f0a4"),
          autoStart: false);
      if (choice == 0) {
        assetsAudioplayAudio.play();
      } else if (choice == 1) {
        assetsAudioplayAudio.stop();
      } else if (choice == 2) {
        assetsAudioplayAudio.seek(Duration(seconds: widget.start.round()));
        assetsAudioplayAudio.play();
      }
    } catch (t) {
      //mp3 unreachable
    }
  }

  void test() async {
    assetsAudioplayAudio.seek(Duration(seconds: widget.start.round()));
  }

  @override
  void initState() {
    super.initState();
  }

  var path = 'assets/Audio/Ganesha_Chant_108_Times_Ganapathi_Mantra.mp3';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 100, left: 100),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              playAudio(0);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "PLAY",
                style: TextStyle(color: Colors.black),
              ),
              height: 50,
              width: 150,
              color: Colors.blue,
              alignment: Alignment.center,
            ),
          ),
          GestureDetector(
            onTap: () {
              playAudio(2);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "SEEK",
                style: TextStyle(color: Colors.black),
              ),
              height: 50,
              width: 150,
              color: Colors.blue,
              alignment: Alignment.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: GestureDetector(
              onTap: () {
                playAudio(1);
              },
              child: const Text(
                "STOP",
                style: TextStyle(color: Colors.black),
              ),
            ),
            height: 50,
            width: 150,
            color: Colors.blue,
            alignment: Alignment.center,
          ),
        ],
      ),
    ));
  }
}
