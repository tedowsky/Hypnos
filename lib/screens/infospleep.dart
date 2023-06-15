import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/heartrate.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/services/impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:hypnos/widgets/bargraph/bar_graph.dart';
import 'package:hypnos/widgets/custom_plot.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/databases/entities/entities.dart' as db;
import 'package:provider/provider.dart';
import 'package:hypnos/widgets/linechart.dart';


class Infosleep extends StatefulWidget {
  const Infosleep({Key? key}) : super(key: key);

  @override
  State<Infosleep> createState() => _InfosleepState();
}

class _InfosleepState extends State<Infosleep> {
  Map<String, dynamic> summarylevelsleep = {};
  var deep = [];
  var wake = [];
  var light = [];
  var rem = [];
  List sleepstages = [];
  
  Future<List<HR>>? result;

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<HomeProvider>(
    //   create: (context) => HomeProvider(
    //       ImpactService(Provider.of<Preferences>(context, listen: false)),
    //       Provider.of<AppDatabase>(context, listen: false)),
    //   lazy: false,
    //   builder: (context, child) => 
     return Consumer<HomeProvider>(
          builder: (context, dataProvider, child) {
            List sleep = dataProvider.dataListsleep;

            String sleepDatamin = sleep[1];
            DateFormat formatmin = DateFormat('MM-dd HH:mm:ss');
            DateTime start = formatmin.parse(sleepDatamin);

            String sleepDatamax = sleep[1];
            DateFormat formatmax = DateFormat('MM-dd HH:mm:ss');
            DateTime end = formatmax.parse(sleepDatamax);
      return 
      Scaffold(
      
        backgroundColor: Colors.grey[300],
        appBar: 
        
        AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 172, 143, 192),
            iconTheme: const IconThemeData(color: Color(0xFF89453C)),
            title: const Text('Know More About Your Sleep',
                style: TextStyle(color: Colors.black)),
                actions: [
                  Consumer<AppDatabase>(
          builder: (context, db, child) {
            return
          IconButton(

            
            onPressed: () async {
            result = db.heartRatesDao.findHeartRatesbyDate(start, end);
              
            },
            icon: const Icon(MdiIcons.databaseRefreshOutline));
                  }
                  )
            ],),
        body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 150, 25, 10),
        child: ListView(
          children: [
            // SizedBox(
            //   height: 80,
            //   width: 300,
            //   child: MyBarGraph(
            //    sleepstages: sleepstages,
            //   ),
            // ),
            const SizedBox(
              height: 25,
            ),
            
          //We will show the todo table with a ListView.
          //To do so, we use a Consumer of DatabaseRepository in order to rebuild the widget tree when
          //entries are deleted or created.
        
            SizedBox(
              height: 400,
              width: 1000,
              // Aggiungi qui il tuo widget o contenuto desiderato
              child: Consumer<HomeProvider>(
          builder: (context, HomeProvider, child) {
            return
              LineChartWidget();

          }

            ),
            )
             
            // Consumer<HomeProvider>(
            //     builder: (context, value, child) =>
            //         CustomPlot(data: _parseData(value.heartRates)))
            //         // Aggiungi altri widget o contenuto
          ],
        ),
      ),
    );
          });  
  }



//   void updateSleepStages() async {
//     summarylevelsleep = await Provider.of<ImpactService>(context, listen: false)
//         .getsummarylevelsSleepData(DateTime.now().subtract(const Duration(days: 1)));
//     deep = summarylevelsleep['deep_summary']['minutes'];
//     wake = summarylevelsleep['wake_summary']['minutes'];
//     light = summarylevelsleep['light_summary']['minutes'];
//     rem = summarylevelsleep['rem_summary']['minutes'];
//     sleepstages = [rem, deep, light];
//     setState(() {}); // Aggiungi questo per aggiornare il widget
//   }
// }

  List<Map<String, dynamic>> _parseData(List<db.HR> data) {
    return data
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.dateTime),
            'points': e.value
          },
        )
        .toList();
  }
}


  

