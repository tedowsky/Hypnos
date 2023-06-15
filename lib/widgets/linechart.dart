import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hypnos/databases/entities/heartrate.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:provider/provider.dart';

class LineChartWidget extends StatefulWidget {
  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, dataProvider, child) {
        List<HR> hert = dataProvider.dataListhr;
        List sleep = dataProvider.dataListsleep;

        if (hert == null) {
          return CircularProgressIndicator(); // Mostra un indicatore di caricamento o un widget alternativo mentre si attendono i dati

        }

        // Trova il valore minimo e massimo per l'asse X (DateTime)
        DateTime minX = sleep[1];
        DateTime maxX = sleep[2];

        // Trova il valore minimo e massimo per l'asse Y (frequenza cardiaca)
        int minY = hert.map((hr) => hr.value).reduce((min, value) => min < value ? min : value);
        int maxY = hert.map((hr) => hr.value).reduce((max, value) => max > value ? max : value);


        List<FlSpot> flSpots = convertToFlSpots(hert);

        return LineChart(
          LineChartData(
            minX: minX.millisecondsSinceEpoch.toDouble(),
            maxX: maxX.millisecondsSinceEpoch.toDouble(),
            minY: minY.toDouble(),
            maxY: maxY.toDouble(),
            lineBarsData: [
              LineChartBarData(
                spots: flSpots,
              ),
            ],
          ),
        );
      },
    );
  }
}

List<FlSpot> convertToFlSpots(List<HR> hert) {
  return hert
      .map((hert) => FlSpot(
          hert.dateTime.millisecondsSinceEpoch.toDouble(), hert.value.toDouble()))
      .toList();
}