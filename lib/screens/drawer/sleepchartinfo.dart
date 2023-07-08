import 'package:flutter/material.dart';

class SleepChartInfoPage extends StatelessWidget {
  const SleepChartInfoPage({Key? key}) : super(key: key);

  static const route = '/sleep_chart_info';
  static const routeName = 'SleepChartInfoPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Understanding Sleep Cycles',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interpreting Sleep Cycles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'The sleep chart displays the different sleep stages experienced during a sleep session. Understanding how to read the chart can provide insights into the quality of your sleep and the cyclical nature of sleep stages.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Key Points to Note:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Sleep Cycles',
              description:
                  'During a sleep session, the brain goes through several cycles of sleep stages. Each cycle typically consists of NREM (Non-Rapid Eye Movement) sleep stages followed by REM (Rapid Eye Movement) sleep.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Cyclical Nature of Sleep Stages',
              description:
                  'The sleep chart shows the cyclical nature of sleep stages. You may observe multiple cycles with varying durations of each sleep stage throughout the night.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Horizontal Lines',
              description:
                  'The horizontal lines represent the amount of time spent in each sleep stage. The longer the line, the more time you spent in that particular sleep stage.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'REM Sleep',
              description:
                  'REM sleep stages typically occur towards the latter part of the sleep session. You may notice a concentration of REM sleep towards the end of the chart.',
            ),
             const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Sleep Cycle Duration:',
              description:
                  'A complete sleep cycle lasts an average of 90 to 120 minutes and repeats multiple times throughout the night. During each cycle, the brain goes through different sleep stages, including periods of light sleep, deep sleep, and REM sleep.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Distribution of Sleep Stages:',
              description:
                  'During the first half of the night, sleep cycles tend to have a higher amount of deep sleep. In the second half of the night, sleep cycles are characterized by a higher presence of REM sleep. This distribution reflects a typical and healthy sleep pattern.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Light Sleep:',
              description:
                  'Light sleep represents the transitional phase between deep sleep and REM sleep. During this phase, the body and brain relax and prepare for the subsequent deep sleep and REM sleep.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Deep Sleep:',
              description:
                  'Deep sleep is a restorative and reparative sleep phase. During this phase, the body fully relaxes, blood pressure decreases, and the immune system strengthens. Deep sleep is important for physical and mental recovery.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Healthy Sleep Patterns:',
              description:
                  'A healthy sleep pattern includes an adequate amount of deep sleep and REM sleep. It is advisable to have complete sleep cycles throughout the night without significant interruptions. Additionally, quality sleep is characterized by a feeling of freshness and restfulness upon waking up, without excessive daytime sleepiness.',
            ),
            const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Consistency of Sleep:',
              description:
                  'Maintaining a regular sleep routine is essential for promoting good sleep. Going to bed and waking up at the same time every day can help synchronize the circadian rhythm and improve sleep quality.',
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({required String title, required String description}) {
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
