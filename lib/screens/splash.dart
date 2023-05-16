import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/login_page.dart';



class Splash extends StatelessWidget {
  static const route = '/splash/';
  static const routeDisplayName = 'SplashPage';

  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) =>  LoginPage()));
  } //_toLoginPage

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => _toLoginPage(context));
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