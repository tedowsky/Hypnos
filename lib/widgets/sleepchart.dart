import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> sleepData;

  const SleepChartWidget({super.key, required this.sleepData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        // plotAreaBackgroundColor: 
        // Colors.grey[200],
        crosshairBehavior: CrosshairBehavior(enable: true),
        zoomPanBehavior: ZoomPanBehavior(
            enableDoubleTapZooming: true,
            enablePanning: true,
            zoomMode: ZoomMode.x),
            
        // legend: Legend(isVisible: true,
        // //title: LegendTitle(text: 'W = wake \n R = REM \n D = Deep \n L = Light')
        // ),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.Hm(),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorTickLines: const MajorTickLines(width: 0),
        ),
        primaryYAxis: CategoryAxis(
           plotBands: <PlotBand>[
            PlotBand(
              isVisible: true,
              start: '1',
              end: '1',
              color: Colors.yellow.withOpacity(0.2),
            ),
            PlotBand(
              isVisible: true,
              start: '2',
              end: '2',
              color: Colors.blue.withOpacity(0.2),
            ),
            PlotBand(
              isVisible: true,
              start: '3',
              end: '3',
              color: Colors.green.withOpacity(0.2),
            ),
            PlotBand(
              isVisible: true,
              start: '4',
              end: '4',
              color: Colors.deepPurple.withOpacity(0.2),
            ),
          ],
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorTickLines: const MajorTickLines(size: 4),
            labelPlacement: LabelPlacement.onTicks,
          //  title: AxisTitle(text: 'Sleep Phases')
            ),
        series: <StepLineSeries<Map<String, dynamic>, DateTime>>[
          StepLineSeries<Map<String, dynamic>, DateTime>(
              dataSource: sleepData,
              name: 'Sleep Phases',
              color: const Color.fromRGBO(121, 108, 192, 1),
              
              xValueMapper: (data, _) => (data['dateTime']),
              yValueMapper: (data, _) => data['level'],
              pointColorMapper: (data, _) {
              if (data['level'] == 1) {
                return const Color.fromRGBO(131, 190, 200, 1);
              } else if (data['level'] == 2) {
                return const Color.fromRGBO(193, 85, 101, 1);
              } else if (data['level'] == 3) {
                return const Color.fromRGBO(186, 186, 130, 1);
              } else if (data['level'] == 4) {
                return const Color.fromRGBO(54, 74, 186, 1);
              }
              return Colors.transparent;
            },
            width: 4,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                alignment: ChartAlignment.near,
                labelAlignment: ChartDataLabelAlignment.bottom,
                useSeriesColor: true,
                // labelPadding: 4,
                textStyle:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                builder: (dynamic data, dynamic point, dynamic series,
                    int pointIndex, int seriesIndex) {
                  String label = '';
                  if (data['level'] == 1) {
                    label = 'W';
                  } else if (data['level'] == 2) {
                    label = 'R';
                  } else if (data['level'] == 3) {
                    label = 'L';
                  } else if (data['level'] == 4) {
                    label = 'D';
                  }
                  return Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(121, 108, 192, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
