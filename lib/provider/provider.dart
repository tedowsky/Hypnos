import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/services/impact.dart';
import '../services/algoritmo.dart';



// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {

  int _age = 0;

  int get age => _age;
  late List<Sleep> calldb;

  void setAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }
  // data to be used by the UI
  final AppDatabase db;
  late List<dynamic> sleep;
  late Sleep sleepdb;
  

  // data fetched from external services or db
  late Sleep _sleepdb;
  Sleep get datasleep => _sleepdb;



   List _sleep = []; // Dati ottenuti dalle richieste
  List get dataListsleep => _sleep; 
  
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.impactService, this.db) {}

  //constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build



   Future<Sleep?> getselectedDay(DateTime selectedDay) async {
    var databasedata = await db.sleepDao.findSleepByDateTime(selectedDay);
    
    return databasedata;
  }

    Future<Sleep?> getLastDay() async {
    var ultimo = await db.sleepDao.findLastDayInDb();
   
    return ultimo;
  }

    Future<void> insertSleep() async{
      db.sleepDao.insertSleep(sleep as Sleep);
    }




  int rem = 120;
  int deep = 180;
  int light = 240;
  int wake = 60;
  int duration = 480;
  int efficiency = 1;

  double goodSleepIndex = 0.0;

  void calculateGSI() {
    goodSleepIndex = calculateGoodSleepIndex(rem, deep, light, wake, duration, efficiency);
    notifyListeners();
  }


  void updateDataListsleep(List newsleep) {
    _sleep = newsleep;
    notifyListeners();    
    print('ciao');
  }

  void updateSleep(Sleep newsleep) {
     _sleepdb = newsleep;
     notifyListeners();
     print('ciao');
    db.sleepDao.insertSleep( _sleepdb);

  }




DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }

}