import 'package:flutter/material.dart';
// import 'package:hypnos/provider/provider.dart';
//import 'package:hypnos/screens/info.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

//enum Gender { male, female }

class ProfilePage extends StatefulWidget {
  const ProfilePage ({Key? key}): super(key: key);

  static const route = 'user';
  static const routename = 'UserPage';

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage>{

  // bool isProfileComplete = false;

  // final _formKey = GlobalKey<FormState>();

  // Gender? selectedGender;
  
  // final TextEditingController ageController = TextEditingController();
  // final TextEditingController weightController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   loadSavedData();
  // }


  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ciao'),
    ); //Scaffold(

      //backgroundColor: const Color(0xFFE4DFD4),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 35,),
      //       Center(
      //         child: CircleAvatar(
      //           radius: 60,child: Image.asset("assets/info/genderGeneral.png"))),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Form(
      //           key: _formKey,
      //           child: Column(
      //             children: [
      //               const SizedBox(height: 20),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: <Widget>[ 
      //                   const SizedBox(width: 10),
      //                   const Text('Gender:', style: TextStyle(color: Colors.black87, fontSize: 17)),
      //                   Radio(
      //                     fillColor: MaterialStateColor.resolveWith((states) => Colors.black87),
      //                     value: Gender.male, groupValue: selectedGender, onChanged: (val) async {
      //                       setState(() {
      //                         selectedGender = val;                              
      //                       });
      //                       final sharedPreferences = await SharedPreferences.getInstance();
      //                       sharedPreferences.setInt('gender', selectedGender!.index);
      //                     }
      //                   ),
      //                   const Text(
      //                     'MALE',
      //                     style: TextStyle(fontSize: 17.0),
      //                     ),
      //                   Radio(
      //                     fillColor: MaterialStateColor.resolveWith((states) => Colors.black87),
      //                     value: Gender.female, groupValue: selectedGender, onChanged: (val) async {
      //                       setState(() {
      //                         selectedGender = val;                                  
      //                       });
      //                       final sharedPreferences = await SharedPreferences.getInstance();
      //                       sharedPreferences.setInt('gender', selectedGender!.index); 
      //                     }
      //                   ),
      //                   const Text(
      //                     'FEMALE',
      //                     style: TextStyle(fontSize: 17.0),
      //                     ),
      //                 ],
      //               ),
      //               const SizedBox(height:30,),
      //               SizedBox(
      //                 width: 400,
      //                 child: TextFormField(
      //                   validator: (value1) {
      //                     if (value1 == null || value1.isEmpty){
      //                       return 'Please enter your age';
      //                     } else if (int.tryParse(value1) == null){
      //                       return 'Please enter an integer valid number';
      //                     }
      //                     return null;
      //                   },
      //                   controller: ageController,
      //                   enabled: true,
      //                   decoration: const InputDecoration(
      //                     border: OutlineInputBorder(),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                         width: 1, color: Colors.black87
      //                       )
      //                     ),
      //                     labelText: 'Age',
      //                     labelStyle: TextStyle(color:Colors.black87)
      //                   )
      //                   ,)
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   ElevatedButton(
      //                     onPressed: () async {
      //                       if (_formKey.currentState!.validate()) {
      //                         final sharedPreferences = await SharedPreferences.getInstance();
      //                         sharedPreferences.setInt('age', int.parse(ageController.text));
      //                         // ignore: use_build_context_synchronously
      //                         final ageProvider = Provider.of<HomeProvider>(context, listen: false);
      //                         //ageProvider.setAge(int.parse(ageController.text));
      //                       }
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: const Color(0xFF83AA99),
      //                       shape: const CircleBorder(),
      //                     ), 
      //                     child: const Icon(Icons.check),
      //                   ),
      //                 ],
      //               ),

      //               const SizedBox(height:20,),
      //               SizedBox(
      //                 width: 400,
      //                 child: TextFormField(
      //                   validator: (value2) {
      //                     if (value2 == null || value2.isEmpty){
      //                       return 'Please enter your weight';
      //                     } else if (int.tryParse(value2) == null){
      //                       return 'Please enter an integer valid number';
      //                     }
      //                     return null;
      //                   },
      //                   controller: weightController,
      //                   enabled: true,
      //                   decoration: const InputDecoration(
      //                     border: OutlineInputBorder(),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderSide: BorderSide(
      //                         width: 1, color: Colors.black87,
      //                       )
      //                     ),
      //                     labelText: 'Weight',
      //                     labelStyle: TextStyle(color:Colors.black87)
      //                   )
      //                   ,)
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   ElevatedButton(
      //                     onPressed: () async {
      //                       if (_formKey.currentState!.validate()) {
      //                         final sharedPreferences = await SharedPreferences.getInstance();
      //                         sharedPreferences.setInt('weight', int.parse(weightController.text));
      //                       }
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: const Color(0xFF83AA99),
      //                       shape: const CircleBorder(),
      //                     ), 
      //                     child: const Icon(Icons.check),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ]
      //   )
      // ));
  }
  // Future<void> loadSavedData() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   final savedAge = sharedPreferences.getInt('age');
  //   final savedWeight = sharedPreferences.getInt('weight');
  //   final savedGender = sharedPreferences.getInt('gender');
  //   if (savedAge != null) {
  //     setState(() {
  //       ageController.text = savedAge.toString();
  //     });
  //   }
  //   if (savedWeight != null) {
  //     setState(() {
  //       weightController.text = savedWeight.toString();
  //     });
  //   }
  //   if (savedGender != null) {
  //     setState(() {
  //       selectedGender = Gender.values[savedGender];
  //     });
  //   }
  //   if ( savedAge != null && savedWeight != null && savedGender != null) {
  //     isProfileComplete = true;
  //   }
  // }
  

}