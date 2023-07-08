import 'package:flutter/material.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static const routeDisplayname = 'CalendarPage';

  @override
  State<CalendarPage> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarPage> {

  //List<String> activities = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Sleep? data;
  

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context,provider,_) {

        return Scaffold(
          body: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2022, 10, 5),
                lastDay: DateTime.utc(2025, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                rowHeight: 60,
                daysOfWeekHeight: 60,
                headerStyle: HeaderStyle(
                  titleTextStyle:
                      const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                  formatButtonTextStyle: const TextStyle(color: Colors.green),
                  formatButtonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal, width: 2),
                  ),
                  leftChevronIcon: const Icon(
                    Icons.arrow_back,
                    color: Colors.teal,
                    size: 28,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.teal,
                    size: 28,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colors.red),
                  todayDecoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) async {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    
                    data =  await Provider.of<HomeProvider>(context,listen: false).getselectedDay(DateTime.parse(selectedDay.toString().split("Z")[0]));
                    print('ciao');
                  }

                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 25),
              

            ],
          ),
        );
      }
    );
  }
}