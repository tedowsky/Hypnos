import 'package:flutter/material.dart';
import 'package:hypnos/widgets/bargraph/bar_graph.dart';


class Infosleep extends StatefulWidget {
  const Infosleep({Key? key}) : super(key: key);

  @override
  State<Infosleep> createState() => _InfosleepState();
}

class _InfosleepState extends State<Infosleep> {

  List<double> sleepstages = [
    13,
    8,
    19,
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 172, 143, 192),
            iconTheme: const IconThemeData(color: Color(0xFF89453C)),
            title: const Text('Know More About Your Sleep',
                style: TextStyle(color: Colors.black))),
        body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 150, 25, 10),
        child: ListView(
          children: [
            SizedBox(
              height: 80,
              width: 300,
              child: MyBarGraph(
               sleepstages: sleepstages,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            
            const SizedBox(
              height: 300,
              width: 800,
              // Aggiungi qui il tuo widget o contenuto desiderato
              //child: LineChartWidget(),
            ),
            // Aggiungi altri widget o contenuto
          ],
        ),
      ),
        );
  }
}
