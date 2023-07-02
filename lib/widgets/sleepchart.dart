import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> sleepData;

  SleepChartWidget({required this.sleepData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SfCartesianChart(
        crosshairBehavior: CrosshairBehavior(
          enable: true
        ),
        
        legend: Legend(isVisible: true),
        primaryXAxis: DateTimeAxis(dateFormat: DateFormat.Hm(), edgeLabelPlacement: EdgeLabelPlacement.shift),
        primaryYAxis: CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        series: <LineSeries<Map<String, dynamic>, DateTime>>[
          LineSeries<Map<String, dynamic>, DateTime>(
            dataSource: sleepData,
            xValueMapper: (data, _) => (data['dateTime']),
            yValueMapper: (data, _) => data['level'],
            dataLabelSettings: DataLabelSettings(isVisible: true, alignment: ChartAlignment.near),
          ),
        ],
      ),
    );
  }
}
