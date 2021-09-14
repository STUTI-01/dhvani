import 'package:dhvani/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({Key? key}) : super(key: key);

  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  List dhyayeNityam = [
    {"line": "Dhyaye Nityam Mahesham, Rajatgirnibham", "time": 4},
    {"line": "Charuchandra Vatansam, Ratnakalpo Jwalangam", "time": 12},
    {"line": "Parashumrigvarabhivihastam Prasannam", "time": 22},
    {"line": "Padmaseelam Samantaat", "time": 30},
    {"line": "Stutmamarganayehi Vgyagratkrityamvasanam", "time": 35},
    {"line": "Vishwadhyam Vishwavandam Nikhilbhayaharam", "time": 42},
    {"line": "Panchvatram Trinetram", "time": 50}
  ];
  List gayatriMantra = [
    {"line": "Om Bhur Bhuvaḥ Swaḥ", "time": 8},
    {"line": "Tat-savitur Vareñyaṃ", "time": 12},
    {"line": "Bhargo Devasya Dheemahi", "time": 16},
    {"line": "Dhiyo Yonaḥ Prachodayāt", "time": 20},
    {"line": "Om Bhur Bhuvaḥ Swaḥ", "time": 24},
    {"line": "Tat-savitur Vareñyaṃ", "time": 28},
    {"line": "Bhargo Devasya Dheemahi", "time": 32},
    {"line": "Dhiyo Yonaḥ Prachodayāt", "time": 36}
  ];
  List guruBrahma = [
    {"line": "GururBrahma", "time": 9},
    {"line": "GururVishnu", "time": 13},
    {"line": "GururDevo", "time": 16},
    {"line": "Maheshwaraha", "time": 18},
    {"line": "Guru Saakshaat", "time": 22},
    {"line": " ParaBrahma", "time": 25},
    {"line": "Tasmai Sri Gurave Namaha", "time": 27},
    {"line": "GururBrahma", "time": 34},
    {"line": "GururVishnu", "time": 37},
    {"line": "GururDevo", "time": 40},
    {"line": "Maheshwaraha", "time": 42},
    {"line": "Guru Saakshaat", "time": 46},
    {"line": " ParaBrahma", "time": 49},
    {"line": "Tasmai Sri Gurave Namaha", "time": 51},
    {"line": "GururBrahma", "time": 60},
    {"line": "GururVishnu", "time": 64},
    {"line": "GururDevo", "time": 66},
    {"line": "Maheshwaraha", "time": 69},
    {"line": "Guru Saakshaat", "time": 73},
    {"line": " ParaBrahma", "time": 76},
    {"line": "Tasmai Sri Gurave Namaha", "time": 78}
  ];
  List mahaMrutyunjaya = [
    {"line": "Aum Tryambakam yajaamahe", "time": 10},
    {"line": "sugandhim pushtivardhanam", "time": 12},
    {"line": "Urvaarukamiva bandhanaan", "time": 16},
    {"line": "mrityormuksheeya maamritaat", "time": 19},
    {"line": "Aum Tryambakam yajaamahe", "time": 29},
    {"line": "sugandhim pushtivardhanam", "time": 32},
    {"line": "Urvaarukamiva bandhanaan", "time": 36},
    {"line": "mrityormuksheeya maamritaat", "time": 39},
    {"line": "Aum Tryambakam yajaamahe", "time": 48},
    {"line": "sugandhim pushtivardhanam", "time": 52},
    {"line": "Urvaarukamiva bandhanaan", "time": 55},
    {"line": "mrityormuksheeya maamritaat", "time": 58}
  ];
  List sarveBhavantu = [
    {"line": " Sarve bhavantu sukhinaḥ", "time": 0},
    {"line": "Sarve santu nirāmayāḥ", "time": 7},
    {"line": "Sarve bhadrāṇi paśyantu", "time": 15},
    {"line": "Mā kashchit duḥkha bhāgbhavet", "time": 23},
    {"line": "Om ", "time": 32}
  ];
  List assetAudios = [
    {
      "title": "Dhyaye Nityam",
      "path": "assets\Audio\dhyaye nityam.mp3",
      "duration": "1 min",
      "seconds": 60.0,
    },
    {
      "title": "Gayatri Mantra",
      "path": "assets\Audio\gayatri-mantra-raga-1 (mp3cut.net).mp3",
      "duration": "39 secs",
      "seconds": 39.0,
    },
    {
      "title": "Guru Brahma Guru Vishnu",
      "path": "assets\Audio\Guru Brahma Guru Vishnu - (Raag.Fm).mp3",
      "duration": "1:24 min",
      "seconds": 84.0,
    },
    {
      "title": "Maha Mrutyunjaya Mantra",
      "path":
          "assets\Audio\Maha-Mrutyunjaya-Mantra-108-cycles (mp3cut.net).mp3",
      "duration": "1:04 min",
      "seconds": 64.0,
    },
    {
      "title": "Sarve Bhavantu",
      "path": "assets\Audio\Sarve Bhavantu.mp3",
      "duration": "34 secs",
      "seconds": 34.0,
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
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 25,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.08),
                  child: const Text("Shloka List Page",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: assetAudios.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Test(
                                        start: 0.0,
                                        //TODO
                                        end: assetAudios[index]['seconds'],
                                        url: assetAudios[index]['path'],
                                        audioName: assetAudios[index]['title'],
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
                                      assetAudios[index]['title'],
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "\n" + assetAudios[index]['duration'],
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
