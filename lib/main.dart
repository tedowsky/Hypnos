import 'package:flutter/material.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:hypnos/screens/splash.dart';
import 'package:hypnos/services/impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'databases/db.dart';
import 'package:hypnos/repository/databaseRepository.dart';

// Future<void> main() async {
//   //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine.
//   //This is needed when you need to interact with the native core of the app.
//   //Here, we need it since when need to initialize the DB before running the app.
//   WidgetsFlutterBinding.ensureInitialized();

//   //This opens the database.
//   final AppDatabase database =
//       await $FloorAppDatabase.databaseBuilder('app_database.db').build();
//   //This creates a new DatabaseRepository from the AppDatabase instance just initialized
//   final databaseRepository = DatabaseRepository(database: database);

//   //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository.
//   //That instance will be then shared through the platform and will be unique.
//   runApp( ChangeNotifierProvider <DatabaseRepository> (
//     create: (context) => databaseRepository,
//     child: const MyApp(),
//   ));
// } //main
//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDatabase db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(Provider<AppDatabase>.value(value: db, child: const MyApp()));
}
//
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
          ChangeNotifierProvider<DatabaseRepository>(create: (context) => DatabaseRepository(
            database: Provider.of<AppDatabase>(context, listen: false),
          )),
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