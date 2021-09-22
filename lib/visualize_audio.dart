import 'dart:async';
import 'package:dhvani/final_pages/playing_audio_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/core_internal.dart';
import 'package:syncfusion_flutter_core/legend_internal.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_core/tooltip_internal.dart';

class VisualizeAudio extends StatefulWidget {
  final String url;
  final String audioName;
  final Duration duration;
  final List lyrics;
  final AudioPlayer player;
  final String path;
  const VisualizeAudio(
      {Key? key,
      required this.url,
      required this.audioName,
      required this.duration,
      required this.lyrics,
      required this.player,
      required this.path,
      })
      : super(key: key);

  @override
  _VisualizeAudioState createState() => _VisualizeAudioState();
}

class _VisualizeAudioState extends State<VisualizeAudio> {
  //SfRangeValues _values = const SfRangeValues(0.3, 0.7);
  final int _min = 0;
  int noOfTaps = 0;
  int _max = 0;
  late SfRangeValues _initialValues;
  late Random random;
  late List<Data> _chartData;
  late dynamic start;
  late dynamic end;
  Timer? timer;
  ScrollController _scrollController = ScrollController();
  late RangeController _rangeController;
  
  initialiseScroll(int height) async {
    setState(() {
      _scrollController = ScrollController(initialScrollOffset: height * 10.0);
    });
  }
  scrollToLyrics(int seconds, Timer timer) {
    int songTimeSeconds = start + widget.player.position.inSeconds;
    debugPrint("TIME THAT SHOULD BE THERE : " + songTimeSeconds.toString());
    for (Map line in widget.lyrics) {
      if (songTimeSeconds == line["time"] &&
          line["index"] * 10.0 <= _scrollController.position.maxScrollExtent) {
        setState(() {
          debugPrint(line["index"].toString());
          _scrollController.jumpTo(line["index"] * 10.0);
        });
      }
    }
    debugPrint(seconds.toString());
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
    initialiseScroll(0);
    _max = widget.duration.inSeconds;
    start = (widget.duration.inSeconds / 4).round();
    end = (widget.duration.inSeconds / 2).round();
    _initialValues = SfRangeValues((widget.duration.inSeconds / 4).round(),
        (widget.duration.inSeconds / 2).round());
    _rangeController = RangeController(start: start, end : end);
    random = Random();
    _chartData = List<Data>.generate(
        50, (index) => Data(x: index + 1, y: random.nextInt(4).toDouble()));
    
    //TODO
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => scrollToLyrics(t.tick, t));
    super.initState();
    initialiseScroll(0);
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _rangeController.dispose();
    timer!.cancel();
  }
  Future goBack() async
  {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AudioPlayingPage(start: 0.0, end: double.parse(widget.player.duration!.inSeconds.toString()), path: widget.path, audioName: widget.audioName, lyrics: widget.lyrics)));
timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topPadding = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop :() async{
        await goBack();
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top : 1.5 * topPadding, left: width * 0.05),
          child: Column(
            children: [Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(7)),
                            child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  widget.player.stop();
                                  _scrollController.dispose();
                                  goBack();
                                },
                                icon: const Icon(
                                  Icons.chevron_left,
                                  size: 25,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: SizedBox(
                              width: width * 0.5,
                              child: Text(widget.audioName,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              Container(
                  margin: EdgeInsets.only(
                      top: height * 0.05, left: width * 0.03, right: width * 0.03),
                  width: width,
                  child: SfRangeSelector(
                    controller: _rangeController,
                    min: _min,
                    max: _max,
                    initialValues: _initialValues,
                    onChanged: (value) {
                      setState(() {
                        start = value.start.round();
                        end = value.end.round();
                        widget.player.seek(Duration(seconds: start));
                      });
                    },
                    showLabels: false,
                    child: SizedBox(
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
              Text("start : " + start.toString() + " seconds  " + "   end : " + end.toString() + " seconds  "),
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
                              if(noOfTaps % 2 == 0)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Start Point has been set to ${widget.lyrics[index]["line"]}")));
                                widget.player.seek(
                                  Duration(seconds: widget.lyrics[index]["time"]));
                              setState(() {
                                start = widget.lyrics[index]["time"];
                                _rangeController.start = widget.lyrics[index]["time"];
                                noOfTaps += 1;
                              });
                              }
                              else if(noOfTaps % 2 == 1)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("End Point has been set to ${widget.lyrics[index]["line"]}")));
                              setState(() {
                                end = widget.lyrics[index]["end_time"];
                                _rangeController.end = widget.lyrics[index]["end_time"];
                                noOfTaps += 1;
                              });
                              }
                            },
                            child: Text(
                              widget.lyrics[index]["line"] + "\n",
                              style: TextStyle(
                                  fontSize: start + widget.player.position.inSeconds >=
                                              widget.lyrics[index]["time"] &&
                                          start + widget.player.position.inSeconds <=
                                              widget.lyrics[index]["end_time"]
                                      ? 25
                                      : 20,
                                  color: start + widget.player.position.inSeconds >=
                                              widget.lyrics[index]["time"] &&
                                          start + widget.player.position.inSeconds <=
                                              widget.lyrics[index]["end_time"]
                                      ? Colors.black
                                      : Colors.grey),
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class Data {
  Data({required this.x, required this.y});
  final double x;
  final double y;
}
