import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),

  ];

  @override
  Widget build(BuildContext context) =>  LineChart(

    LineChartData(
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 12,
      lineBarsData: [
        LineChartBarData(
          spots: [
            // initial point of the graph
            FlSpot(0, 3),
            FlSpot(1, 4),
            FlSpot(2.3, 5),
            FlSpot(3.4, 3),
            FlSpot(4.5, 7),
            FlSpot(5.6, 2),
            FlSpot(7, 4),
            FlSpot(8.9, 1),  
          ]
        )
      ]
    )
  );

}