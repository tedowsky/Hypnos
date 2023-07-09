import 'package:flutter/material.dart';
import 'package:hypnos/screens/drawer/algorithm_info.dart';
import 'package:hypnos/screens/drawer/efficiency.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:hypnos/widgets/GSIchart.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/screens/infospleep.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeDisplayname = 'HomePage';

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int eff = 85;
  bool isCircularIndicatorVisible = true;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var hour = DateFormat('H').format(now);
    // ignore: unused_local_variable
    var imagePath = _getImagePath(int.parse(hour));
    var commentPath = _comment(int.parse(hour));

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
            height: 85,
            child: Column(
              children: [
                // SizedBox(
                //   height: 20,
                //   width: 20,
                //   child: Image.asset(imagePath)),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    commentPath,
                  ),
                ),
              ],
            ),
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
                  LinearPercentIndicator(
                    alignment: MainAxisAlignment.center,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    progressColor: const Color.fromARGB(255, 211, 116, 116),
                    percent: (eff.toDouble()) / 100,
                    center: Text('$eff%'),
                    width: 210,
                    barRadius: const Radius.elliptical(10, 10),
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        ('- Good -'),
                        selectionColor: Color.fromARGB(226, 117, 9, 9),
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
                          'Duration of sleep last night:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                    'Age: ${Provider.of<Preferences>(context, listen: false).age}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.access_alarm),
                                    Text('Awake:')
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.snooze_rounded),
                                    Text('Fall to sleep:'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                const Text('GOAL:'),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 10.0,
                              percent: 0.7,
                              animation: true,
                              animationDuration: 1200,
                              center: const Text(
                                'timing',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15.0),
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AlgorithmInfo(),
                                ));
                              },
                              icon: const Icon(
                                Icons.info_outline,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GSIChart(gsi: 3),
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
                child: const Text('Details'),
              )),
        ],
      ),
    );
  }

  // --- SWITCH_IM<AGES ---
  String _getImagePath(int hour) {
    if (hour >= 6 && hour < 21) {
      return 'lib/images/morning.png';
    } else {
      return 'lib/images/night.png';
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

  String _eff(int eff) {
    if (eff / 100 >= 0.85) {
      return '- Good -';
    } else {
      return '- Not Good -';
    }
  }
}
