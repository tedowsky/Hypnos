import 'package:flutter/material.dart';
import 'package:hypnos/components/my_textfield.dart';
import 'package:hypnos/screens/info.dart';
import 'package:hypnos/utils/server_impact.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hypnos/services/Impact.dart';

class ImpactOnboardingPage extends StatefulWidget {
  const ImpactOnboardingPage({Key? key}) : super(key: key);

  static const routename = 'ImpactOnboardingPage';
  // text editing controllers

  @override
  State<ImpactOnboardingPage> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboardingPage> {

  final usernameTextbox = MyTextField(
    hintText: 'Username',
    obscureText: false,
  );
  final codiceTextbox = MyTextField(
    hintText: 'Password',
    obscureText: true,
  );
  void _toInfo(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const InfoPage()));
  } //_toHomePage

  @override
  void initState() {
    super.initState();
  } //initState
  
  void login() async{
    // Check if the credentials are correct
    if (usernameTextbox.controller.text == Impact.username && codiceTextbox.controller.text == Impact.password) {
      final sp = await SharedPreferences.getInstance();
      sp.setString('username', usernameTextbox.controller.text);
      sp.setString('codice', codiceTextbox.controller.text);
      _toInfo(context);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 141, 131, 146),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                SizedBox(
                    height: 300,
                    width: 350,
                    child: Image.asset('lib/images/impact_logo.png')),
                const Text(
                  'Requested authorization',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                usernameTextbox,
                const SizedBox(height: 10),
                codiceTextbox,
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    ImpactService service = Provider.of<ImpactService>(context, listen: false);
                    final resultAuto = await service.authorize();
                    final messageAuto = resultAuto == 200 
                    ? 'Authorization successful' 
                    : 'Authorization failed';
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(messageAuto)));   
                    login();
                  },
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 141, 131, 146)),),
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