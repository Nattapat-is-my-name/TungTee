import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Pages/edit_profile.dart';
import 'package:tungtee/Pages/history.dart';
import 'package:tungtee/Services/user_provider.dart';

import '../Widgets/profilepic.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<UserModel?>(
        future: UserProvider().getUserById(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final UserModel? usermodel = snapshot.data;
            return SingleChildScrollView(
              child: SafeArea(
                  child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ProfilePic(
                      usermodel: usermodel,
                      user: user,
                      h: 150,
                      w: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Column(
                        children: [
                          Text(usermodel!.fullname),
                          Text(usermodel.email),
                        ],
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Editprofile()));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoryPage()));
                      },
                      child: const ListTile(
                        leading: Icon(Icons.history_rounded),
                        title: Text('History'),
                      ),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FilledButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text('Logout')),
                      ),
                    ),
                  ],
                ),
              )),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
