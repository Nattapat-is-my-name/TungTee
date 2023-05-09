import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/edit_profile.dart';

final user = FirebaseAuth.instance.currentUser!;

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Nattapat Teeranuntacahi"),
              const Text("MJndjkn@gmail.com"),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: <Widget>[
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
                    const ListTile(
                      leading: Icon(Icons.history_rounded),
                      title: Text('History'),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: FilledButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Logout')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
