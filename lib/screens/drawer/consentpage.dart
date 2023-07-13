import 'package:flutter/material.dart';
import 'package:hypnos/screens/info.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ConsentPage extends StatelessWidget {
  const ConsentPage({Key? key}) : super(key: key);

  static const routeName = 'ConsentPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Hypnos requests your consent to use\n your personal data for these purposes:',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            _buildFeatureItem(
              icon: MdiIcons.accountDetails,
              title: 'Store or access your data',
              description:
                  'Hypnos stores your sleep data securely and accesses it to provide personalized sleep analysis and recommendations.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: MdiIcons.accountSearch,
              title: 'Sleep Statistics',
              description:
                  'View detailed statistics and visualizations of your sleep patterns over time to identify trends and patterns.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: MdiIcons.shieldCheck,
              title: 'Data Privacy and Security',
              description:
                  'Hypnos takes data privacy and security seriously. Your personal information is protected and will not be shared with third parties without your explicit consent.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: Icons.settings,
              title: 'Control and Customize',
              description:
                  'You have full control over your data. You can customize your privacy settings and choose the information you want to share or keep private.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: MdiIcons.eyeCheck,
              title: 'Transparency and Visibility',
              description:
                  'Hypnos is transparent about how your data is collected, processed, and used. You can access and review your data at any time.',
            ),
            const SizedBox(height: 8.0),
            _buildFeatureItem(
              icon: MdiIcons.accountMultipleCheck,
              title: 'Anonymized Data',
              description:
                  'Your data may be used in an anonymized and aggregated form for research and analysis purposes to improve sleep science and understanding.',
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                      const SnackBar(content: Text('Approved Consent')));

                Future.delayed(
                    const Duration(milliseconds: 300),
                    () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const InfoPage())));
              },
              child: const Text('I Consent'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                onPrimary: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
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
