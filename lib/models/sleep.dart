import 'package:intl/intl.dart';

class Sleep{
  final DateTime time;
  final int value;

  Sleep({required this.time, required this.value});

  Sleep.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }//toString
}//Sleep