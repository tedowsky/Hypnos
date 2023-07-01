// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:hypnos/databases/db.dart';
// import 'package:hypnos/databases/entities/heartrate.dart';
// import 'package:hypnos/provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class LineChartSleepPhasesWidget extends StatefulWidget {
//   @override
//   State<LineChartSleepPhasesWidget> createState() => _LineChartSleepPhasesWidgetState();
// }

// class _LineChartSleepPhasesWidgetState extends State<LineChartSleepPhasesWidget> {
//   final List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff02d39a),
//   ];


//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeProvider>(
//       builder: (context, dataProvider, child) {
//         List sleep = dataProvider.dataListsleep;


//         DateTime minX = sleep.first.dateTime;
//         DateTime maxX = sleep.last.dateTime;

//         // Trova il valore minimo e massimo per l'asse X (DateTime)
//             // String sleepDatamin = sleep[1];
//             // DateFormat formatmin = DateFormat('MM-dd HH:mm:ss');
//             // DateTime start = formatmin.parse(sleepDatamin);

//             // String sleepDatamax = sleep[1];
//             // DateFormat formatmax = DateFormat('MM-dd HH:mm:ss');
//             // DateTime end = formatmax.parse(sleepDatamax);

//         // Trova il valore minimo e massimo per l'asse Y (frequenza cardiaca)
//         int minY = sleep.map((hr) => hr.value).reduce((min, value) => min < value ? min : value);
//         int maxY = sleep.map((hr) => hr.value).reduce((max, value) => max > value ? max : value);


//         List<FlSpot> flSpots = convertToFlSpots(hert);
//         // Consumer<AppDatabase>(
//         //   builder: (context, db, child) {
//         //     result = db.heartRatesDao.findHeartRatesbyDate(start, end);
//         return LineChart(
//           LineChartData(
//             minX: minX.millisecondsSinceEpoch.toDouble(),
//             maxX: maxX.millisecondsSinceEpoch.toDouble(),
//             minY: minY.toDouble(),
//             maxY: maxY.toDouble(),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: flSpots,
//               ),
//             ],
//           ),
//         );
//           }
//       //  );
//       //},
//     );
//   }
// }

// List<FlSpot> convertToFlSpots(List sleep) {
//   return sleep
//       .map((hert) => FlSpot(
//           sleep.dateTime.millisecondsSinceEpoch.toDouble(), hert.value.toDouble()))
//       .toList();
// }