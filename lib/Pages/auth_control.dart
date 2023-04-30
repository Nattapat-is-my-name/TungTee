import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/pages/home.dart';
import 'package:tungtee/pages/login.dart';

class AuthPageController extends StatelessWidget {
  const AuthPageController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const LoginPage();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
