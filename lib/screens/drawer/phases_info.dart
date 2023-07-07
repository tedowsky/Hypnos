import 'package:flutter/material.dart';

class PhasesInfo extends StatelessWidget {
  const PhasesInfo({Key? key}) : super(key: key);

  static const route = '/phases_info';
  static const routeName = 'PhasesInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Understanding Sleep Phases',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sleep Phases',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'There are four primary sleep phases that occur during a typical sleep session. Each phase plays a unique role in the sleep cycle and contributes to overall sleep quality.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildPhaseItem(
              title: 'REM Sleep',
              description:
                  'REM (Rapid Eye Movement) sleep is a phase associated with vivid dreams, rapid eye movements, and increased brain activity. It is essential for cognitive function, memory consolidation, and emotional regulation.',
            ),
            const SizedBox(height: 8.0),
            _buildPhaseItem(
              title: 'Deep Sleep',
              description:
                  'Deep sleep, also known as slow-wave sleep or N3 sleep, is the most restorative phase. It promotes physical recovery, hormone regulation, and memory formation. It is characterized by slow brain waves and minimal body movement.',
            ),
            const SizedBox(height: 8.0),
            _buildPhaseItem(
              title: 'Light Sleep',
              description:
                  'Light sleep, also known as N1 and N2 sleep, acts as a transition between wakefulness and deeper sleep stages. It plays a role in relaxation, creativity, and sensory processing. It is characterized by slower brain waves and occasional movements.',
            ),
            const SizedBox(height: 8.0),
            _buildPhaseItem(
              title: 'Wakefulness',
              description:
                  'Wakefulness is the phase when you are fully awake and alert. It is characterized by high brain activity and conscious awareness. While wakefulness is necessary during the day, excessive wakefulness during the night can disrupt sleep quality.',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Recommended Duration Percentages',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'To achieve optimal sleep quality, it is recommended to have the following percentage distribution of sleep phases:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildPhaseDurationItem(
              phase: 'REM Sleep',
              recommendedPercentage: '20-25%',
            ),
            const SizedBox(height: 8.0),
            _buildPhaseDurationItem(
              phase: 'Deep Sleep',
              recommendedPercentage: '15-20%',
            ),
            const SizedBox(height: 8.0),
            _buildPhaseDurationItem(
              phase: 'Light Sleep',
              recommendedPercentage: '50-60%',
            ),
            const SizedBox(height: 8.0),
            _buildPhaseDurationItem(
              phase: 'Wakefulness',
              recommendedPercentage: '5-10%',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Consequences of Imbalanced Sleep Phases',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'An imbalance in sleep phases can have various consequences on overall well-being and cognitive function. Here are a few examples:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildConsequenceItem(
              title: 'Insufficient REM Sleep',
              description:
                  'Lack of REM sleep can impact memory consolidation, emotional regulation, and cognitive performance. It may lead to difficulties in learning, mood disturbances, and increased risk of mental health issues.',
            ),
            const SizedBox(height: 8.0),
            _buildConsequenceItem(
              title: 'Inadequate Deep Sleep',
              description:
                  'Insufficient deep sleep can impair physical recovery, hormone regulation, and immune function. It may result in increased fatigue, reduced physical performance, and compromised overall health.',
            ),
            const SizedBox(height: 8.0),
            _buildConsequenceItem(
              title: 'Disrupted Light Sleep',
              description:
                  'Disruptions in light sleep can affect relaxation, sensory processing, and memory consolidation. It may contribute to difficulties in falling asleep, frequent awakenings, and poor sleep quality.',
            ),
            const SizedBox(height: 8.0),
            _buildConsequenceItem(
              title: 'Excessive Wakefulness',
              description:
                  'Excessive wakefulness during the night can lead to sleep deprivation, daytime sleepiness, and impaired cognitive function. It may increase the risk of accidents, decreased productivity, and negative mood states.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseItem({required String title, required String description}) {
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

  Widget _buildPhaseDurationItem(
      {required String phase, required String recommendedPercentage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          phase,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Recommended Duration: $recommendedPercentage',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildConsequenceItem(
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
