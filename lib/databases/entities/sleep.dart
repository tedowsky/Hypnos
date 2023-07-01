import 'package:floor/floor.dart';

@entity
class Sleep {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //When the meal occured
  final DateTime dateTime;

  final DateTime startTime;

  final DateTime endTime;

  final int rem;

  final int deep;

  final int light;

  final int wake;

  //Default constructor
  Sleep(this.id, this.dateTime, this.startTime, this.endTime, this.rem, this.deep, this.light, this.wake);
} //Sleep