
import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/entities.dart';
import 'package:hypnos/services/impact.dart';
import 'package:intl/intl.dart';

import '../services/algoritmo.dart';



// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {

  int _age = 0;

  int get age => _age;

  void setAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }
  // data to be used by the UI
  late List<HR> heartRates;
  final AppDatabase db;
  late List<dynamic> sleep;
  late Sleep sleepdb;
  

  // data fetched from external services or db
  late List<HR> _heartRates;
  late Sleep _sleepdb;
  Sleep get datasleep => _sleepdb;

  List<HR> line_hr = [];
  List<HR> get dataListhr => line_hr;

   List _sleep = []; // Dati ottenuti dalle richieste
  List get dataListsleep => _sleep; 

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 2));

  DateTime lastFetch = DateTime.now().subtract(const Duration(days: 3));
  final ImpactService impactService;

  bool doneInit = false;

  HomeProvider(this.impactService, this.db) {
    _init();
  }

  //constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  Future<void> _init() async {
    await _fetchAndCalculate();
    getDataOfDay(showDate);
    doneInit = true;
    notifyListeners();
  }

  Future<DateTime?> _getLastFetch() async {
    var data = await db.sleepDao.findAllSleep();
    if (data.isEmpty) {
      return null;
    }
    return data.last.dateTime;
  }

  // method to fetch all data and calculate the exposure
  Future<void> _fetchAndCalculate() async {
   // lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 3));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 2)).day) {
      return;
    }
    _heartRates = await impactService.getDataFromDay(lastFetch);
    for (var element in _heartRates) {
      db.heartRatesDao.insertHeartRate(element);
    } // db add to the table

  }

    Future<void> Mettili(hr) async {
    for (var element in hr) {
      db.heartRatesDao.insertHeartRate(element);
      notifyListeners();
      print('ciao');

    } // db add to the table

    Future<void> insertSleep() async{
      db.sleepDao.insertSleep(sleep as Sleep);
    }

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


   Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await db.sleepDao.findFirstDayInDb();
    var lastDay = await db.sleepDao.findLastDayInDb();
    if (lastDay?.dateTime != null && showDate.isAfter(lastDay!.dateTime) ||
        firstDay?.dateTime != null && showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;
    heartRates = await db.heartRatesDao.findHeartRatesbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

  void updateDataListhr(List<HR> newhr) {
    line_hr = newhr;
    notifyListeners();
    print('ciao');
    
  }

  void updateDataListsleep(List newsleep) {
    _sleep = newsleep;
    notifyListeners();
    
    print('ciao');
  }

  void updateSleep(Sleep newsleep) {
    _sleepdb = newsleep;
    notifyListeners();  
    db.sleepDao.insertSleep(_sleepdb);
    
  }

}
DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }
