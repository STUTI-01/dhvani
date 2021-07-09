import 'package:audiocutter/audiocutter.dart';
import 'package:flutter/material.dart';


class TrimAudio extends StatefulWidget {
  final double start;
  final double end;
  const TrimAudio({ Key? key, required this.start, required this.end }) : super(key: key);

  @override
  _TrimAudioState createState() => _TrimAudioState();
}

class _TrimAudioState extends State<TrimAudio> {
  @override
  void initState() {
    super.initState();
  }
  Future trim() async
  {
    var outputFilePath = await AudioCutter.cutAudio(path, widget.start, widget.end);
  }
   var path = 'assets/Audio/Ganesha_Chant_108_Times_Ganapathi_Mantra.mp3';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}