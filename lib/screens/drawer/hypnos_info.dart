import 'package:flutter/material.dart';

class HypnosInfo extends StatelessWidget {
  const HypnosInfo({Key? key}) : super(key: key);

  static const route = '/hypnos_info';
  static const routeName = 'HypnosInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'About Hypnos',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Hypnos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Discover and Improve Your Sleep',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Hypnos is a sleep analysis app designed to help you understand and improve your sleep patterns. Our app provides valuable insights and information about your sleep, enabling you to make informed decisions and establish healthy sleep habits.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildFeatureItem(
              icon: Icons.nightlight_round,
              title: 'Sleep Tracking',
              description:
                  'Track and analyze your sleep patterns to gain valuable insights into the quality and duration of your sleep.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: Icons.bar_chart_rounded,
              title: 'Sleep Statistics',
              description:
                  'View detailed statistics and visualizations of your sleep patterns over time to identify trends and patterns.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: Icons.lightbulb_rounded,
              title: 'Sleep Tips and Advice',
              description:
                  'Access a wealth of sleep-related tips, meditation and physical excersices to enhance your understanding of sleep and develop healthy sleep habits.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
      {required IconData icon,
      required String title,
      required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 32),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
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
            ],
          ),
        ),
      ],
    );
  }
}
