
// ignore_for_file: non_constant_identifier_names

// Import package
import 'package:record/record.dart';

import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({ Key? key }) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
late bool result ;

Future<void> func() async { 
result = await Record().hasPermission();
}



Future<void> Record1() async {
 
  await Record().start(
  path: 'hbej/myFile.m4a', // required
  encoder: AudioEncoder.AAC, // by default
  bitRate: 128000, // by default
  samplingRate: 44100, // by default
);
  
}

@override
  void initState() {
    // TODO: implement initState
    func();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return ElevatedButton(
            style: style,
            onPressed: () {
              Record1();
            },
            child: const Text('record'),
      
    );
  }
}