
import 'package:hypnos/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hypnos/screens/advices.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  static const routeDisplayname = 'HomePage';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selIdx = 0;

  void changePage(int index){
    setState(() {
      _selIdx = index;
    });
  }

Widget selectPage(int index){
  switch(index){
    case 0:
      return Home();
    case 1:
      return Advices();
    default: 
      return Home();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            children: [
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text('Logout'),
                onTap: (){},
              ),
              Text('About'),
              ListTile(
                leading: Icon(MdiIcons.imageFilterCenterFocus),
                title: Text('Personal Exposure Info'),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(MdiIcons.dotsCircle),
                title: Text('Air Polution Info'),
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Pollutrack'),
        actions: [ IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ProfilePage()));
        }, icon: Icon(Icons.abc) ) ],
        
      ) ,
      body: selectPage(_selIdx) ,
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selIdx,
      onTap: ((value) => changePage(value)),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.abc), label: 'Air Pollution'),
           BottomNavigationBarItem(
          icon: Icon(Icons.abc), label: 'Personal exposure'),
    ]) ,
    );
  }
}

