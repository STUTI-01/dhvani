import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
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
            margin: const EdgeInsets.only(top: 100.0),
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
            child: const Text("abcdxyz"),
          ),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 0),
            width: 100.0,
            height: 40.0,
            child: const Text("100 points "),
          ),
          TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blueAccent,
            tabs: const[
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
              children: const[
                Text('people'),
                Text('people'),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
