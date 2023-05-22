import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/screens/profilepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hypnos/screens/infospleep.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:hypnos/screens/login_page.dart';
import 'package:http/http.dart' as http;
import '../models/db.dart';
import '../services/impact.dart';
import '../utils/server_impact.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeDisplayname = 'HomePage';
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  
  void _fetchData() async {
  await Future.delayed(Duration.zero); // Aggiungi questo per garantire che il context sia disponibile

  ImpactService service = Provider.of<ImpactService>(context, listen: false);
  final result = await service.requestData();
  final message =
      result != null ? 'DataRetrieval successful' : 'DataRetrieval failed';

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

  
  final aqi = 20;
  final now = DateTime.now();
  //final hour = now.hour;
  //final image = _getImageForHour(hour);

 // int _selIdx = 0;

  //void changePage(int index) {
  //  setState(() {
  //    _selIdx = index;
  //  });
  //}

  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(MdiIcons.gymnastics),
      label: 'Suggested Tips'),
      const BottomNavigationBarItem(
      icon: Icon(MdiIcons.calendar),
      label: 'Calendar'),
  ];
  
// Widget selectPage(int index){
//   switch(index){
//     case 0:
//       return Home();
//     case 1:
//       return Advices();
//     default:
//       return Home();
//   }
// }

  @override
  Widget build(BuildContext context) {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);

    return Scaffold(
        drawer: Drawer( backgroundColor: const Color.fromARGB(255, 106, 93, 161),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(MdiIcons.logout),
                  title: const Text('Logout'),
                  onTap: () => _toLoginPage(context),
                ),
                const Text('About'),
                ListTile(
                  leading: const Icon(MdiIcons.sleep),
                  title: const Text('About Hypnos'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(MdiIcons.bed),
                  title: const Text('Sleep facts'),
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 144, 111, 160),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 204, 196, 208), size: 35,),
          title: const Text('Hypnos', style: TextStyle(color: Colors.black)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) =>  ProfilePage()));
                },
                icon: const Icon(Icons.person_pin))
          ],
        ),
        backgroundColor: const Color(0xFFE4DFD4),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [Icon(MdiIcons.mapMarker), Text('Padua, Italy', selectionColor: Color.fromARGB(228, 183, 178, 178),)]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //children: [
                    //Image.asset(name)
                    //const Text(', username'),
                  //],
                ),
                const Text('How did you sleep last night?'),
                const SizedBox(
                  width: 300,
                  height: 150,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => _toinfosleepage(context),
                    child: const Text('Details'),)
                ),
              ],
            ),
          )),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 144, 111, 160),
          selectedItemColor: const  Color.fromARGB(199, 31, 19, 41),
          items: navBarItems,
        ),
      );
    //   body: selectPage(_selIdx) ,
    // bottomNavigationBar: BottomNavigationBar(
    //   currentIndex: _selIdx,
    //   onTap: ((value) => changePage(value)),
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.abc), label: 'Suggested Tips'),
    //        BottomNavigationBarItem(
    //       icon: Icon(Icons.abc), label: 'Calendar'),
    // ]) ,
  }

    void _toLoginPage(BuildContext context) async{

    final sp= await SharedPreferences.getInstance();
    sp.remove('username');
    //Pop the drawer first 
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    //Then pop the HomePage
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage()));
  }//_toLoginPage

    void _toinfosleepage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const infosleep()));
  }



  String _getImageForHour(int hour) {
    if (hour < 6 || hour >= 21) {
      return 'assets/images/night.png';
    } else {
      return 'assets/images/morning.png';
    }
  }

}

  