import 'package:flutter/material.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/services/algoritmo.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                  titleTextStyle: const TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
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

                    data =
                        await Provider.of<HomeProvider>(context, listen: false)
                            .getselectedDay(DateTime.parse(
                                selectedDay.toString().split("Z")[0]));
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data != null)
                    Text(
                        'How you slept the ${DateFormat('MM/dd').format(data!.dateTime)}:'
                        '\n',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 156, 100, 166),
                          fontSize: 16.0,
                        )),
                  SizedBox(height: 10),
                  if (data != null) // Aggiunge spazio tra i widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.bedClock,
                            color: Colors.purple), // Esempio di icona
                        SizedBox(
                            width: 5), // Aggiunge spazio tra l'icona e il testo
                        Text(
                          'Fell asleep at: ${DateFormat('HH:mm').format(data!.startTime)}',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  if (data != null) // Aggiunge spazio tra i widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.sunClock,
                            color: Colors.purple), // Esempio di icona
                        SizedBox(
                            width: 5), // Aggiunge spazio tra l'icona e il testo
                        Text(
                          'Woke up at: ${DateFormat('HH:mm').format(data!.endTime)}',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  if (data != null) // Aggiunge spazio tra i widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Esempio di icona
                        SizedBox(
                            width: 5), // Aggiunge spazio tra l'icona e il testo
                        Text(
                          'Slept in total: ${(data!.endTime.difference(data!.startTime)).inHours} h'
                          ' and ${(data!.endTime.difference(data!.startTime)).inMinutes.remainder(60)} m\n',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  if (data != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Phase balance:\n',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(width: 5),
                  if (data != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // REM
                        Row(
                          children: [
                            Text(
                              'REM: ${(data!.rem / (data!.endTime.difference(data!.startTime)).inMinutes * 100).toStringAsFixed(2)}%',
                              style: TextStyle(
                                  color: Color.fromRGBO(193, 85, 101, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(width: 20), // Spazio tra le fasi

                        // DEEP
                        Row(
                          children: [
                            Text(
                              'DEEP: ${(data!.deep / (data!.endTime.difference(data!.startTime)).inMinutes * 100).toStringAsFixed(2)}%',
                              style: TextStyle(
                                  color: Color.fromRGBO(54, 74, 186, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (data != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),

                        // LIGHT
                        Row(
                          children: [
                            Text(
                              'LIGHT: ${(data!.light / (data!.endTime.difference(data!.startTime)).inMinutes * 100).toStringAsFixed(2)}%',
                              style: TextStyle(
                                  color: Color.fromRGBO(186, 186, 130, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),

                        // WAKE
                        Row(
                          children: [
                            Text(
                              'WAKE: ${(data!.wake / (data!.endTime.difference(data!.startTime)).inMinutes * 100).toStringAsFixed(2)}%',
                              style: TextStyle(
                                  color: Color.fromRGBO(131, 190, 200, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (data != null) // Aggiunge spazio tra i widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.checkboxMultipleBlankCircle,
                            color: Colors.purple), // Esempio di icona
                        SizedBox(
                            width: 5), // Aggiunge spazio tra l'icona e il testo
                        Text(
                          'GSI: ${calculateGoodSleepIndex(data!.rem, data!.deep, data!.light, data!.wake, (data!.endTime.difference(data!.startTime)), data!.minAsleep / data!.timeInBed)}',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
