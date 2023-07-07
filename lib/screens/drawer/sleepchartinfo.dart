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
              title: 'Durata dei cicli del sonno:',
              description:
                  'Un ciclo completo del sonno dura in media da 90 a 120 minuti e si ripete più volte durante la notte. Durante ogni ciclo, il cervello attraversa diverse fasi del sonno, inclusi periodi di sonno leggero, sonno profondo e sonno REM.',
            ),
             const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Distribuzione delle fasi del sonno:',
              description:
                  'Durante la prima metà della notte, i cicli del sonno tendono ad avere una maggiore quantità di sonno profondo. Nella seconda metà della notte, i cicli del sonno sono caratterizzati da una maggiore presenza di sonno REM. Questa distribuzione riflette un modello di sonno tipico e sano.',
            ),
             const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Sonno leggero:',
              description:
                  'Il sonno leggero rappresenta la fase di transizione tra il sonno profondo e il sonno REM. Durante questa fase, il corpo e il cervello si rilassano e si preparano per il sonno profondo e il sonno REM successivi.',
            ),
             const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Sonno profondo:',
              description:
                  'Il sonno profondo è una fase di sonno rigenerante e riparatore. Durante questa fase, il corpo si rilassa completamente, la pressione sanguigna diminuisce e il sistema immunitario si rafforza. Il sonno profondo è importante per il recupero fisico e mentale.',
            ),
             const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Pattern di sonno sano:',
              description:
                  'Un buon pattern di sonno sano comprende una quantità adeguata di sonno profondo e sonno REM. È consigliabile avere cicli di sonno completi durante la notte, senza interruzioni significative. Inoltre, un sonno di qualità si caratterizza per una sensazione di freschezza e riposo al risveglio, senza eccessiva sonnolenza diurna.',
            ),
             const SizedBox(height: 8.0),
            _buildInfoItem(
              title: 'Consistenza del sonno:',
              description:
                  'Mantenere una routine di sonno regolare è fondamentale per favorire un buon sonno. Andare a letto e svegliarsi alla stessa ora ogni giorno può aiutare a sincronizzare il ritmo circadiano e migliorare la qualità del sonno.',
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
