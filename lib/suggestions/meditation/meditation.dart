import 'package:flutter/material.dart';


class Meditation extends StatefulWidget {
  const Meditation({super.key});

  static const routeDisplayname = 'Meditation';

  @override
  State<Meditation> createState() => _Meditation();
}

class  _Meditation extends State<Meditation> {

  int eff = 85;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Meditation'),);
  }
  
  }