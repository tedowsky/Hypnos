import 'package:flutter/material.dart';

class AlgorithmInfo extends StatelessWidget {
  const AlgorithmInfo({Key? key}) : super(key: key);

  static const route = '/algorithm_info';
  static const routeName = 'AlgorithmInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'About the Algorithm',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Understanding the GoodSleepIndex Algorithm',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'The GoodSleepIndex (GSI) algorithm calculates sleep quality based on parameters such as sleep duration, distribution of sleep phases, and sleep efficiency.\n'
              'All this variables are in some way dependent but show different infos about your sleep.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Parameters considered for GSI calculation:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmItem(
              title: 'REM (Rapid Eye Movement)',
              description:
                  'Percentage of REM sleep during the total sleep duration.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmItem(
              title: 'Deep Sleep',
              description:
                  'Percentage of deep sleep during the total sleep duration.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmItem(
              title: 'Light Sleep',
              description:
                  'Percentage of light sleep during the total sleep duration.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmItem(
              title: 'Wake Time',
              description:
                  'Percentage of time spent awake during the total sleep duration.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmItem(
              title: 'Sleep Duration',
              description: 'Total duration of sleep in hours.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmItem(
              title: 'Sleep Efficiency',
              description:
                  'Percentage of time spent sleeping compared to time spent in bed.',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Steps of the GSI algorithm:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmStep(
              number: '1',
              description:
                  'Calculate the "Phase Balance" by comparing the percentages of wake time and light sleep to the percentages of REM sleep and deep sleep.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmStep(
              number: '2',
              description:
                  'Calculate the "REM Score" and "Deep Score" based on the percentages of REM sleep and deep sleep, ranging from 0 to 0.5.',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmStep(
              number: '3',
              description:
                  'Determine the "duration mark" based on sleep duration (close to 1 if within the recommended range, close to zero or less than zero otherwise).',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmStep(
              number: '4',
              description:
                  'Determine the "efficency mark" based on the sleep efficency (a good mark is gained only if the sleep had an high efficency)',
            ),
            const SizedBox(height: 8.0),
            _buildAlgorithmStep(
              number: '5',
              description:
                  'Calculate the final GSI by combining the base GSI, scores from Step 2,the suggested duration and the efficency (resulting in a score ranging from 0 to 5).',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Interpreting the GSI Score:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildInterpretationItem(
              scoreRange: '> 4.5',
              interpretation:
                  'Excellent Sleep Quality: Optimal balance between sleep phases, recommended sleep duration, and high sleep efficiency.',
            ),
            const SizedBox(height: 8.0),
            _buildInterpretationItem(
              scoreRange: '3.5 - 4.5',
              interpretation:
                  'Good Sleep Quality: Good balance between sleep phases, recommended sleep duration, and decent sleep efficiency.',
            ),
            const SizedBox(height: 8.0),
            _buildInterpretationItem(
              scoreRange: '2.5 - 3.5',
              interpretation:
                  'Fair Sleep Quality: Moderate balance between sleep phases, sufficient sleep duration, and potential for improvement.',
            ),
            const SizedBox(height: 8.0),
            _buildInterpretationItem(
              scoreRange: '1.5 - 2.5',
              interpretation:
                  'Poor Sleep Quality: Suboptimal balance between sleep phases, inadequate sleep duration, and need for improvement.',
            ),
            const SizedBox(height: 8.0),
            _buildInterpretationItem(
              scoreRange: '< 1.5',
              interpretation:
                  'Very Poor Sleep Quality: Severe compromise in sleep quality, requiring immediate action to address sleep-related issues.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlgorithmItem(
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

  Widget _buildAlgorithmStep(
      {required String number, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$number. ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildInterpretationItem({
    required String scoreRange,
    required String interpretation,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Score Range: $scoreRange',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          interpretation,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
