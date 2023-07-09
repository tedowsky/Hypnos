import 'package:flutter/material.dart';
import 'package:hypnos/components/my_button.dart';
import 'package:hypnos/components/my_textfield.dart';
import 'package:hypnos/screens/impact_ob.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hypnos/screens/info.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';
  // text editing controllers

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextbox = MyTextField(
    hintText: 'Email',
    obscureText: false,
  );
  final passwordTextbox = MyTextField(
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
    if (sp.getString('Email') != null) {
      //If 'username is set, push the HomePage
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const InfoPage()));
    } //if
  } //_checkLogin

  void login() {
    // Check if the credentials are correct
    if (emailTextbox.controller.text == 'myapp@email.com' &&
        passwordTextbox.controller.text == 'target4.7') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ImpactOnboardingPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Authentication Error'),
            content: const Text('Invalid email or password.'),
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
      backgroundColor: const Color.fromARGB(255, 144, 111, 160),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 15),
                // welcome back, you've been missed!
                const Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),

                // username textfield
                emailTextbox,
                const SizedBox(height: 10),

                // password textfield
                passwordTextbox,

                const SizedBox(height: 10),

                // forgot password?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // sign in button
                MyButton(
                  onTap: login, // InfoPage()
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Compatible with',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    // SizedBox(
                    //   width: 20,
                    //   height: 20,
                    //   child: SquareTile(imagePath: 'lib/images/google.png')),

                    SizedBox(width: 20),

                    // apple button
                    // SizedBox(
                    //   width: 20,
                    //   height: 20,
                    //   child: SquareTile(imagePath: 'lib/images/apple.png'))
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.black87),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
