// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/calendar.dart';
import 'package:hypnos/screens/drawer/aboutyoursleep.dart';
import 'package:hypnos/screens/drawer/algorithm_info.dart';
import 'package:hypnos/screens/drawer/hypnos_info.dart';
import 'package:hypnos/screens/homepage.dart';
import 'package:hypnos/screens/login_page.dart';
import 'package:hypnos/screens/tips.dart';
import 'package:hypnos/screens/profilepage.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hypnos/services/impact.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/databases/entities/sleep.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  static const routeDisplayname = 'InfoPage';

  @override
  State<InfoPage> createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage> {
  @override
  void initState() {
    super.initState();
  }

  int _selIdx = 0;
  List<dynamic> basesleep = [];
  Map<String, dynamic> summarylevelsleep = {};
  List<dynamic> levelsleep = [];
  late Sleep? data;
  bool done = false;
  DateTime? lastUpdateDate;
  DateTime currentDate = DateTime.now().toLocal().toLocal();
  bool upload = false;

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ProfilePage();
      case 2:
        return const TipsPage();
      case 3:
        return const CalendarPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      // --- DRAWER ---
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 144, 111, 160),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('login_flow'),
              ),
              const Divider(
                color: Colors.black87,
              ),
              ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    bool reset = await Preferences().resetSettings();
                    if (reset) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    }
                  }),
              ListTile(
                  leading: const Icon(MdiIcons.information),
                  title: const Text("About Hypos"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HypnosInfo(),
                    ));
                  }),
              ListTile(
                  leading: const Icon(MdiIcons.help),
                  title: const Text("What's the the GSI"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AlgorithmInfo(),
                    ));
                  }),
              ListTile(
                  leading: const Icon(MdiIcons.bed),
                  title: const Text("About Sleep"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutSleep(),
                    ));
                  }),
              ListTile(
                  leading: const Icon(MdiIcons.database),
                  title: const Text("Database"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DatabaseList()));
                  }),
            ],
          ),
        ),
      ),

      // --- APPBAR ---
      appBar: AppBar(
        centerTitle: true,
        elevation: 10.0,
        backgroundColor: const Color.fromARGB(255, 144, 111, 160),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 204, 196, 208),
          size: 35,
        ),
        title: const Text('Hypnos',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () async {
              upload = !upload;
              ///////////////////// DATI DATABASE //////////////////////////////
              basesleep =
                  await Provider.of<ImpactService>(context, listen: false)
                      .getbaseSleepData(
                          DateTime.now().subtract(const Duration(days: 1)));

              dataProvider.updateDataListsleep(basesleep);

              summarylevelsleep =
                  await Provider.of<ImpactService>(context, listen: false)
                      .getsummarylevelsSleepData(
                          DateTime.now().subtract(const Duration(days: 1)));

              Sleep sleepfordb = await getSleepData();

              if (lastUpdateDate == null ||
                  lastUpdateDate!.day != currentDate.day) {
                // Esegui l'operazione solo se è un nuovo giorno
                lastUpdateDate = currentDate;

                // Aggiorna i dati nel database
                dataProvider.updateSleep(sleepfordb);
              }

              //////////////////////////////////////////////////////////////////

              ///////////////////////// GRAFICO A STEPLINE /////////////////////////////////////
              levelsleep =
                  await Provider.of<ImpactService>(context, listen: false)
                      .getlevelsSleepData(
                          DateTime.now().subtract(const Duration(days: 1)));

              dataProvider.updateDataListsleep(levelsleep);
              ////////////////////////////////////////////////////////////////////////////////////

              print('ciao');
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),

      // --- COLORE_SFONDO ---
      backgroundColor: const Color(0xFFE4DFD4),

      // --- BODY ---
      body: upload
          ? _selectPage(index: _selIdx)
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Click the button to discover\n'
                      '           your sleep infos'),
                ],
              ),
            ),

      // --- BOTTOM_NAVIGATIO_BAR ---
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 144, 111, 160),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 144, 111, 160),
            color: Colors.black87,
            activeColor: Colors.black87,
            tabBackgroundColor: const Color(0xFFE4DFD4),
            gap: 8,
            padding: const EdgeInsets.all(10),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'User Profile',
              ),
              GButton(
                icon: Icons.sports_gymnastics,
                text: 'Suggested Tips',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Calendar',
              ),
            ],
            selectedIndex: _selIdx,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Future<Sleep> getSleepData() async {
    String dateTimeStr = basesleep[0];
    String startTimeStr = basesleep[1];
    String endTimeStr = basesleep[2];
    int timeAsleep = basesleep[5];
    int timeInBed = basesleep[8];
    int remCount = summarylevelsleep["rem_summary"]["minutes"];
    int deepCount = summarylevelsleep["deep_summary"]["minutes"];
    int lightCount = summarylevelsleep["light_summary"]["minutes"];
    int wakeCount = summarylevelsleep["wake_summary"]["minutes"];

    String dateTimeWithYearStr = "2023-$dateTimeStr";
    String startTimeWithYearStr = "2023-$startTimeStr";
    String endTimeWithYearStr = "2023-$endTimeStr";
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateFormat hourformat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = format.parse(dateTimeWithYearStr);
    DateTime startTime = hourformat.parse(startTimeWithYearStr);
    DateTime endTime = hourformat.parse(endTimeWithYearStr);

    print('ciao');

    // Converti la stringa in un oggetto TimeOfDay
    final int? id = null;
    Sleep sleep = Sleep(
        id, // Inserisci l'id appropriato
        dateTime,
        startTime,
        endTime,
        timeAsleep,
        timeInBed,
        remCount,
        deepCount,
        lightCount,
        wakeCount);
    return sleep;
  }
}
