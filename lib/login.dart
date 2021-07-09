import 'package:dhvani/trim_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RotationTransition(
              alignment: Alignment.center,
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.blue.shade900, Colors.blue.shade100],
                    [Colors.blue.shade600, Colors.blue.shade100],
                    [Colors.blue, Colors.blue.shade50],
                    [Colors.blue.shade300, Colors.blue.shade50]
                  ],
                  durations: [25000, 19440, 10800, 6000],
                  heightPercentages: [0.20, 0.23, 0.40, 0.50],
                  blur: const MaskFilter.blur(BlurStyle.normal, 0.0),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                backgroundColor: Colors.transparent,
                size: const Size(1000, 300),
                waveAmplitude: 20,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.04,
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: TextField(
                controller: startController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Start',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.04,
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: TextField(
                controller: endController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'End',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TrimAudio(
                            start: double.parse(startController.text),
                            end: double.parse(endController.text))));
              },
              child: const Text('Trim Audio'),
            ),
          ],
        ),
      ),
    );
  }
}
