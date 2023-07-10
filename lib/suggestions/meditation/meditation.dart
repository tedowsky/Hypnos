import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Meditation extends StatefulWidget {
   const Meditation({Key? key}) : super(key: key);

static const routeDisplayname = 'Meditation';

  @override
  State<Meditation> createState() => _MeditationState();
}


class _MeditationState extends State<Meditation>  {
  
  
  final duration = ['3:14','2:45','3:40','2:56'];
  final motivation = ['Focusing the mind','Deep breath','Find your equilibrium','Mindfulness'];
  final timing = ['3 min 14 sec','2 min 45 sec','3 min 40sec','2 min 56 sec'];
  bool button = false;

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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,),
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
                                  Image.asset('assets/exercise/breath_$index.png', width: 50,),
                                  const SizedBox(width: 8,),
                                  Column(
                                    children: [
                                      Text(
                                        motivation[index],
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      Text(
                                        timing[index],
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        button=!button;
                                      });                                    
                                    }, 
                                    icon: Icon(!button?CupertinoIcons.play_circle:CupertinoIcons.pause_circle),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              LinearPercentIndicator(
                                  lineHeight: 4,
                                  percent: 1,
                                  progressColor: Colors.blueAccent,
                                  backgroundColor: const Color.fromARGB(255, 4, 47, 81),
                              ),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('0:00'),
                                  Text(duration[index]),
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