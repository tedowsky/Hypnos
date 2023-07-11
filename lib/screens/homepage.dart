import 'package:flutter/material.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:hypnos/screens/drawer/algorithm_info.dart';
import 'package:hypnos/screens/efficiency.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:hypnos/widgets/GSIchart.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/screens/infospleep.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/services/algoritmo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeDisplayname = 'HomePage';

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  bool isCircularIndicatorVisible = true;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var hour = DateFormat('H').format(now);
    // ignore: unused_local_variable
    var imagePath = _getImagePath(int.parse(hour));
    var commentPath = _comment(int.parse(hour));

    return Consumer<HomeProvider>(builder: (context, dataProvider, child) {
      Sleep? sleep = dataProvider.datasleep;
      return Scaffold(
        // --- COLORE_SFONDO ---
        backgroundColor: const Color(0xFFE4DFD4),

        // --- BODY ---
        body: ListView(
          children: [
            const Row(
              children: [
                Icon(MdiIcons.mapMarker),
                Text(
                  'Padua, Italy',
                  selectionColor: Color.fromARGB(255, 160, 158, 158),
                ),
              ],
            ),
            SizedBox(
              height: 113,
              child: Column(
                children: [
                  Image.asset(
                    imagePath,
                    height: 75,
                    width: 75,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      commentPath,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.black,
              indent: 25,
              endIndent: 30,
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              borderOnForeground: true,
              margin: const EdgeInsets.only(
                top: 10.0,
                left: 40.0,
                right: 40.0,
              ),
              elevation: 50,
              shadowColor: Colors.grey[850],
              color: const Color.fromARGB(255, 144, 111, 160),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.info_outline,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: const Text(
                                  'It\'s the total amount of time you slept during the night',
                                  selectionColor: Color(0xFFE4DFD4),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black),
                      title: const Text(
                        'ACTUAL SLEEP TIME',
                      ),
                      leading: const Icon(
                        Icons.bedtime,
                        color: Colors.black87,
                        size: 23,
                      ),
                    ),
                    ListTile(
                        trailing: IconButton(
                          iconSize: 20,
                          icon: const Icon(
                            Icons.info_outline,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: const Text(
                                    'It\'s the total amount of time you were in bed, including the time it took you to fall asleep',
                                    selectionColor: Color(0xFFE4DFD4),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                        title: const Text('TIME SPEND IN BED'),
                        leading: const Icon(
                          Icons.bed,
                          color: Colors.black87,
                          size: 23,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 25,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          'EFFICIENCY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EfficiencyPage()));
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (sleep != null)
                      LinearPercentIndicator(
                        alignment: MainAxisAlignment.center,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20.0,
                        progressColor: const Color.fromARGB(255, 211, 116, 116),
                        percent: (sleep.minAsleep / sleep.timeInBed),
                        center: Text(
                            '${(sleep.minAsleep / sleep.timeInBed * 100).toStringAsFixed(0)}%'),
                        width: 210,
                        barRadius: const Radius.elliptical(10, 10),
                      ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        if (sleep != null)
                          Text(
                            (_eff(sleep.minAsleep / sleep.timeInBed)),
                            selectionColor:
                                const Color.fromARGB(226, 117, 9, 9),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              color: Colors.black,
              indent: 25,
              endIndent: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: isCircularIndicatorVisible
                  ? SizedBox(
                      height: 230,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'About last night:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          if (sleep != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    if (Provider.of<Preferences>(context,
                                                listen: false)
                                            .age !=
                                        null)
                                      Text(
                                          'Age: ${Provider.of<Preferences>(context, listen: false).age}'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_alarm),
                                        Text(
                                            ' ${DateFormat('HH:mm').format(sleep.endTime)}')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.snooze_rounded),
                                        Text(
                                            ' ${DateFormat('HH:mm').format(sleep.startTime)}'),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    if (Provider.of<Preferences>(context,
                                                listen: false)
                                            .age !=
                                        null)
                                      Text(
                                          'GOAL:${goal(Provider.of<Preferences>(context, listen: false).age)} h'),
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                if (Provider.of<Preferences>(context,
                                            listen: false)
                                        .age !=
                                    null)
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 10.0,
                                    percent: ((sleep.endTime.difference(
                                                    sleep.startTime))
                                                .inMinutes /
                                            (goal(Provider.of<Preferences>(
                                                        context,
                                                        listen: false)
                                                    .age) *
                                                60))
                                        .clamp(0.0, 1.0),
                                    animation: true,
                                    animationDuration: 1200,
                                    center: Text(
                                      '${(sleep.endTime.difference(sleep.startTime)).inHours} h '
                                      '${(sleep.endTime.difference(sleep.startTime)).inMinutes.remainder(60)} m',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.0),
                                    ),
                                    progressColor: Colors.green,
                                  ),
                              ],
                            ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      width: 300,
                      child: Column(
                        children: [
                          if (sleep != null)
                            Row(
                              children: [
                                const SizedBox(
                                  width: 60,
                                ),
                                const Text(
                                  'Good Sleep Index',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                            gsisuggestions(
                                              calculateGoodSleepIndex(
                                                  sleep.rem,
                                                  sleep.deep,
                                                  sleep.light,
                                                  sleep.wake,
                                                  (sleep.endTime.difference(
                                                      sleep.startTime)),
                                                  sleep.minAsleep /
                                                      sleep.timeInBed),
                                            ),
                                            selectionColor:
                                                const Color(0xFFE4DFD4),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text('About the GSI'),
                                                    IconButton(
                                                      icon: const Icon(
                                                          MdiIcons.information),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AlgorithmInfo(),
                                                        ));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                TextButton(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (sleep != null)
                            GSIChart(
                                gsi: calculateGoodSleepIndex(
                                    sleep.rem,
                                    sleep.deep,
                                    sleep.light,
                                    sleep.wake,
                                    (sleep.endTime.difference(sleep.startTime)),
                                    sleep.minAsleep / sleep.timeInBed)),
                        ],
                      )),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isCircularIndicatorVisible = !isCircularIndicatorVisible;
                });
              },
              icon: const Icon(
                Icons.swap_horiz,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
              indent: 55,
              endIndent: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Infosleep())),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 127, 89,
                          146)), // Imposta il colore di sfondo viola
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Imposta il bordo arrotondato con un raggio di 10
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(150,
                        45), // Imposta la dimensione minima del bottone a 200 di larghezza e 60 di altezza
                  ),
                ),
                child: const Text(
                  'Discover More',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    });
  }

  // --- SWITCH_IM<AGES ---
  String _getImagePath(int hour) {
    if (hour >= 6 && hour < 14) {
      return 'assets/info/morning.png';
    }
    if (hour >= 14 && hour < 22) {
      return 'assets/info/sunset.png';
    } else {
      return 'assets/info/night.png';
    }
  }

  // --- SWITCH_SCRIPT ---
  String _comment(int hour) {
    if (hour >= 6 && hour < 14) {
      return 'GOOD MORNING , It\'s time to start your day !';
    }
    if (hour >= 14 && hour < 22) {
      return 'enjoy your afternoon but,\nDON\'T FORGET YOUR DAILY SCHEDULE!';
    } else {
      return 'It\'s time to go to sleep, GOOD NIGHT !';
    }
  }

  String _eff(double eff) {
    if (eff >= 0.95) {
      return '- Very Good -';
    } else if (eff >= 0.85 && eff < 0.95) {
      return '- Good -';
    } else if (eff >= 0.75 && eff < 0.85) {
      return '- Discrete -';
    } else {
      return '- Bad -';
    }
  }

  int goal(int? age) {
    if (age! < 17) {
      return 8;
    } else {
      return 7;
    }
  }

  String gsisuggestions(double gsi) {
    if (gsi >= 4.5) {
      return 'Your GSI is very good, anyway 1 meditation audio is suggested';
    } else if (gsi >= 3.5 && gsi < 4.5) {
      return 'Your GSI is good, you should follow 2 meditations audio & 1 physical exercise, to have the perfect sleep';
    } else if (gsi >= 2.5 && gsi < 3.5) {
      return 'Your GSI is discret, you should follow 2 meditations audio & 2 physical exercise in order to get a better sleep';
    } else if (gsi >= 1.5 && gsi < 2.5) {
      return 'Your GSI is bad. The GSI scrore is strongly influenced by the phase balance, this means that your DEEP and REM phase were shorter than reccomented. This might be caused by stress or anxiety, because of this you should follow 2 meditations audio & 3 physical exercise to get a better sleep';
    } else {
      return 'Your GSI is very bad. The GSI scrore is strongly influenced by the phase balance, this means that your DEEP and REM phase were shorter than reccomented. This might be caused by stress or anxiety, because of this you should follow 3 meditations audio & 4 or more physical exercise to sleep better';
    }
  }
}
