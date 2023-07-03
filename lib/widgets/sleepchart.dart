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
        crosshairBehavior: CrosshairBehavior(enable: true),
        zoomPanBehavior: ZoomPanBehavior(
            enableDoubleTapZooming: true,
            enablePanning: true,
            zoomMode: ZoomMode.x),
        legend: Legend(isVisible: true, title: LegendTitle(text: 'Your Sleep')),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hm(),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorTickLines: const MajorTickLines(width: 0),
        ),
        primaryYAxis: CategoryAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorTickLines: const MajorTickLines(size: 4),
            title: AxisTitle(text: 'Sleep Phases')),
        series: <StepLineSeries<Map<String, dynamic>, DateTime>>[
          StepLineSeries<Map<String, dynamic>, DateTime>(
              dataSource: sleepData,
              color: Color.fromRGBO(121, 108, 192, 1),
              xValueMapper: (data, _) => (data['dateTime']),
              yValueMapper: (data, _) => data['level'],
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                alignment: ChartAlignment.near,
                labelAlignment: ChartDataLabelAlignment.bottom,
                useSeriesColor: true,
                // labelPadding: 4,
                textStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                // builder: (dynamic data, dynamic point, dynamic series,
                //     int pointIndex, int seriesIndex) {
                //   String label = '';
                //   if (data['level'] == 1) {
                //     label = 'wake';
                //   } else if (data['level'] == 2) {
                //     label = 'REM';
                //   } else if (data['level'] == 3) {
                //     label = 'Light';
                //   } else if (data['level'] == 4) {
                //     label = 'Deep';
                //   }
                  // return Container(
                  //   width: 20,
                  //   height: 20,
                  //   decoration: BoxDecoration(
                  //     color: Color.fromRGBO(121, 108, 192, 1),
                  //     borderRadius: BorderRadius.circular(4),
                  //   ),
                  //   alignment: Alignment.center,
                  //   child: Text(data['level'].toString()),
                  // );
                //},
              )),
        ],
      ),
    );
  }
}
