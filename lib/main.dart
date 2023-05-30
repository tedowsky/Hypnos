import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hypnos/screens/splash.dart';
import 'package:hypnos/services/Impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'databases/db.dart';
import 'package:hypnos/screens/impact_ob.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(Provider<AppDatabase>.value(value: db, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Preferences()..init(),
          // This creates the preferences when the provider is creater. With lazy = true (default), the preferences would be initialized when first accessed, but we need them for the other services
          lazy: false,
        ),
        Provider(
            create: (context) => ImpactService(
                  // We pass the newly created preferences to the service
                  Provider.of<Preferences>(context, listen: false),
                )),
      ],
      child: MaterialApp(
        title: 'Hypnos',
        theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: ImpactOnboardingPage(),
      )
    );
  }
}