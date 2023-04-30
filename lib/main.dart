import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/pages/auth_control.dart';
import 'package:tungtee/pages/welcome.dart';
import 'package:tungtee/constants/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(primarySwatch: Color.fromARGB(255, 103, 80, 164)),
        theme: ThemeData(primarySwatch: primaryColor),
        home: const AuthPageController());
  }
}
