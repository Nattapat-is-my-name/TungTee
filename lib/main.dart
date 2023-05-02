import 'package:flutter/material.dart';
import 'package:tungtee/Pages/welcome.dart';
import 'package:tungtee/Pages/BasicInformation.dart';
import 'package:tungtee/Widgets/cardevent.dart';
import 'package:tungtee/homepage.dart';
import 'package:tungtee/Pages/Myeventpage_user.dart';
import 'package:tungtee/Widgets/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      home: const Myevent_user(),
    );
  }
}
