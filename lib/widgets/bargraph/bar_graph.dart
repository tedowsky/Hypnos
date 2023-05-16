import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hypnos/widgets/bargraph/bardata.dart';

class MyBarGraph extends StatelessWidget {

  final List sleepstages;
  const MyBarGraph({
    super.key,
    required this.sleepstages,
  });

  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(
      remsleep: sleepstages[0], 
      deepsleep: sleepstages[1], 
      lightsleep: sleepstages[2]);

    myBarData.initialBarData();


    return BarChart(
      BarChartData(
        maxY: 30,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, 
              getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(

            // qua quando voglio modificare l'average!!
            x: data.x,
            barRods: 
            [BarChartRodData(
              toY: data.y,
              color: Colors.grey[800],
              width: 25,
              borderRadius: BorderRadius.circular(4),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 80,
                color: Colors.grey[200],

                
              )
              )]
            
        )).toList() 
      )
    );
  }
}

Widget getBottomTitles (double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,

  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('REM', style: style);
      break;
    case 1:
      text = const Text('Deep', style: style);
      break;
    case 2:
      text = const Text('Light', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}