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
// ignore: avoid_web_libraries_in_flutter, unused_import

/*
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
    return Scaffold(

    body: Column(
     children: [
       (
         Container(
         alignment: Alignment.center,
           margin:  EdgeInsets.only(top: 140.0,left: 100),
      width: 100.0,
      height: 100.0,
      decoration:  BoxDecoration(
       border:
      Border.all(
                color: Colors.blue,
                width: 2.0 ,
              ),
      
      shape: BoxShape.circle,
      ),)),
               // ignore: prefer_const_constructors
              
               Container(
         alignment: Alignment.center,
           margin: const EdgeInsets.only(left: 100),
      width: 100.0,
      height: 40.0,
    
      child:  Text("abcdxyz"),
      
      ),

       Container(
         alignment: Alignment.center,
           margin: const EdgeInsets.only(left: 100),
      width: 100.0,
      height: 40.0,
    
      child:  Text("100 points "),
      
      ),
      Container(
        child:Scaffold(
      appBar: AppBar(
        title:  Text("Pages"),
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBar:  Material(
        color: Colors.deepOrange,
        child: TabBar( tabs: <Tab>[
           Tab(icon:  Icon(Icons.arrow_forward)),
         Tab(icon: Icon(Icons.arrow_downward)),
          Tab(icon: Icon(Icons.arrow_back)),
        ])),
      body:  TabBarView( children: <Widget>[
        const Tab(icon: Icon(Icons.arrow_forward)),
           Tab(icon: Icon(Icons.arrow_downward)),
       Tab(icon:Icon(Icons.arrow_back)),
      ]))
      )

     
     ])
     
     );
  }
}
*/

import 'package:flutter/material.dart';

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 100.0),
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
              shape: BoxShape.circle,
            ),
          ),
          // ignore: prefer_const_constructors

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 0),
            width: 100.0,
            height: 40.0,
            child: Text("abcdxyz"),
          ),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 0),
            width: 100.0,
            height: 40.0,
            child: Text("100 points "),
          ),
          TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blueAccent,
            tabs: [
              Tab(
                text: 'Badges',
              ),
              Tab(
                text: 'chats',
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(child: Center(child: Text('people'))),
                Container(child: Center(child: Text('people'))),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
