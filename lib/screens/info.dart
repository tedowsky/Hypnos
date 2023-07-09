import 'package:flutter/material.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/calendar.dart';
import 'package:hypnos/screens/drawer/aboutyoursleep.dart';
import 'package:hypnos/screens/drawer/algorithm_info.dart';
import 'package:hypnos/screens/drawer/hypnos_info.dart';
import 'package:hypnos/screens/homepage.dart';
import 'package:hypnos/screens/impact_ob.dart';
import 'package:hypnos/screens/tips.dart';
import 'package:hypnos/screens/profilepage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hypnos/services/impact.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/databases/entities/sleep.dart';

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
  DateTime date = DateTime.now().toLocal().toLocal();

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
        return const TipsPage();
      case 1:
        return const HomePage();
      case 2:
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
                onTap: () => _toLoginPage(context),
              ),
              ListTile(
                  leading: const Icon(MdiIcons.information),
                  title: const Text("About Hypos"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HypnosInfo(),
                    ));
                  }

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const infosleep())),

                  ),
              ListTile(
                leading: const Icon(MdiIcons.help),
                title: const Text("What's the the GSI"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AlgorithmInfo(),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(MdiIcons.bed),
                title: const Text("About Sleep"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutSleep(),
                  ));
                },
              ),
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

              dataProvider.updateSleep(sleepfordb);

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
            icon: const Icon(Icons.token),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const ProfilePage()));
            },
            icon: const Icon(Icons.account_circle),
            iconSize: 35,
          ),
        ],
      ),

      // --- COLORE_SFONDO ---
      backgroundColor: const Color(0xFFE4DFD4),

      // --- BODY ---
      body: _selectPage(index: _selIdx),

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
                icon: Icons.sports_gymnastics,
                text: 'Suggested Tips',
              ),
              GButton(
                icon: Icons.home,
                text: 'Home',
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

  // ---  _toLoginPage  ---
  void _toLoginPage(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ImpactOnboardingPage()));
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
