import 'package:flutter/material.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/drawer/sleepchartinfo.dart';
import 'package:hypnos/screens/drawer/phases_info.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/widgets/sleepchart.dart';
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

  Future<List<Sleep>>? result;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, dataProvider, child) {
      //SECONDO GRAFICO --> TORTA
      Sleep? sleep = dataProvider.datasleep;

      // PRIMO GRAFICO --> STEPLINE
      List? phases = dataProvider.dataListsleep;

      List<Map<String, Object>>? mappedData = phases?.map((data) {
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

      final List<Sleepfases> chartData = [
        Sleepfases('rem', sleep?.rem, 180),
        Sleepfases('deep', sleep?.deep, 150),
        Sleepfases('light', sleep?.light, 300),
        Sleepfases('wake', sleep?.wake, 60),
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
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Column(
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
                    color: Color.fromARGB(255, 156, 100, 166),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            if (mappedData != null)
              SizedBox(
                height: 500,
                width: 1000,
                child: SleepChartWidget(
                  sleepData: mappedData,
                ),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: const Color.fromRGBO(131, 190, 200, 1),
                ),
                const SizedBox(width: 5),
                const Text('Wake'),
                const SizedBox(width: 15),
                Container(
                  width: 20,
                  height: 20,
                  color: const Color.fromRGBO(193, 85, 101, 1),
                ),
                const SizedBox(width: 5),
                const Text('REM'),
                const SizedBox(width: 15),
                Container(
                  width: 20,
                  height: 20,
                  color: const Color.fromRGBO(186, 186, 130, 1),
                ),
                const SizedBox(width: 5),
                const Text('Light'),
                const SizedBox(width: 15),
                Container(
                  width: 20,
                  height: 20,
                  color: const Color.fromRGBO(54, 74, 186, 1),
                ),
                const SizedBox(width: 5),
                const Text('Deep'),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
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
                        builder: (context) => const SleepChartInfoPage()),
                  );
                },
                icon: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.black,
              indent: 25,
              endIndent: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Yesterday, you slept',
                  style: TextStyle(
                    color: Color.fromARGB(255, 156, 100, 166),
                    fontSize: 16.0,
                  ),
                ),
                if (sleep != null)
                  Text(
                    '${sleep.endTime.difference(sleep.dateTime).inMinutes / 60} hours and ${sleep.endTime.difference(sleep.dateTime).inMinutes % 60} minutes',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 156, 100, 166),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                const Text(
                  'of which:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 156, 100, 166),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            if (sleep != null)
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
                  legend: const Legend(
                    position: LegendPosition.top,
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  series: <CircularSeries>[
                    DoughnutSeries<Sleepfases, String>(
                        dataSource: chartData,
                        xValueMapper: (Sleepfases data, _) => data.fasename,
                        yValueMapper: (Sleepfases data, _) => data.faseduration,
                        dataLabelMapper: (Sleepfases data, _) =>
                            '${(data.faseduration! / sleep.endTime.difference(sleep.dateTime).inMinutes * 100).toStringAsFixed(2)} %',
                        dataLabelSettings: const DataLabelSettings(
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
              const Text(
                'Click here to discover the phase balance',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PhasesInfo()),
                  );
                },
                icon: const Icon(
                  Icons.info,
                  color: Colors.black,
                ),
              ),
            ]),
            const SizedBox(height: 25),
          ],
        ),

        // ),
      );
    });
  }
}

class Sleepfases {
  Sleepfases(this.fasename, this.faseduration, this.maximumduration);
  final String fasename;
  final int? faseduration;
  final int maximumduration;
}
