import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/home.dart';
import 'package:tungtee/Pages/homepage.dart';
import 'package:tungtee/Pages/login.dart';

import '../navigation/bottom_navbar.dart';

class AuthPageController extends StatelessWidget {
  const AuthPageController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Bottomnavbar();
          }
          return const LoginPage();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
