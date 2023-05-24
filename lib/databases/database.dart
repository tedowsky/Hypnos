//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:hypnos/models/dateTimeConverter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Here, we are importing the entities and the daos of the database
import'package:hypnos/databases/daos/hrDao.dart';
import'package:hypnos/databases/entities/heartrate.dart';

 //The generated code will be in database.g.dart
part 'database.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Todo
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [HeartRate])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  HRDao get hrDao;
}//AppDatabase