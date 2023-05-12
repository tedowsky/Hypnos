import 'package:flutter/material.dart';

import 'package:hypnos/screens/homepage.dart';

class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  } //_toHomePage

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => _toHomePage(context));
    return Material(
      child: Container(
        color: const Color(0xFF83AA99),
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