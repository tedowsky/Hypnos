import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {

//   //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});
  
  //This method wraps the findAllMeals() method of the DAO
  Future<List<Sleep>> findAllSleep() async{
    final results = await database.sleepDao.findAllSleep();
    return results;
  }//findAllMeals

  //This method wraps the insertMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> insertSleep(Sleep sleep)async {
    await database.sleepDao.insertSleep(sleep);
    notifyListeners();
  }//insertMeal

   //This method wraps the deleteMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeSleep(Sleep sleep) async{
    await database.sleepDao.deleteSleep(sleep);
    notifyListeners();
  }//removeMeal
  
  //This method wraps the updateMeal() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> updateSleep(Sleep sleep) async{
    await database.sleepDao.updateSleep(sleep);
    notifyListeners();
  }//updateMeal

}//DatabaseRepository