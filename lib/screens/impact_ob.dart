import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hypnos/models/db.dart';
import 'package:hypnos/models/sleep.dart';
import 'package:hypnos/screens/homepage.dart';
import 'package:hypnos/utils/server_impact.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hypnos/components/my_textfield.dart';
import 'package:hypnos/services/impact.dart';

import '../services/impact.dart';

class ImpactOnboardingPage extends StatefulWidget {
  const ImpactOnboardingPage({Key? key}) : super(key: key);

  static const routename = 'ImpactOnboardingPage';
  // text editing controllers

  @override
  State<ImpactOnboardingPage> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboardingPage> {
  //final username = TextEditingController();
  //final password = TextEditingController();


  final usernameTextbox = MyTextField(
    hintText: 'Username',
    obscureText: false,
  );
  final codiceTextbox = MyTextField(
    //controller: password,
    hintText: 'Password',
    obscureText: true,
  );

  @override
  void initState() {
    super.initState();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
  } //initState

  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('username') != null) {
      //If 'username is set, push the HomePage
      // ignore: use_build_context_synchronously
      _tohomepage(context);
    } //if
  } //_checkLogin


  void login() async{
    // Check if the credentials are correct
    if (usernameTextbox.controller.text == Impact.username &&
        codiceTextbox.controller.text == Impact.password) {

        final sp = await SharedPreferences.getInstance();
        sp.setString('username', usernameTextbox.controller.text);
        sp.setString('codice', codiceTextbox.controller.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Authentication Error'),
            content: const Text('Invalid username or password.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _tohomepage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  } //_toHomePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 141, 131, 146),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                // logo
                Container(
                    height: 300,
                    width: 350,
                    child: Image.asset('assets/impact_logo.png')),
                // welcome back, you've been missed!
                const Text(
                  'Requested authorization',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                // username textfield
                usernameTextbox,
                const SizedBox(height: 10),

                // password textfield
                codiceTextbox,

                const SizedBox(height: 15),
                // sign in button
                ElevatedButton(
                  onPressed: () async {
                    ImpactService service = Provider.of<ImpactService>(context, listen: false);
                    final result_auto = await service.authorize();
                    final message_auto =
                        result_auto == 200 ? 'Authorization successful' : 'Authorization failed';
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(message_auto)));
                  //     final result = await service.requestData();
                  //     final message =
                  //     result == null ? 'DataRetrival successful' : 'DataRetrival failed';
                  // ScaffoldMessenger.of(context)
                  //   ..removeCurrentSnackBar()
                  //   ..showSnackBar(SnackBar(content: Text(message)));
                    
                    login();
                  },
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 141, 131, 146)),),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Authorize",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

