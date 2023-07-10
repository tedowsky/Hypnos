import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GSIChart extends StatelessWidget {
  final double gsi;

  const GSIChart({super.key, required this.gsi});

  @override
  Widget build(BuildContext context) {
    Color getColor(double gsi) {
      if (gsi <= 1.5) {
        return Colors.red;
      } else if (gsi <= 2.5) {
        return Colors.orange;
      } else if (gsi <= 3.5) {
        return const Color.fromARGB(255, 201, 201, 99);
      } else if (gsi <= 4.5) {
        return Colors.blue;
      } else {
        return Colors.green;
      }
    }

    return CircularPercentIndicator(
      radius: 70.0,
      lineWidth: 10.0,
      percent: gsi / 5,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gsi.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: getColor(gsi),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'GSI',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      progressColor: getColor(gsi),
      backgroundColor: Colors.white24,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 1000,
    );
  }
}

// 5) se il GSI finale è di > 4.5, il balance tra le fasi è perfetto e il soggetto ha dormito l'orario raccomandato di ore e con un efficienza perfetto
// se il GSI finale sta tra 3.5 e 4.5 il balance tra le fasi è buono il soggetto ha dormito l'orario raccomandato con una buona efficienza
// se il GSI finale sta tra 2.5 e 3.5 il balance tra le fasi è discreto e il soggetto ha dormito un'orario sufficiente di ore, vengono consigliate attività leggere
// se il GSI finale sta tra 1.5 e 2.5 il balance tra le fasi non è buono, il sono non è stato sufficiente per recuperare le energie e vengono consigliate attività più serie
// se il GSI finale è minore di 1.5 il sonno è pessimo devi fare qualcosa per cambiare.