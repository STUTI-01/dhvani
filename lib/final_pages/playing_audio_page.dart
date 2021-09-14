import 'package:dhvani/common.dart';
import 'package:dhvani/visualize_audio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayingPage extends StatefulWidget {
  final double start;
  final double end;
  final String path;
  final String audioName;
  const AudioPlayingPage(
      {Key? key,
      required this.start,
      required this.end,
      required this.path,
      required this.audioName})
      : super(key: key);

  @override
  _AudioPlayingPageState createState() => _AudioPlayingPageState();
}

class _AudioPlayingPageState extends State<AudioPlayingPage> {
  late AudioPlayer player;
  late Duration duration;

  void initialisePlayer() async {
    player = AudioPlayer();
    await player.setAsset(widget.path);
    // await player.setUrl(widget.path);
    duration = (await player.duration)!;
  }

  void trimSong() async {
    await player.setClip(
        start: Duration(seconds: widget.start.round()),
        end: Duration(seconds: widget.end.round()));
    await player.play();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();
    initialisePlayer();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: topPadding * 1.2, left: width * 0.05),
          child: Column(
            children: [
              // Display play/pause button and volume/speed sliders.
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.13),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(7)),
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 25,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.08),
                      child: Text(widget.audioName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                  height: height * 0.3,
                  width: width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(7),
                  )),
              ControlButtons(player: player, trim: trimSong),
              // Display seek bar. Using StreamBuilder, this widget rebuilds
              // each time the position, buffered position or duration changes.
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: player.seek,
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                // TrimAudioPage(url: widget.url, audioName: widget.audioName,)
                                //
                                VisualizeAudio(
                                  url: widget.path,
                                  audioName: widget.audioName,
                                  duration: duration,
                                )));
                  },
                  child: const Text(
                    "TRIM SHLOKA",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                height: 50,
                width: 250,
                color: Colors.blue,
                alignment: Alignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final Function trim;
  const ControlButtons({Key? key, required this.player, required this.trim})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 15.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: () {
                  trim();
                },
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 5.0,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
