import 'package:flutter/material.dart';

class EfficiencyPage extends StatelessWidget {
  const EfficiencyPage({Key? key}) : super(key: key);

  static const routeName = 'EfficiencyPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What\'s Efficiency?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Sleep efficiency is a measure of the quality and effectiveness of your rest during your sleep period. Indicate how much time spent in bed actually equals how much time you were able to sleep effectively. In other words, sleep efficiency measures the percentage of time you spend in bed that you\'re actually asleep compared to your total time in bed.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              'How do we get the efficiency:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Sleep efficiency can vary from person to person. Some people may sleep soundly for an extended period of time without interruption, while others may experience frequent awakenings or difficulty falling asleep, thereby reducing sleep efficiency. \n\n You can calculate your sleep efficiency using the following formula:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'Sleep Efficiency = (Actual Sleep Time / Total Time In Bed) x 100',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'High sleep efficiency, therefore, indicates a quality rest period in which the time spent in bed is mostly devoted to actual sleep. On the other hand, low sleep efficiency could indicate problems such as insomnia, sleep apnea or other conditions that affect the quality of rest.\n\n Measuring sleep efficiency can be helpful in assessing the quality of your rest and identifying any sleep disorders you may be facing. You can use sleep tracking devices or apps that record your sleep patterns and provide an assessment of your sleep efficiency',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              'Sleep Efficiency above 85% is often considered a good indicator of quality rest.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
