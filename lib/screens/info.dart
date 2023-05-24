import 'package:flutter/material.dart';
import 'package:hypnos/models/db.dart';
import 'package:hypnos/screens/calendar.dart';
import 'package:hypnos/screens/homepage.dart';
import 'package:hypnos/screens/tips.dart';
import 'package:hypnos/screens/profilepage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hypnos/screens/login_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hypnos/services/Impact.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/screens/infospleep.dart';

import '../Repository/databaseRepository.dart';
import '../databases/database.dart';




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
        return   const TipsPage();
      case 1:
        return const HomePage();
      case 2:
        return  const CalendarPage(title: '',);
      default:
        return const HomePage();
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // --- DRAWER --- 
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 144, 111, 160),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader( decoration: BoxDecoration(color: Colors.blue,),
                child: Text('login_flow'),
              ),
              const Divider(color: Colors.black87,),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => _toLoginPage(context),
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
                onTap:() {}, 
              ),
              ListTile(
                leading: const Icon(Icons.query_stats),
                title: const Text("Statistics"),
                onTap:() {},
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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 204, 196, 208), size: 35,),
        title: const Text('Hypnos', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () async {

              final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

              ImpactService service = Provider.of<ImpactService>(context, listen: false);
              final sp = await SharedPreferences.getInstance();
              final String? token = sp.getString('access');
              if (token != null) 
              {
              final message = 'DataRetrieval failed: re-do Login';
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const InfoPage()));
              ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
              }
              else {
              List<HR>? result = await service.requestData();
              final message =
              result != null ? 'DataRetrieval successful' : 'DataRetrieval failed';
              ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
              }
          
              

              


               final dbRepository = Provider.of<DatabaseRepository>(context, listen: false);
              //   final List<HeartRate>? heartRateList = result!.cast<HeartRate>(); // La tua lista di istanze di HeartRate

              // for (final heartRate in heartRateList!) {
              // await dbRepository.insertHR(heartRate);
              // }

              print('Ciao');


            }, 
            icon: const Icon(Icons.token),),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) =>  const ProfilePage()));
              },
              icon: const Icon(Icons.account_circle),iconSize: 35,),
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
            selectedIndex: _selIdx ,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }


  // ---  _toLoginPage  ---
  void _toLoginPage(BuildContext context) async{

    final sp= await SharedPreferences.getInstance();
    sp.remove('username');
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const LoginPage()));
  }

}

