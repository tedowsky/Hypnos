import 'package:flutter/material.dart';
import 'package:hypnos/databases/db.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hypnos/screens/calendar.dart';
import 'package:hypnos/screens/login_page.dart';
import 'package:hypnos/services/impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/screens/home.dart';
import 'package:hypnos/screens/profile.dart';


class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const routeDisplayName = 'InfoPage';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
   
  int _selIdx = 0;

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
        return const HomePage();
      case 3:
        return const CalendarPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return  ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(
        Provider.of<ImpactService>(context, listen: false),
        Provider.of<AppDatabase>(context, listen: false)),
      lazy: false,
      builder: (context, child) => Scaffold(

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
                  leading: const Icon(MdiIcons.logout),
                  title: const Text('Logout'),
                    // delete all data from the preferences
                  onTap: () async {
                    bool reset = await Preferences().resetSettings();
                    if (reset) {
                        // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed(LoginPage.routename);
                    }
                  }
                ),
                ListTile(
                  leading: const Icon(Icons.bed),
                  title: const Text("Sleeping Information"),
                  onTap: () {}
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const infosleep())),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text("Calendar"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.query_stats),
                  title: const Text("Statistics"),
                  onTap: () {},
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
                  Provider.of<HomeProvider>(context, listen: false).refresh();
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          
          // --- COLORE_SFONDO ---
          backgroundColor: const Color(0xFFE4DFD4),

          // --- BODY ---
           body: Provider.of<HomeProvider>(context).doneInit
              ? _selectPage(index: _selIdx)
              : const Center(
                  child: CircularProgressIndicator(),
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
        ),);
      }
  }
  
  
