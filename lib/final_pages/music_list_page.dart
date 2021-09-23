import 'package:dhvani/final_pages/playing_audio_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({Key? key}) : super(key: key);

  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  List dhyayeNityam = [
    {
      "line": "Dhyaye Nityam Mahesham, Rajatgirnibham",
      "time": 4,
      "end_time": 12,
      "index": 0
    },
    {
      "line": "Charuchandra Vatansam, Ratnakalpo Jwalangam",
      "time": 12,
      "end_time": 22,
      "index": 8
    },
    {
      "line": "Parashumrigvarabhivihastam Prasannam",
      "time": 22,
      "end_time": 30,
      "index": 16
    },
    {"line": "Padmaseelam Samantaat", "time": 30, "end_time": 35, "index": 24},
    {
      "line": "Stutmamarganayehi Vgyagratkrityamvasanam",
      "time": 35,
      "end_time": 42,
      "index": 32
    },
    {
      "line": "Vishwadhyam Vishwavandam Nikhilbhayaharam",
      "time": 42,
      "end_time": 50,
      "index": 40
    },
    {"line": "Panchvatram Trinetram", "time": 50, "end_time": 60, "index": 48},
    {
      "line": "                                ",
      "time": 60,
      "end_time": 60,
      "index": 48
    },
    {
      "line": "                                ",
      "time": 60,
      "end_time": 60,
      "index": 48
    },
    {
      "line": "                                ",
      "time": 60,
      "end_time": 60,
      "index": 48
    },
    {
      "line": "                                ",
      "time": 60,
      "end_time": 60,
      "index": 48
    },
  ];
  List gayatriMantra = [
    {"line": "Om Bhur Bhuvaḥ Swaḥ", "time": 8, "end_time": 12, "index": 0},
    {"line": "Tat-savitur Vareñyaṃ", "time": 12, "end_time": 16, "index": 5},
    {
      "line": "Bhargo Devasya Dheemahi",
      "time": 16,
      "end_time": 20,
      "index": 10
    },
    {
      "line": "Dhiyo Yonaḥ Prachodayāt",
      "time": 20,
      "end_time": 24,
      "index": 15
    },
    {"line": "Om Bhur Bhuvaḥ Swaḥ", "time": 24, "end_time": 28, "index": 20},
    {"line": "Tat-savitur Vareñyaṃ", "time": 28, "end_time": 32, "index": 25},
    {
      "line": "Bhargo Devasya Dheemahi",
      "time": 32,
      "end_time": 36,
      "index": 30
    },
    {"line": "Dhiyo yo nah prachodayat", "time": 36, "end_time": 39, "index": 35},
    {"line": "                       ", "time": 36, "end_time": 39, "index": 35},
    {"line": "                       ", "time": 36, "end_time": 39, "index": 35},
    {"line": "                       ", "time": 36, "end_time": 39, "index": 35}
  ];
  List guruBrahma = [
    {"line": "GururBrahma", "time": 9, "end_time": 13, "index": 0},
    {"line": "GururVishnu", "time": 13, "end_time": 16, "index": 8},
    {"line": "GururDevo", "time": 16, "end_time": 18, "index": 16},
    {"line": "Maheshwaraha", "time": 18, "end_time": 22, "index": 24},
    {"line": "Guru Saakshaat", "time": 22, "end_time": 25, "index": 32},
    {"line": "ParaBrahma", "time": 25, "end_time": 27, "index": 40},
    {"line": "Tasmai Sri Gurave Namaha", "time": 27, "end_time": 34, "index": 48},
    {"line": "GururBrahma", "time": 34, "end_time": 37, "index": 56},
    {"line": "GururVishnu", "time": 37, "end_time": 40, "index": 64},
    {"line": "GururDevo", "time": 40, "end_time": 42, "index": 72},
    {"line": "Maheshwaraha", "time": 42, "end_time": 46, "index": 80},
    {"line": "Guru Saakshaat", "time": 46, "end_time": 49, "index": 88},
    {"line": "ParaBrahma", "time": 49, "end_time": 51, "index": 96},
    {"line": "Tasmai Sri Gurave Namaha", "time": 51, "end_time":60, "index": 104},
    {"line": "GururBrahma", "time": 60, "end_time": 64, "index": 112},
    {"line": "GururVishnu", "time": 64, "end_time": 66, "index": 120},
    {"line": "GururDevo", "time": 66, "end_time": 69, "index": 128},
    {"line": "Maheshwaraha", "time": 69, "end_time": 73, "index": 136},
    {"line": "Guru Saakshaat", "time": 73, "end_time": 76, "index": 144},
    {"line": " ParaBrahma", "time": 76, "end_time": 78, "index": 152},
    {"line": "Tasmai Sri Gurave Namaha", "time": 78, "end_time": 84, "index": 160}
  ];
  List mahaMrutyunjaya = [
    {"line": "Aum Tryambakam yajaamahe", "time": 10, "end_time": 12, "index": 0},
    {"line": "sugandhim pushtivardhanam", "time": 12, "end_time": 16, "index": 8},
    {"line": "Urvaarukamiva bandhanaan", "time": 16, "end_time": 19, "index": 16},
    {"line": "mrityormuksheeya maamritaat", "time": 19, "end_time": 29, "index": 24},
    {"line": "Aum Tryambakam yajaamahe", "time": 29, "end_time": 32, "index": 32},
    {"line": "sugandhim pushtivardhanam", "time": 32, "end_time": 36, "index": 40},
    {"line": "Urvaarukamiva bandhanaan", "time": 36, "end_time": 39, "index": 48},
    {"line": "mrityormuksheeya maamritaat", "time": 39, "end_time": 48, "index": 56},
    {"line": "Aum Tryambakam yajaamahe", "time": 48, "end_time": 52, "index": 64},
    {"line": "sugandhim pushtivardhanam", "time": 52, "end_time": 55, "index": 72},
    {"line": "Urvaarukamiva bandhanaan", "time": 55, "end_time": 58, "index": 80},
    {"line": "mrityormuksheeya maamritaat", "time": 58, "end_time": 64, "index": 88}
  ];
  List sarveBhavantu = [
    {"line": "Sarve bhavantu sukhinaḥ", "time": 0, "end_time": 7, "index": 0},
    {"line": "Sarve santu nirāmayāḥ", "time": 7, "end_time": 15, "index": 8},
    {"line": "Sarve bhadrāṇi paśyantu", "time": 15, "end_time": 23, "index": 16},
    {"line": "Mā kashchit duḥkha bhāgbhavet", "time": 23, "end_time": 32, "index": 24},
    {"line": "Om ", "time": 32, "end_time": 34, "index": 32}
  ];
  List assetAudios = [];
  @override
  void initState() {
    assetAudios = [
      {
        "title": "Dhyaye Nityam",
        "path": "assets/Audio/dhyaye nityam.mp3",
        "duration": "1 min",
        "seconds": 60.0,
        "lyrics": dhyayeNityam,
      },
      {
        "title": "Gayatri Mantra",
        "path": "assets/Audio/gayatri-mantra-raga-1 (mp3cut.net).mp3",
        "duration": "39 secs",
        "seconds": 39.0,
        "lyrics": gayatriMantra
      },
      {
        "title": "Guru Brahma Guru Vishnu",
        "path": "assets/Audio/Guru Brahma Guru Vishnu - (Raag.Fm).mp3",
        "duration": "1:24 min",
        "seconds": 84.0,
        "lyrics": guruBrahma
      },
      {
        "title": "Maha Mrutyunjaya Mantra",
        "path":
            "assets/Audio/Maha-Mrutyunjaya-Mantra-108-cycles (mp3cut.net).mp3",
        "duration": "1:04 min",
        "seconds": 64.0,
        "lyrics": mahaMrutyunjaya
      },
      {
        "title": "Sarve Bhavantu",
        "path": "assets/Audio/Sarve Bhavantu.mp3",
        "duration": "34 secs",
        "seconds": 34.0,
        "lyrics": sarveBhavantu
      }
    ];
    super.initState();
  }

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
                                  builder: (context) => AudioPlayingPage(
                                        start: 0.0,
                                        //TODO
                                        end: assetAudios[index]['seconds'],
                                        path: assetAudios[index]['path'],
                                        audioName: assetAudios[index]['title'],
                                        lyrics: assetAudios[index]['lyrics'],
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
