import 'package:hypnos/databases/database.dart';
import 'package:flutter/material.dart';
import 'package:hypnos/databases/entities/heartrate.dart';

class DatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllMeals() method of the DAO
  Future<List<HeartRate>> findAllHR() async{
    final results = await database.hrDao.findAllHR();
    return results;
  }//findAllMeals

  //This method wraps the insertMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insertHR(HeartRate heartRate)async {
    await database.hrDao.insertHR(heartRate);
    notifyListeners();
  }//insertMeal

  //This method wraps the deleteMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeHR(HeartRate heartRate) async{
    await database.hrDao.deleteHR(heartRate);
    notifyListeners();
  }//removeMeal
  
  //This method wraps the updateMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> updateHR(HeartRate heartRate) async{
    await database.hrDao.updateHR(heartRate);
    notifyListeners();
  }//updateMeal

}//DatabaseRepository