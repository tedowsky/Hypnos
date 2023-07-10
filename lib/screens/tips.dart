import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:hypnos/suggestions/meditation/meditation.dart';
import 'package:hypnos/suggestions/exercise/exercise_set_widget.dart';
import 'package:hypnos/suggestions/exercise/exercise_sets.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  static const routeDisplayname = 'TipsPage';

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  List<String> labels = ['Maditation', 'Exercises'];
  List<String> texts = ['Catching your thoughts :', 'Exercise of the day :'];
  int _tabTextIndexSelected = 0;

  void _onTips(int index) {
    setState(() {
      _tabTextIndexSelected = index;
    });
  }

  Widget _selectLabel({
    required int index,
  }) {
    switch (index) {
      case 0:
        return buildMeditation();
      case 1:
        return buildWorkouts();
      default:
        return buildMeditation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4DFD4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 50)),
            FlutterToggleTab(
              width: 90,
              borderRadius: 30,
              height: 50,
              selectedIndex: _tabTextIndexSelected,
              selectedBackgroundColors: const [Colors.blue, Colors.blueAccent],
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              unSelectedTextStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labels: labels,
              selectedLabelIndex: _onTips,
              isScroll: false,
            ),
            const SizedBox(height: 45),
            Text(
              texts[_tabTextIndexSelected],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),
            _selectLabel(index: _tabTextIndexSelected),
          ],
        ),
      ),
    );
  }

  Widget buildWorkouts() {
    return Column(
      children: exerciseSets.map((exerciseSet) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ExerciseSetWidget(exerciseSet: exerciseSet),
        );
      }).toList(),
    );
  }

  Widget buildMeditation() {
    return const Meditation();
  }
}
