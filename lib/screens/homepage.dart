import 'package:hypnos/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/screens/infosleep.dart';
import 'package:hypnos/widgets/custom_plot.dart';
import 'package:hypnos/widgets/score_circular_progress.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeDisplayname = 'HomePage';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final aqi = 20;
  int _selIdx = 0;

  void changePage(int index) {
    setState(() {
      _selIdx = index;
    });
  }

// Widget selectPage(int index){
//   switch(index){
//     case 0:
//       return Home();
//     case 1:
//       return Advices();
//     default:
//       return Home();
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer( backgroundColor: const Color.fromARGB(255, 106, 93, 161),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(MdiIcons.logout),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
                const Text('About'),
                ListTile(
                  leading: const Icon(MdiIcons.sleep),
                  title: const Text('About Hypnos'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(MdiIcons.bed),
                  title: const Text('Sleep facts'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor:  const Color.fromARGB(255, 172, 143, 192),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 144, 111, 160)),
          title: const Text('- Hypnos -', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ProfilePage()));
                },
                icon: const Icon(Icons.person_pin))
          ],
        ),
        backgroundColor: const Color(0xFFE4DFD4),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [ 
                    const Icon(MdiIcons.mapMarker), 
                    const Text('Padua, Italy'),
                  ],
                ),
                const Text('Sleep Quality'),
                const Padding(padding: EdgeInsets.all(25.0)),
                Row(children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CustomPaint(
                      painter: ScoreCircularProgress(
                        backColor: const Color(0xFF89453C).withOpacity(0.4),
                        frontColor: const Color(0xFF89453C),
                        strokeWidth: 20,
                        value: aqi / 100,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 140,
                  ),
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CustomPaint(
                      painter: ScoreCircularProgress(
                        backColor: const Color(0xFF89453C).withOpacity(0.4),
                        frontColor: const Color(0xFF89453C),
                        strokeWidth: 20,
                        value: aqi / 100,
                      ),
                    ),
                  ),
                ],),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: CustomPaint(                   
                      painter: ScoreCircularProgress(
                        backColor: const Color(0xFF89453C).withOpacity(0.4),
                        frontColor: const Color(0xFF89453C),
                        strokeWidth: 20,
                        value: aqi / 100,
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '$aqi %',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xFF89453C)),
                                  ),
                                  const Text(    // add if condition about the efficiency value
                                    ' Not good',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ]),
                          ))),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Center(child: const Text('Efficiency')),
                    const  Icon(Icons.info_outline),
                    // Center(child: Text('PM2.5 Concentration')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_left)),
                    Text('${DateFormat('dd MM yyyy').format(DateTime.now())}'),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right)),
                  ],
                ),
                CustomPlot(data: data),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => infosleep(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Know more'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ));
    //   body: selectPage(_selIdx) ,
    // bottomNavigationBar: BottomNavigationBar(
    //   currentIndex: _selIdx,
    //   onTap: ((value) => changePage(value)),
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.abc), label: 'Air Pollution'),
    //        BottomNavigationBarItem(
    //       icon: Icon(Icons.abc), label: 'Personal exposure'),
    // ]) ,
  }
}

List<Map<String, dynamic>> data = [
  {'date': '2021-10-01', 'points': 1468},
  {'date': '2021-10-01', 'points': 1487},
  {'date': '2021-10-01', 'points': 1494},
  {'date': '2021-10-02', 'points': 1526},
  {'date': '2021-10-02', 'points': 1492},
  {'date': '2021-10-02', 'points': 1470},
  {'date': '2021-10-02', 'points': 1477},
  {'date': '2021-10-03', 'points': 1466},
  {'date': '2021-10-03', 'points': 1465},
  {'date': '2021-10-03', 'points': 1524},
  {'date': '2021-10-03', 'points': 1534},
  {'date': '2021-10-04', 'points': 1504},
  {'date': '2021-10-04', 'points': 1524},
  {'date': '2021-10-05', 'points': 1534},
  {'date': '2021-10-06', 'points': 1463},
  {'date': '2021-10-07', 'points': 1502},
  {'date': '2021-10-07', 'points': 1539},
  {'date': '2021-10-08', 'points': 1476},
  {'date': '2021-10-08', 'points': 1483},
  {'date': '2021-10-08', 'points': 1534},
  {'date': '2021-10-08', 'points': 1530},
  {'date': '2021-10-09', 'points': 1519},
  {'date': '2021-10-09', 'points': 1497},
  {'date': '2021-10-09', 'points': 1460},
  {'date': '2021-10-10', 'points': 1514},
  {'date': '2021-10-10', 'points': 1518},
  {'date': '2021-10-10', 'points': 1470},
  {'date': '2021-10-10', 'points': 1526},
  {'date': '2021-10-11', 'points': 1517},
  {'date': '2021-10-11', 'points': 1478},
  {'date': '2021-10-11', 'points': 1468},
  {'date': '2021-10-11', 'points': 1487},
  {'date': '2021-10-12', 'points': 1535},
  {'date': '2021-10-12', 'points': 1537},
  {'date': '2021-10-12', 'points': 1463},
  {'date': '2021-10-12', 'points': 1478},
  {'date': '2021-10-13', 'points': 1524},
  {'date': '2021-10-13', 'points': 1496},
  {'date': '2021-10-14', 'points': 1527},
  {'date': '2021-10-14', 'points': 1527},
];
