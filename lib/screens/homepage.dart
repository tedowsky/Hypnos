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
    var dataProvider = Provider.of<HomeProvider>(context);
    if (!isSleepAvailable) {
      sleep = dataProvider.dataList;
      duration = dataProvider.millisecondsToTime(dataProvider.dataList[3]);
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
                  Text('Padua, Italy', selectionColor: Color.fromARGB(255, 160, 158, 158),),
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
                margin: const EdgeInsets.all(30.0),
                elevation: 50,
                shadowColor: Colors.grey[850] ,
                color: const Color.fromARGB(255, 144, 111, 160),
                child:  Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 400,
                    width: 190,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                       children :   [
                        const ListTile(
                          title: Text('TEMPO DI SONNO EFFETTIVO'),
                          leading: Icon(Icons.bedtime, color: Colors.black87),
                          subtitle: Text('Il tempo di sonno effettivo è il tempo totale che hai trascorso a dormire durante la notte',
                            selectionColor: Color(0xFFE4DFD4),
                          ),
                        ),
                        const ListTile(
                          title: Text('TEMPO TRASCORSO A LETTO'),
                          leading: Icon(Icons.bed,color: Colors.black87,),
                          subtitle: Text('Il tempo trascorso a letto è il periodo complessivo in cui sei rimasto a letto incluso il tempo impiegato per addormentarti', 
                            selectionColor: Color(0xFFE4DFD4),
                          ),
                        ),                        
                        Align (
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(34.0),
                          child: Column(
                            children: [
                              LinearPercentIndicator(
                                animation: true,
                                animationDuration: 1000,
                                lineHeight: 20.0,
                                progressColor: Colors.amber,
                                percent: eff/100 , 
                                center: Text('${double.parse(eff.toStringAsFixed(2))}%'),
                                width: 210,
                                barRadius: const Radius.elliptical(10, 10) ,
                              ),
                              const Text(
                                'EFFICIENCY', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 106, 93, 161)
                                ),
                              ),
                              Column(
                                children: [
                                   Text(
                                    _eff(eff),
                                    selectionColor: const Color.fromARGB(227, 152, 19, 19),
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
                                    icon: const Icon(Icons.info_outline, color: Color.fromARGB(255, 228, 223, 20),),
                                  ), 
                                ],
                              ),        
                            ],
                           ),
                        ),
                      ),
                     ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
                borderOnForeground: true,
                margin: const EdgeInsets.all(30.0),
                elevation: 50,
                shadowColor: Colors.grey[850] ,
                color: const Color.fromARGB(255, 144, 111, 160),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Infosleep())),
                child: const Text('Details'),
              )
            ),
          ],
        ),
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

}
