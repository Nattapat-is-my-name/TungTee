import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/login.dart';
import 'package:tungtee/Pages/register_information.dart';
import 'package:tungtee/Services/user_provider.dart';

import '../navigation/bottom_navbar.dart';

class AuthPageController extends StatelessWidget {
  const AuthPageController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<bool>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const Bottomnavbar();
                  } else {
                    // if no user in database then go to information register page (skip register email/password page)
                    // this case handle google user
                    return RegisterInformation(
                        email: FirebaseAuth.instance.currentUser?.email);
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: UserProvider().isUserRegistered(snapshot.data!.uid),
            );
          } else {
            return const LoginPage();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
