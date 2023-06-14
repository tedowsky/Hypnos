import 'package:flutter/material.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/splash.dart';
import 'package:hypnos/services/impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'databases/db.dart';

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
            lazy: false,
          ),
          Provider(
            create: (context) => ImpactService(
              Provider.of<Preferences>(context, listen: false),
            ),
          ),
          ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider(
            Provider.of<ImpactService>(context, listen: false),
            Provider.of<AppDatabase>(context, listen: false),
          )),
          // Provider(
          //    create: (context) => HomeProvider(
          //       Provider.of<ImpactService>(context, listen: false),
          //       Provider.of<AppDatabase>(context, listen: false),
          //     ).dataList.isNotEmpty,
          //   ),
        ],
        child:  MaterialApp(
          title: 'Hypnos',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Splash(),
        ));
  }
}