import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/heartrate.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/drawer/sleepchartinfo.dart';
import 'package:hypnos/screens/drawer/phases_info.dart';
import 'package:hypnos/services/impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:hypnos/widgets/bargraph/bar_graph.dart';
import 'package:hypnos/widgets/custom_plot.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/databases/entities/entities.dart' as db;
import 'package:provider/provider.dart';
import 'package:hypnos/widgets/linechart.dart';
import 'package:hypnos/widgets/sleepchart.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Infosleep extends StatefulWidget {
  const Infosleep({Key? key}) : super(key: key);

  @override
  State<Infosleep> createState() => _InfosleepState();
}

class _InfosleepState extends State<Infosleep> {
  @override
  void initState() {
    super.initState();
  }

  // Map<String, dynamic> summarylevelsleep = {};
  // var deep = [];
  // var wake = [];
  // var light = [];
  // var rem = [];
  // List sleepstages = [];

  Future<List<HR>>? result;

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<HomeProvider>(
    //   create: (context) => HomeProvider(
    //       ImpactService(Provider.of<Preferences>(context, listen: false)),
    //       Provider.of<AppDatabase>(context, listen: false)),
    //   lazy: false,
    //   builder: (context, child) =>
    return Consumer<HomeProvider>(builder: (context, dataProvider, child) {
      //SECONDO GRAFICO --> TORTA
      Sleep sleep = dataProvider.datasleep;

      DateTime start = sleep.startTime;
      DateTime end = sleep.endTime;
      int rem = sleep.rem;
      int deep = sleep.deep;
      int light = sleep.light;
      int wake = sleep.wake;
      int total = rem + deep + light + wake;
      int hours = total ~/ 60;
      int remainingMinutes = total % 60;

      String timeString = '$hours hours $remainingMinutes minutes';

      // PRIMO GRAFICO --> STEPLINE
      List phases = dataProvider.dataListsleep;

      List<Map<String, dynamic>> mappedData = phases.map((data) {
        DateFormat hourformat = DateFormat("MM-dd HH:mm:ss");
        DateTime dateTime = hourformat.parse(data['dateTime']);

        int seconds = data['seconds'] as int;
        String level = data['level'] as String;

        // Mappatura tra fase di sonno e numero
        Map<String, int> phaseMap = {
          'rem': 2,
          'wake': 1,
          'light': 3,
          'deep': 4,
        };

        // Ottieni il numero corrispondente alla fase di sonno
        int phaseNumber = phaseMap[level] ?? 0;

        // Restituisci una nuova mappa contenente le informazioni desiderate
        return {
          'dateTime': dateTime,
          'seconds': seconds,
          'level': phaseNumber,
        };
      }).toList();

      print('ciao');

      final List<sleepfases> chartData = [
        sleepfases('rem', rem, 180),
        sleepfases('deep', deep, 150),
        sleepfases('light', light, 300),
        sleepfases('wake', wake, 60),
      ];

      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 172, 143, 192),
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          title: const Text('Know More About Your Sleep',
              style: TextStyle(color: Colors.black)),
          actions: [
            Consumer<AppDatabase>(builder: (context, db, child) {
              return IconButton(
                  onPressed: () async {
                    result = db.heartRatesDao.findHeartRatesbyDate(start, end);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DatabaseList()));
                    print('$result');
                    print('ciao');
                  },
                  icon: const Icon(MdiIcons.databaseRefreshOutline));
            })
          ],
        ),
        body: //Padding(
            //padding: const EdgeInsets.fromLTRB(25, 150, 25, 10),
            //child:
            ListView(
          children: [
            // SizedBox(
            //   height: 80,
            //   width: 300,
            //   child: MyBarGraph(
            //    sleepstages: sleepstages,
            //   ),
            // ),
            const SizedBox(
              height: 25,
            ),

            Text('Your Sleep'),

            SizedBox(
              height: 500,
              width: 1000,
              child: SleepChartWidget(
                sleepData: mappedData,
              ),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Color.fromRGBO(131, 190, 200, 1),
                ),
                SizedBox(width: 5),
                Text('Wake'),
                SizedBox(width: 15),
                Container(
                  width: 20,
                  height: 20,
                  color: Color.fromRGBO(193, 85, 101, 1),
                ),
                SizedBox(width: 5),
                Text('REM'),
                SizedBox(width: 15),
                Container(
                  width: 20,
                  height: 20,
                  color: Color.fromRGBO(186, 186, 130, 1),
                ),
                SizedBox(width: 5),
                Text('Light'),
                SizedBox(width: 15),
                Container(
                  width: 20,
                  height: 20,
                  color: Color.fromRGBO(54, 74, 186, 1),
                ),
                SizedBox(width: 5),
                Text('Deep'),
              ],
            ),

            const SizedBox(
              height: 25,
            ),

            Text('Your Sleep'),
            SizedBox(
              height: 450,
              width: 1200,
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  format: 'point.y min',
                ),
                title: ChartTitle(
                    text:
                        'Yesterday, you slept \n $hours hours and $remainingMinutes minutes, \n of which:'),
                legend: Legend(
                  position: LegendPosition.top,
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: TextStyle(fontSize: 20),
                ),
                series: <CircularSeries>[
                  DoughnutSeries<sleepfases, String>(
                      dataSource: chartData,
                      xValueMapper: (sleepfases data, _) => data.fasename,
                      yValueMapper: (sleepfases data, _) => data.faseduration,
                      dataLabelMapper: (sleepfases data, _) =>
                          '${(data.faseduration / total * 100).toStringAsFixed(2)} %',
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                          labelIntersectAction: LabelIntersectAction.none))
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ), 

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PhasesInfo(),
                          ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
              ),
              child: Text(
                'Learn More About the Phases',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

            SizedBox(height: 25),


            SizedBox(
              height: 400,
              width: 1000,
              // Aggiungi qui il tuo widget o contenuto desiderato
              child: Consumer<HomeProvider>(
                  builder: (context, HomeProvider, child) {
                return LineChartWidget();
              }),
            ),
            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SleepChartInfoPage(),
                          ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
              ),
              child: Text(
                'Learn More',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

            SizedBox(height: 25),

            // Consumer<HomeProvider>(
            //     builder: (context, value, child) =>
            //         CustomPlot(data: _parseData(value.heartRates)))
            //         // Aggiungi altri widget o contenuto
          ],
        ),

        // ),
      );
    });
  }

//   void updateSleepStages() async {
//     summarylevelsleep = await Provider.of<ImpactService>(context, listen: false)
//         .getsummarylevelsSleepData(DateTime.now().subtract(const Duration(days: 1)));
//     deep = summarylevelsleep['deep_summary']['minutes'];
//     wake = summarylevelsleep['wake_summary']['minutes'];
//     light = summarylevelsleep['light_summary']['minutes'];
//     rem = summarylevelsleep['rem_summary']['minutes'];
//     sleepstages = [rem, deep, light];
//     setState(() {}); // Aggiungi questo per aggiornare il widget
//   }
// }

// Color _getFaseColor(String faseName) {
//     switch (faseName) {
//       case 'REM':
//         return Colors.blue;
//       case 'Deep':
//         return Colors.orange;
//       case 'Light':
//         return Colors.green;
//       case 'Wake':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
  List<Map<String, dynamic>> _parseData(List<db.HR> data) {
    return data
        .map(
          (e) =>
              {'date': DateFormat('HH:mm').format(e.dateT), 'points': e.value},
        )
        .toList();
  }
}

class sleepfases {
  sleepfases(this.fasename, this.faseduration, this.maximumduration);
  final String fasename;
  final int faseduration;
  final int maximumduration;
}
