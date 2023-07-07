import 'package:flutter/material.dart';

class AboutSleep extends StatelessWidget {
  const AboutSleep({Key? key}) : super(key: key);

  static const route = '/aboutsleep';
  static const routeName = 'AboutSleep';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'About Your Sleep',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Guidelines for Healthy Sleep',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'The World Health Organization (WHO) provides the following recommendations for a healthy sleep:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildSleepGuidelineItem(
              title: 'Consistent Sleep Schedule',
              description:
                  'Go to bed and wake up at the same time every day, even on weekends.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Create a Restful Environment',
              description:
                  'Make sure your bedroom is quiet, dark, and at a comfortable temperature.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Limit Stimulants',
              description:
                  'Avoid caffeine, nicotine, and alcohol, especially close to bedtime.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Establish a Bedtime Routine',
              description:
                  'Engage in relaxing activities before bed, such as reading or taking a warm bath.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Physical Activity',
              description:
                  'Regular exercise can promote better sleep, but avoid intense workouts close to bedtime.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Limit Daytime Napping',
              description:
                  'If you need to nap, keep it short (around 20-30 minutes) and avoid napping too close to bedtime.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Manage Stress',
              description:
                  'Find healthy ways to manage stress, such as relaxation techniques or talking to a supportive person.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Avoid Electronics Before Bed',
              description:
                  'Avoid screens (e.g., smartphones, tablets, TVs) for at least an hour before bed.',
            ),
            const SizedBox(height: 8.0),
            _buildSleepGuidelineItem(
              title: 'Comfortable Sleep Environment',
              description:
                  'Invest in a comfortable mattress, pillows, and bedding that suit your preferences.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepGuidelineItem(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
