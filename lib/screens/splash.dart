import 'package:flutter/material.dart';
import 'package:hypnos/screens/homepage.dart';
import 'package:hypnos/screens/impact_ob.dart';
import 'package:hypnos/screens/login_page.dart';
import 'package:provider/provider.dart';

import '../services/impact.dart';
import '../utils/shared_preferences.dart';



class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  // // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>  const LoginPage()));
  } //_toLoginPage

  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => HomePage())));
  } //_toHomePage

  void _toImpactPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => ImpactOnboardingPage())));
  }

   void _checkAuth(BuildContext context) async {
    var prefs = Provider.of<Preferences>(context, listen: false);
    String? username = prefs.username;
    String? password = prefs.password;

    // no user logged in the app
    if (username == null || password == null) {
      Future.delayed(const Duration(seconds: 1), () => _toLoginPage(context));
    } else {
      ImpactService service =
          Provider.of<ImpactService>(context, listen: false);
      bool responseAccessToken =  service.checkSavedToken();
      bool refreshAccessToken = service.checkSavedToken(refresh: true);

      // if we have a valid token for impact, proceed
      if (responseAccessToken || refreshAccessToken) {
        
        Future.delayed(
              const Duration(seconds: 1), () => _toHomePage(context));
      } else {
        Future.delayed(
            const Duration(seconds: 1), () => _toImpactPage(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () => _checkAuth(context));
    return Material(
      child: Container(
        color: const Color.fromARGB(255, 166, 160, 195),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              'HYPNOS',
              style: TextStyle(
                  color: Color.fromARGB(255, 73, 45, 156),
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 127, 60, 137)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}