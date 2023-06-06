import 'package:hypnos/suggestions/exercise/exercise_set.dart';
import 'package:flutter/material.dart';

class ExerciseSetWidget extends StatelessWidget {
  final ExerciseSet exerciseSet;

  const ExerciseSetWidget({super.key, 
    required this.exerciseSet,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(

    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            color: exerciseSet.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_box),
              const SizedBox(width: 20,),
              Expanded(flex: 2, child: buildText()),
              Expanded(child: Image.asset(exerciseSet.imgUrl))
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildText() {   
    int series = 3;
    String text = '${exerciseSet.noOfReps} Rep x $series Series';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          exerciseSet.exercise,
          style: const TextStyle(fontWeight:FontWeight.w900, fontSize: 20,fontStyle:FontStyle.normal,),
        ),
        const SizedBox(height: 10),
        Text(text, style:const TextStyle(fontStyle: FontStyle.italic ),),
      ],
    );
  }
}
