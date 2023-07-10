import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),

  ];

  LineChartWidget({super.key});

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
            const FlSpot(0, 3),
            const FlSpot(1, 4),
            const FlSpot(2.3, 5),
            const FlSpot(3.4, 3),
            const FlSpot(4.5, 7),
            const FlSpot(5.6, 2),
            const FlSpot(7, 4),
            const FlSpot(8.9, 1),  
          ]
        )
      ]
    )
  );

}