import 'package:intl/intl.dart';

class HR {
  // this class models the single heart rate data point
  final DateTime timestamp;
  final int value;

  HR({required this.timestamp, required this.value});

   HR.fromJson(String date, Map<String, dynamic> json) :
  timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),

  value = json["value"];

}


