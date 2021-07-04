/*
Common Widgets in flutter
1. Container
2. Row
3. Column
4. Buttons
5. Sized Box
6. Text
7. TextField
8. App Bar
9. Stack
10. List View
*/
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  //create a list of 4 users with name, age , srn
  late List<Map> audios;

  @override
  void initState() {
    super.initState();
    audios = [
      {
        "title": "song1",
        "time": 10,
        "stops": [0.5, 1.0, 7.9]
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
