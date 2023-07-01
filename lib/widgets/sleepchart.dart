import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> sleepData;

  SleepChartWidget({required this.sleepData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: CategoryAxis(),
        series: <BarSeries<Map<String, dynamic>, DateTime>>[
          BarSeries<Map<String, dynamic>, DateTime>(
            dataSource: sleepData,
            xValueMapper: (data, _) => (data['dateTime']),
            yValueMapper: (data, _) => data['level'],
          ),
        ],
      ),
    );
  }
}
