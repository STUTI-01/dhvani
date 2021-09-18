import 'dart:async';

import 'package:dhvani/final_pages/playing_audio_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';

class VisualizeAudio extends StatefulWidget {
  final String url;
  final String audioName;
  final Duration duration;
  final List lyrics;
  final AudioPlayer player;
  VisualizeAudio(
      {Key? key,
      required this.url,
      required this.audioName,
      required this.duration,
      required this.lyrics,
      required this.player})
      : super(key: key);

  @override
  _VisualizeAudioState createState() => _VisualizeAudioState();
}

class _VisualizeAudioState extends State<VisualizeAudio> {
  //SfRangeValues _values = const SfRangeValues(0.3, 0.7);
  int _min = 0;
  int _max = 0;
  late SfRangeValues _initialValues;
  late Random random;
  late List<Data> _chartData;
  late dynamic start;
  late dynamic end;
  Timer? timer;
  ScrollController _scrollController = ScrollController();
  initialiseScroll(int height) async {
    setState(() {
      _scrollController = ScrollController(initialScrollOffset: height * 10.0);
    });
  }
  scrollToLyrics(int seconds, Timer timer) {
    int songTimeSeconds = widget.player.position.inSeconds;
    for (Map line in widget.lyrics) {
      if (songTimeSeconds == line["time"] &&
          line["index"] * 10.0 <= _scrollController.position.maxScrollExtent) {
        setState(() {
          print(line["index"]);
          _scrollController.jumpTo(line["index"] * 10.0);
        });
      }
    }
    print(seconds);
  }

  void trimSong() async {
    await widget.player.setClip(
        start: Duration(seconds: start),
        end: Duration(seconds: end));
    await widget.player.play();
  }
   Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          widget.player.positionStream,
          widget.player.bufferedPositionStream,
          widget.player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  void initState() {
    _max = widget.duration.inSeconds;
    start = (widget.duration.inSeconds / 4).round();
    end = (widget.duration.inSeconds / 2).round();
    _initialValues = SfRangeValues((widget.duration.inSeconds / 4).round(),
        (widget.duration.inSeconds / 2).round());
    random = new Random();
    _chartData = List<Data>.generate(
        50, (index) => Data(x: index + 1, y: random.nextInt(4).toDouble()));
    initialiseScroll(0);
    //TODO
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => scrollToLyrics(t.tick, t));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: height * 0.1, left: width * 0.03, right: width * 0.03),
              width: width,
              child: SfRangeSelector(
                min: _min,
                max: _max,
                initialValues: _initialValues,
                onChanged: (value) {
                  setState(() {
                    start = value.start.round();
                    end = value.end.round();
                  });
                },
                showLabels: false,
                child: Container(
                  child: SfCartesianChart(
                    margin: const EdgeInsets.all(0),
                    primaryXAxis: NumericAxis(
                      isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(isVisible: false, maximum: 4),
                    series: <SplineAreaSeries<Data, double>>[
                      SplineAreaSeries<Data, double>(
                          dataSource: _chartData,
                          xValueMapper: (Data visualizer, int index) =>
                              visualizer.x,
                          yValueMapper: (Data visualizer, int index) =>
                              visualizer.y)
                    ],
                  ),
                  height: 250,
                ),
              )),
          Text("start : " + start.toString() + "   end : " + end.toString()),
          ControlButtons(player: widget.player, trim: trimSong),
          StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: widget.player.seek,
                  );
                },
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: height * 0.05),
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: widget.lyrics.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          //print(player.position);
                          widget.player.seek(
                              Duration(seconds: widget.lyrics[index]["time"]));
                          
                        },
                        child: Text(
                          widget.lyrics[index]["line"] + "\n",
                          style: TextStyle(
                              fontSize: widget.player.position.inSeconds >=
                                          widget.lyrics[index]["time"] &&
                                      widget.player.position.inSeconds <=
                                          widget.lyrics[index]["end_time"]
                                  ? 25
                                  : 20,
                              color: widget.player.position.inSeconds >=
                                          widget.lyrics[index]["time"] &&
                                      widget.player.position.inSeconds <=
                                          widget.lyrics[index]["end_time"]
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                      );
                    }),
              ))
          // Container(
          //   margin: const EdgeInsets.only(top: 50),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => AudioPlayingPage(
          //                     start: (widget.duration.inSeconds * start) / 10,
          //                     end: (widget.duration.inSeconds * end) / 10,
          //                     path: widget.url,
          //                     audioName: widget.audioName,
          //                     lyrics: widget.lyrics,
          //                   )));
          //     },
          //     child: const Text(
          //       "TRIM SHLOKA",
          //       style:
          //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          //   height: 50,
          //   width: 250,
          //   color: Colors.blue,
          //   alignment: Alignment.center,
          // )
        ],
      ),
    );
  }
}

class Data {
  Data({required this.x, required this.y});
  final double x;
  final double y;
}
