import 'package:flutter/material.dart';

class eventdetail extends StatefulWidget {
  const eventdetail({super.key});

  @override
  State<eventdetail> createState() => _eventdetail();
}

class _eventdetail extends State<eventdetail> {
  TextEditingController dateController = TextEditingController();

  @override
  double _startValue = 0.0;
  double _endValue = 5.0;

  bool showWidget = false;
  bool showWidget1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หมูกระทะ'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Image.asset('assets/images/google.png', width: 200, height: 201, alignment: Alignment.topCenter),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
