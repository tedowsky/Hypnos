import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/components/my_button.dart';
import 'package:flutter_application_3/components/my_textfield.dart';
import 'package:flutter_application_3/components/square_tile.dart';
import 'package:flutter_application_3/screens/homepage.dart';
import 'package:flutter_login/flutter_login.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
  }//initState

  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if(sp.getString('username') != null){
      //If 'username is set, push the HomePage
       // ignore: use_build_context_synchronously        
       _tohomepage(context);
    }//if
  }//_checkLogin

  Future<String> _loginUser(LoginData data) async {
  if(data.name == 'myapp@email.com' && data.password == 'target4.7'){

    final sp = await SharedPreferences.getInstance();
    sp.setString('username', data.name);
    return '';
  } else {
     return 'Wrong credentials';
   }
  } 
 //

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _tohomepage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
  }//_toHomePage

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
              const Icon(Icons.lock,size: 100,),
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
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // sign in button
              MyButton(
                onTap: () async =>_tohomepage(context),
              ),

              const SizedBox(height: 50),
              // or continue with
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 20),

                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 20),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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