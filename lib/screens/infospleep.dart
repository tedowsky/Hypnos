import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/drawer/sleepchartinfo.dart';
import 'package:hypnos/screens/drawer/phases_info.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
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

  Future<List<Sleep>>? result;

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DatabaseList()));
                    print('$result');
                  },
                  icon: const Icon(MdiIcons.databaseRefreshOutline));
            })
          ],
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover your sleep phases: \n',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Go through your sleep cycles',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 156, 100, 166),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Click here to know how to read the chart',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SleepChartInfoPage()),
                  );
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
            ]),
            const SizedBox(
              height: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Yesterday, you slept',
                  style: TextStyle(
                    color: Color.fromARGB(255, 156, 100, 166),
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '$hours hours and $remainingMinutes minutes,',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 156, 100, 166),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'of which:',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 156, 100, 166),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 400,
              width: 1000,
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  format: 'point.y min',
                ),
                // title: ChartTitle(
                //     text:
                //         'Yesterday, you slept \n $hours hours and $remainingMinutes minutes, \n of which:'),
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Click here to discover the phase balance',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhasesInfo()),
                  );
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
            ]),
            SizedBox(height: 25),
          ],
        ),

        // ),
      );
    });
  }
}

class sleepfases {
  sleepfases(this.fasename, this.faseduration, this.maximumduration);
  final String fasename;
  final int faseduration;
  final int maximumduration;
}
