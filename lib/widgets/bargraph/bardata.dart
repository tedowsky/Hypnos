import 'individualbar.dart';

class BarData{

  final double remsleep;
  final double deepsleep;
  final double lightsleep;

  BarData({
    required this.remsleep,
    required this.deepsleep,
    required this.lightsleep,
  });



  List<IndividualBar> barData =[];

  void initialBarData(){
    barData = [
      //rem
      IndividualBar(x: 0, y: remsleep),
      //deep
      IndividualBar(x: 1, y: deepsleep),
      //light
      IndividualBar(x: 2, y: lightsleep),


    ];
  }
}