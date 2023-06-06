import 'package:hypnos/suggestions/exercise/exercise_set.dart';
import 'package:flutter/material.dart';




final exercises = ['Burpees','Push Up','Plank','Pull Up','Crunch','Lunges','Squats','Side Jump',];
final noOfReps = ['12','10','15','8','12','15','20','8'];

 
final exerciseSets = [
  ExerciseSet(
    exercise: exercises[0],
    noOfReps: noOfReps[0],
    color: Colors.blue.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/squat.png',
  ),
    ExerciseSet(
    exercise: exercises[1],
    noOfReps: noOfReps[1],
    color: Colors.green.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/pushup.png',
  ),
    ExerciseSet(
    exercise: exercises[2],
    noOfReps: noOfReps[2],
    color: Colors.orange.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/plank.png',
  ),
    ExerciseSet(
    exercise: exercises[3],
    noOfReps: noOfReps[3],
    color: Colors.purple.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/pullup.png',
  ),
    ExerciseSet(
    exercise: exercises[4],
    noOfReps: noOfReps[4],
    color: Colors.red.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/crunch.png',
  ),
    ExerciseSet(
    exercise: exercises[5],
    noOfReps: noOfReps[5],
    color: Colors.pink.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/pullup.png',
  ),
    ExerciseSet(
    exercise: exercises[6],
    noOfReps: noOfReps[6],
    color: Colors.yellowAccent.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/squat.png',
  ),
    ExerciseSet(
    exercise: exercises[7],
    noOfReps: noOfReps[7],
    color: Colors.teal.shade100.withOpacity(0.6),
    imgUrl: 'lib/images/exercise/plank.png',
  ),

];
