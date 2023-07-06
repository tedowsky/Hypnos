import 'package:flutter/material.dart';
import 'package:hypnos/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeDisplayname = 'HomePage';

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            Text('eff: ${provider.eff}'),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const  DatabaseList()));
              },
              icon: const Icon(Icons.table_bar),
            ),
          ],
        );
      },
    );
  }
}