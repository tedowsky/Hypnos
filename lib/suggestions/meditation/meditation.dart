import 'package:flutter/cupertino.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:flutter/services.dart';

class Meditation extends StatelessWidget {
  const Meditation({Key? key}) : super(key: key);

  static const routeDisplayname = 'Meditation';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Image.asset('assets/exercise/breath.png', width: 150),
            const SizedBox(height: 20),
            Text(
              "Recommended for you before sleep:",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 15,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      color: Colors.white,
                      elevation: 0.1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/exercise/breath_$index.png',
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Focusing the mind',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      Text(
                                        "${index + 3} mins",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.play_arrow),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              LinearPercentIndicator(
                                lineHeight: 5,
                                percent: 0.8,
                                progressColor: Colors.blueAccent,
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 47, 81),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('0:00'),
                                  Text('4:22'),
                                  //Icon(Icons.repeat),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
