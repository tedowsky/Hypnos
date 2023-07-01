import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/heartrate.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/provider/provider.dart';
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
      Sleep sleep = dataProvider.datasleep;
           
      DateTime start = sleep.startTime;
      DateTime end = sleep.endTime;
      int rem = sleep.rem;
      int deep = sleep.deep;
      int light = sleep.light;
      int wake = sleep.wake;
      int total = rem + deep + light + wake;
      int hours = total ~/ 60; // Divide by 60 to get the number of hours
      int remainingMinutes = total % 60; // Use the modulo operator to get the remaining minutes

      String timeString = '$hours hours $remainingMinutes minutes';
       // Output: 2 hours 15 minutes
      List phases = dataProvider.dataListsleep; 
      print('ciao');

      List<Map<String, dynamic>> mappedData = phases.map((data) {
        DateFormat hourformat = DateFormat("MM-dd HH:mm:ss");
        DateTime dateTime = hourformat.parse(data['dateTime']);

        int seconds = data['seconds'] as int;
        String level = data['level'] as String;

        // Restituisci una nuova mappa contenente le informazioni desiderate
        return {
          'dateTime': dateTime,
          'seconds': seconds,
          'level': level,
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
                    print('$result');
                    print('ciao');
                  },
                  icon: const Icon(MdiIcons.databaseRefreshOutline));
            })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 150, 25, 10),
          child: ListView(
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

              Container(
                child: Column(
                  children: [
                    SleepChartWidget(
                      sleepData: mappedData,
                    ),
                    // SleepChartWidget(
                    //   faseName: 'Deep',
                    //   faseDuration: 90,
                    //   maximumValue: 150,
                    //   color: Colors.orange,
                    // ),
                    // SleepChartWidget(
                    //   faseName: 'Light',
                    //   faseDuration: 180,
                    //   maximumValue: 250,
                    //   color: _getFaseColor('Light'),
                    // ),
                    // SleepChartWidget(
                    //   faseName: 'Wake',
                    //   faseDuration: 60,
                    //   maximumValue: 100,
                    //   color: _getFaseColor('Wake'),
                    // ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Text('Your Sleep'),
              SizedBox(
                height: 450,
                width: 1000,
                child: SfCircularChart(
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    format: 'point.y min',
                  ),
                  title:
                      ChartTitle(text: 'Yesterday, you slept \n $hours hours and $remainingMinutes minutes, \n of which:'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      textStyle: TextStyle(fontSize: 20),),
                    series: <CircularSeries>[
                    DoughnutSeries<sleepfases, String>(
                        dataSource: chartData,
                        xValueMapper: (sleepfases data, _) => data.fasename,
                        yValueMapper: (sleepfases data, _) => data.faseduration,
                        dataLabelMapper: (sleepfases data, _) =>
                        '${(data.faseduration/total*100).toStringAsFixed(2)} %',
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                          labelIntersectAction: LabelIntersectAction.none
                          ))
                  ],
                   
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Text('Your Sleep'),
              SizedBox(
                height: 300,
                width: 500,
                child: SfCircularChart(
                  title:
                      ChartTitle(text: 'Yesterday, you slept \n ${(total/60).toStringAsFixed(2)} hours  \n of which:'),
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  series: <CircularSeries>[
                    RadialBarSeries<sleepfases, String>(
                        dataSource: chartData,
                        xValueMapper: (sleepfases data, _) => data.fasename,
                        yValueMapper: (sleepfases data, _) => data.faseduration,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        maximumValue: 400)
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              SizedBox(
                height: 400,
                width: 1000,
                // Aggiungi qui il tuo widget o contenuto desiderato
                child: Consumer<HomeProvider>(
                    builder: (context, HomeProvider, child) {
                  return LineChartWidget();
                }),
              )

              // Consumer<HomeProvider>(
              //     builder: (context, value, child) =>
              //         CustomPlot(data: _parseData(value.heartRates)))
              //         // Aggiungi altri widget o contenuto
            ],
          ),
        ),
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

Color _getFaseColor(String faseName) {
    switch (faseName) {
      case 'REM':
        return Colors.blue;
      case 'Deep':
        return Colors.orange;
      case 'Light':
        return Colors.green;
      case 'Wake':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  List<Map<String, dynamic>> _parseData(List<db.HR> data) {
    return data
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.dateTime),
            'points': e.value
          },
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
