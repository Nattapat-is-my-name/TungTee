import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/constants/colors.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool isEditable = false;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit profile'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isEditable) {
                  isEditable = false;
                } else {
                  isEditable = true;
                }
              });
            },
            icon: const Icon(Icons.edit_square, color: rawPrimaryColor),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      (user.photoURL == null) ? "" : user.photoURL!),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  TextFormField(
                    enabled: isEditable,
                    decoration: const InputDecoration(
                      filled: true,
                      border: UnderlineInputBorder(),
                      hintText: 'Edit your name',
                      labelText: 'Name from DB',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: isEditable,
                    decoration: const InputDecoration(
                      filled: true,
                      border: UnderlineInputBorder(),
                      hintText: 'Edit your nickname',
                      labelText: 'Nick Name from DB',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      border: UnderlineInputBorder(),
                      labelText: 'Email from DB',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      border: UnderlineInputBorder(),
                      labelText: 'Gender from DB',
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
