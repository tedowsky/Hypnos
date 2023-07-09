import 'package:hypnos/suggestions/exercise/exercise_set.dart';
import 'package:flutter/material.dart';

class ExerciseSetWidget extends StatefulWidget {
  final ExerciseSet exerciseSet;

  const ExerciseSetWidget({
    super.key,
    required this.exerciseSet,
  });

  @override
  State<ExerciseSetWidget> createState() => _ExerciseSetWidgetState();
}

class _ExerciseSetWidgetState extends State<ExerciseSetWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              width: 400,
              height: 100,
              decoration: BoxDecoration(
                color: widget.exerciseSet.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: Colors.black,
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(flex: 2, child: buildText()),
                  Expanded(child: Image.asset(widget.exerciseSet.imgUrl))
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildText() {
    int series = 3;
    String text = '${widget.exerciseSet.noOfReps} Rep x $series Series';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.exerciseSet.exercise,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            fontStyle: FontStyle.normal,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
