import 'package:flutter/material.dart';

class infosleep extends StatelessWidget {
  const infosleep ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 172, 143, 192),
          iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          title: const Text('Know More About Your Sleep',
              style: TextStyle(color: Colors.black))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text('Chart 1'),
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text('Chart 2'),
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Text('Chart 3'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 100,
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: const Text(
                      'Chart 1 description',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Chart 1 info',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: const Text(
                      'Chart 2 description',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Chart 2 info',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Chart 3 description',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Chart 3 info',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}