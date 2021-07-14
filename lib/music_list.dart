import 'package:dhvani/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({ Key? key }) : super(key: key);

  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {

  List musicList = [
    {
      "title" : "Ganapati Mantra",
      "url" : "https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/Ganesha_Chant_108_Times_Ganapathi_Mantra.mp3?alt=media&token=d030ce3e-d586-49f8-8b6b-2ffec22bcef5",
      "duration"  : "20:37 mins",
      "seconds" : 1237.0
    },{
      "title" : "Navagraha Mantras",
      "url" : "https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/NAVAGRAHA_MANTRAS.mp3?alt=media&token=0e7913fc-c82c-4c39-b3a3-3c1064e2f0a4",
      "duration"  : "34:54 mins",
      "seconds" : 2094.0
    },{
      "title" : "Gayatri Mantra",
      "url" : "https://firebasestorage.googleapis.com/v0/b/dhvani-aa814.appspot.com/o/Rudrathi-Gayatri-Mantra.mp3?alt=media&token=493708bc-27da-40e5-9367-7c9a0f3bada7",
      "duration"  : "30:37 mins",
      "seconds" : 1837.0
    }
  ];

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
                      icon: const Icon(Icons.chevron_left, size: 25,)),
                ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.08),
              child: const Text("Shloka List Page",
              style : TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
            )
              ],
            ),
            Expanded(child: 
            ListView.builder(
            shrinkWrap: true,
            itemCount: musicList.length,
            itemBuilder: 
            (BuildContext context, int index)
            {
              return 
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Test(
                            start: 0.0,
                            end: musicList[index]['seconds'],
                            url : musicList[index]['url'],
                            audioName: musicList[index]['title'],
                            )));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.01),
                decoration : BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(7),
                ),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                    height: height * 0.15,
                    width: width * 0.3,
                decoration : BoxDecoration(
                  color: Colors.blue,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 5,)],
                  borderRadius: BorderRadius.circular(7),
                )),
                Padding(
                  padding: EdgeInsets.only(left : width * 0.05),
                  child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(musicList[index]['title'], style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),),
                      Text("\n" + musicList[index]['duration'], style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),)
                    ],
                  ),
                ),
                ],),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}