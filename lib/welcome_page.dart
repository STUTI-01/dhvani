import 'package:dhvani/music_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Column(
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
          Column(
            children:[
              const Text("WELCOME", style: TextStyle(
                fontSize: 50, 
                fontWeight: FontWeight.bold
              ),),
              const Text("TO", style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold
              ),),
              const Text("DHVANI\n", style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold
              ),),
              Container(
            margin: const EdgeInsets.only(top: 50),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MusicListPage()));
              },
              child: const Text(
                "VIEW ALL SHLOKAS",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            height: 50,
            width: 250,
            color: Colors.blue,
            alignment: Alignment.center,
          )
            ],
          )
        ],
      ),
    );
  }
}