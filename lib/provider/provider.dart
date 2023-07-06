import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/entities.dart';
import 'package:hypnos/services/impact.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {

  late List<Sleep> sleep;
  final AppDatabase db;
  int _eff = 0;
  int get eff => _eff;
  // data fetched from external services or db
  late List<dynamic> _sleep;

  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 2));

  DateTime lastFetch = DateTime.now().subtract(const Duration(days: 3));
  final ImpactService impactService;

  bool doneInit = false;
  
  

  HomeProvider(this.impactService, this.db) {
    _init();
  }
  
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
 
  Future<void> _fetchAndCalculate() async {
    lastFetch = await _getLastFetch() ??
        DateTime.now().subtract(const Duration(days: 3));
    // do nothing if already fetched
    if (lastFetch.day == DateTime.now().subtract(const Duration(days: 2)).day) {
      return;
    }
    _sleep = await impactService.getSleepData(DateTime.now().subtract(const Duration(days: 2))); 
    calculateEff();

    await db.sleepDao.insertSleep(
      Sleep(
        null, 
        DateFormat('MM-dd').parse(_sleep[0]),
        DateFormat('MM-dd HH:mm:ss').parse(_sleep[1]),
        DateFormat('MM-dd HH:mm:ss').parse(_sleep[2]),
        _eff
      )
    );  
    print('ciao') ;
     
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
    sleep = await db.sleepDao.findSleepbyDate(DateUtils.dateOnly(showDate),DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    notifyListeners();
  }

void calculateEff() {
  if (_sleep.length >= 9) {
    double effRatio = _sleep[5] / _sleep[8];
    _eff = (effRatio * 100).toInt();
  } else {
    _eff = 0;
  }
}

String millisecondsToTime(double duration) {
  int seconds = (duration / 1000).truncate();
  int minutes = (seconds / 60).truncate();
  int hours = (minutes / 60).truncate();

  String hoursStr = (hours % 24).toString().padLeft(2, '0');
  String minutesStr = (minutes % 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$hoursStr:$minutesStr:$secondsStr";
}

}