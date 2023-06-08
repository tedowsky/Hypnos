import 'package:flutter/material.dart';
import 'package:hypnos/screens/info.dart';
import 'package:provider/provider.dart';
import 'package:hypnos/services/impact.dart';



class ImpactOnboardingPage extends StatefulWidget {
  const ImpactOnboardingPage({Key? key}) : super(key: key);
  
    static const routename = 'ImpactOnboardingPage';

  @override
  State<ImpactOnboardingPage> createState() => _ImpactOnboardingState();
}

class _ImpactOnboardingState extends State<ImpactOnboardingPage> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Future<bool> _loginImpact(
      String name, String password, BuildContext context) async {
    ImpactService service = Provider.of<ImpactService>(context, listen: false);
    bool logged = await service.getTokens(name, password);
    return logged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4DFD4),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  width: 350,
                  child: Image.asset('assets/login/impact_logo.png')
                ),
                const Text('Please authorize to use our app',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  controller: userController,
                  cursorColor: const Color(0xFF83AA99),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF89453C),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xFF89453C),
                    ),
                    hintText: 'Username',
                    hintStyle: const TextStyle(color: Color(0xFF89453C)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5,),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  controller: passwordController,
                  cursorColor: const Color(0xFF83AA99),
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Color(0xFF89453C),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF89453C),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                      // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showPassword();
                      },
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Color(0xFF89453C)),
                  ),
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        bool? validation = await _loginImpact(userController.text,
                            passwordController.text, context);
                        if (!validation) {
                        // if not correct show message
                        // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(8),
                            content: Text('Wrong Credentials'),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(const SnackBar(content: Text('Authorization successful')));

                         Future.delayed(
                              const Duration(milliseconds: 300),
                              () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const InfoPage())));
                          }
                      },
                      style: ButtonStyle(
                        //maximumSize: const MaterialStatePropertyAll(Size(50, 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        elevation: MaterialStateProperty.all(0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF89453C))),
                    child: const Text('Authorize'),
                  ),
                ),
              ),
            ],
          ),
      ),),
    );
  }
}