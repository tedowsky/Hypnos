
import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/entities.dart';
import 'package:hypnos/services/impact.dart';



// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the database
// and on startup fetching the data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  late List<HR> heartRates;
  final AppDatabase db;
  late List<Sleep> sleep;


  // data fetched from external services or db
  late List<HR> _heartRates;

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
    lastFetch = await _getLastFetch() ??
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

   Future<void> refresh() async {
    await _fetchAndCalculate();
    await getDataOfDay(showDate);
  }

  // method to select only the data of the chosen day
  Future<void> getDataOfDay(DateTime showDate) async {
    // check if the day we want to show has data
    var firstDay = await db.sleepDao.findFirstDayInDb();
    var lastDay = await db.sleepDao.findLastDayInDb();
    if (showDate.isAfter(lastDay!.dateTime) ||
        showDate.isBefore(firstDay!.dateTime)) return;
        
    this.showDate = showDate;
    heartRates = await db.heartRatesDao.findHeartRatesbyDate(
        DateUtils.dateOnly(showDate),
        DateTime(showDate.year, showDate.month, showDate.day, 23, 59));

    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

}