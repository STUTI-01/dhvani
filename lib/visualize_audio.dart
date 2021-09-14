import 'package:dhvani/final_pages/playing_audio_page.dart';
import 'package:dhvani/test.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class VisualizeAudio extends StatefulWidget {
  final String url;
  final String audioName;
  final Duration duration;
  VisualizeAudio(
      {Key? key,
      required this.url,
      required this.audioName,
      required this.duration})
      : super(key: key);

  @override
  _VisualizeAudioState createState() => _VisualizeAudioState();
}

class _VisualizeAudioState extends State<VisualizeAudio> {
  SfRangeValues _values = const SfRangeValues(0.3, 0.7);
  final double _min = 0.0;
  final double _max = 10.0;
  SfRangeValues _initialValues = SfRangeValues(4.0, 8.0);
  late Random random;
  late List<Data> _chartData;
  dynamic start = 4.0;
  dynamic end = 8.0;

  @override
  void initState() {
    random = new Random();
    _chartData = List<Data>.generate(
        50, (index) => Data(x: index + 1, y: random.nextInt(4).toDouble()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 200, left: 25, right: 25),
              width: 500,
              child: SfRangeSelector(
                min: _min,
                max: _max,
                initialValues: _initialValues,
                onChanged: (value) {
                  setState(() {
                    start = value.start;
                    end = value.end;
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
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AudioPlayingPage(
                              start: (widget.duration.inSeconds * start) / 10,
                              end: (widget.duration.inSeconds * end) / 10,
                              path: widget.url,
                              audioName: widget.audioName,
                            )));
              },
              child: const Text(
                "TRIM SHLOKA",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            height: 50,
            width: 250,
            color: Colors.blue,
            alignment: Alignment.center,
          )
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
