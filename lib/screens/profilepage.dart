import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
 ProfilePage({super.key});

 TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 172, 143, 192),
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          title: const Text('Informations',
          style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Image.asset('assets/avatar.png', 
            // scale: 5),
            Row(
              children:[
              Text('Gender'),
              SizedBox(
                width: 4,
              ),
              Radio(value: 0, groupValue: 0, onChanged: (int? value) {}),
              Text('Male'),
              SizedBox(
                width: 2,
              ),
              Radio(value: 0, groupValue: 1, onChanged: (int? value) {}),
              Text('Female')
          ],
          ),
          Text('Age'),
          TextFormField(controller: ageController)
          ],
        ),
      ),
    );
  }
}