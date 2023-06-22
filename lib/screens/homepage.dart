import 'package:flutter/material.dart';
import 'package:hypnos/provider/provider.dart';
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

  List sleep = [];
  bool isSleepAvailable = false;
  late String duration;  // questo dato è in millisecondi, attenzione!

  @override
  Widget build(BuildContext context) {
    final ageProvider = Provider.of<HomeProvider>(context);
    final age = ageProvider.age;
    var dataProvider = Provider.of<HomeProvider>(context);
    if (!isSleepAvailable) {
      sleep = dataProvider.dataList;
      duration = dataProvider.millisecondsToTime(dataProvider.dataList[3]);
      print('ciao');
      
      if (sleep.isNotEmpty) {
        isSleepAvailable = true;
      }
    }
    double eff = sleep.isNotEmpty?  sleep[5]/sleep[8]*100 : 0;
    
      
    var now = DateTime.now();
    var hour = DateFormat('H').format(now);
    // ignore: unused_local_variable
    var imagePath = _getImagePath(int.parse(hour));
    var commentPath = _comment(int.parse(hour)); 
        
    return Scaffold (
      // --- COLORE_SFONDO ---
      backgroundColor: const Color(0xFFE4DFD4),  

      // --- BODY ---
      body: ListView(
        children: [
          const Row(
            children: [
              Icon(MdiIcons.mapMarker),
                  Text('Padua, Italy', selectionColor: Color.fromARGB(255, 144, 144, 144),),
                ],
              ),
              SizedBox(
                height: 85,
                child: Column(
                  children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(imagePath)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(commentPath,),
                  ),
                  ],
                ),
              ),
              Card(
                borderOnForeground: true,
                margin: const EdgeInsets.only(top: 10.0,left:40.0, right: 40.0,),
                elevation: 50,
                shadowColor: Colors.grey[850] ,
                color: const Color.fromARGB(255, 144, 111, 160),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        children : [
                              ListTile(
                                trailing: IconButton(
                                  icon: const Icon(Icons.info_outline, color: Color.fromARGB(255, 0, 0, 0),), 
                                    onPressed: (){
                                    showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text('Il tempo di sonno effettivo è il tempo totale che hai trascorso a dormire durante la notte',
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
                              titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),
                              title: const Text('TEMPO DI SONNO EFFETTIVO',),
                              leading: const Icon(Icons.bedtime, color: Colors.black87,size: 25,),
                            ),
                            ListTile(
                              trailing: IconButton(
                                icon: const Icon(Icons.info_outline, color: Color.fromARGB(255, 0, 0, 0),), 
                                onPressed: (){
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text('Il tempo trascorso a letto è il periodo complessivo in cui sei rimasto a letto, incluso il tempo impiegato per addormentarti', 
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
                              titleTextStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),
                              title: const Text('TEMPO TRASCORSO A LETTO'),
                              leading: const Icon(Icons.bed,color: Colors.black87,size: 25,)
                            ),
                            const SizedBox(height: 20,),
                            const Divider(color: Colors.black, indent: 20, endIndent: 25,),
                            const SizedBox(height: 15,),
                            const Text(
                                    'EFFICIENCY', 
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 0, 0, 0)
                                      ),
                                ),
                            const SizedBox(height: 10,),
                            LinearPercentIndicator(
                              alignment: MainAxisAlignment.center,
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 20.0,
                              progressColor: const Color.fromARGB(255, 211, 116, 116),
                              percent: eff/100 , 
                              center: Text('${double.parse(eff.toStringAsFixed(2))}%'),
                              width: 210,
                              barRadius: const Radius.elliptical(10, 10) ,
                            ), 
                            Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                       Text(
                                        _eff(eff),
                                        selectionColor: const Color.fromARGB(226, 117, 9, 9),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          showDialog(
                                            context: context, 
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('L\'EFFICIENCY'),
                                                content: const Text('Invalid email or password.'),
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
                                        icon: const Icon(Icons.info_outline, color: Color.fromARGB(255, 0, 0, 0),),
                                      ),],),
                         ],
                    ),
                  ),
            ),
            Card(
                borderOnForeground: true,
                margin: const EdgeInsets.only(top: 30.0,left:40.0, right: 40.0,),
                elevation: 50,
                shadowColor: Colors.grey[850] ,
                color: const Color.fromARGB(255, 144, 111, 160),
                child: SizedBox(
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('SLEEP\'S HOURS', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('Age: $age'),
                              const SizedBox(height: 10,),
                              const Row(children: [Icon(Icons.access_alarm),Text('Awake:')],),
                              const SizedBox(height: 10,),
                              const Row(children: [Icon(Icons.snooze_rounded),Text('Fall to sleep:'),],),
                              const SizedBox(height: 35,),
                              Text('GOAL: ${_goal(age)}'),
                            ],
                          ), 
                          const SizedBox(width: 40,),
                          CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 10.0,
                            percent: 0.7,
                            animation: true,
                            animationDuration: 1200,
                            center: Text(duration, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15.0),),
                            progressColor: Colors.green,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: (){
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('L\'EFFICIENCY'),
                                content: const Text('Invalid email or password.'),
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
                        icon: const Icon(Icons.info_outline, color: Color.fromARGB(255, 0, 0, 0),),
                      ),
                    ],),
                  ),
                ),
                const SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Infosleep())),
                child: const Text('Details'),
              )
            ),
          ],
        )
        );
    }
  
  
  // --- SWITCH_IM<AGES ---
  String _getImagePath(int hour) {
    if (hour >= 6 && hour < 21) {
      return 'assets/info/morning.png';
    }  
    else {
      return 'assets/info/night.png';
    }
  }
  // --- SWITCH_SCRIPT ---
  String _comment (int hour) {
    if (hour >= 6 && hour < 21) {
      return 'GOOD MORNING , It\'s time to start your day !';
    }
    else {
      return 'It\'s time to go to sleep, GOOD NIGHT !';
    }
  }
  String _eff (double eff) {
    if (eff/100 >= 0.85) {
      return '- Good -';
    }
    else {
      return '- Not Good -';
    }

  }

  String _goal (int age) {
    if (age >= 65) {
    return '7 ore';
  } else if (age >= 51 && age <= 64) {
    return '8 ore';
  } else if (age >= 26 && age <=50) {
    return '9 ore';
  } else if (age >= 18 && age <=25) {
    return '10 ore';
  } else if (age >= 11 && age <=17) {
    return '11 ore';
  } else if (age >= 6 && age <=10) {
    return '12 ore';
  } else if (age >= 2 && age <=5) {
    return '13 ore';
  } else if (age <= 1) {
    return '14 ore';
  } else {
    return 'Intervallo di sonno non determinato per questa età.';
  }
}


}