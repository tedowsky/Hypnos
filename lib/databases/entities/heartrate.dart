import 'package:floor/floor.dart';

@Entity(tableName: 'HeartRate')
class HeartRate {
  @PrimaryKey()
  final DateTime timestamp;
  final int value;
  HeartRate(this.timestamp, this.value);
}