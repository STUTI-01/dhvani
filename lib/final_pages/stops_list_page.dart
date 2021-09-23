import 'package:dhvani/final_pages/playing_audio_page.dart';
import 'package:flutter/material.dart';

class StopsListPage extends StatefulWidget {
  final List stopsList;
  const StopsListPage({ Key? key, required this.stopsList}) : super(key: key);

  @override
  _StopsListPageState createState() => _StopsListPageState();
}

class _StopsListPageState extends State<StopsListPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: topPadding * 1.2, left: width * 0.05, right: width * 0.05),
        child: Column(
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 25,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.08),
                  child: const Text("Stops List Page",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.stopsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AudioPlayingPage(
                                        start: double.parse(widget.stopsList[index]["start"].toString()),
                                        //TODO
                                        end: double.parse(widget.stopsList[index]["end"].toString()),
                                        path: widget.stopsList[index]["path"],
                                        audioName:widget.stopsList[index]["audioName"],
                                        lyrics: widget.stopsList[index]["lyrics"],
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: height * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: height * 0.15,
                                  width: width * 0.3,
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
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                     widget.stopsList[index]["audioName"] + " - " + widget.stopsList[index]["name"] ,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "\n" +  (widget.stopsList[index]["end"] - widget.stopsList[index]["start"] ).toString() + "  secs" ,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
