import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Myevent extends StatelessWidget {
  const Myevent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Myevent'),
      ),
      body: Text("MY EVENTS!!!"),
    );
  }
}
