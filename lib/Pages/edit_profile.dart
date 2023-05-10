import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/user_provider.dart';
import 'package:tungtee/constants/colors.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool isEditable = false;
  final user = FirebaseAuth.instance.currentUser!;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit profile'),
        actions: [
          Visibility(
            visible: !isEditable,
            child: IconButton(
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
          ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: UserProvider().getUserById(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final UserModel? usermodel = snapshot.data;
            return SafeArea(
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
                              labelText: "Edit your fullname"),
                          initialValue: usermodel!.fullname,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            enabled: isEditable,
                            decoration: const InputDecoration(
                              filled: true,
                              border: UnderlineInputBorder(),
                              labelText: 'Edit your nickname',
                            ),
                            initialValue: usermodel.nickname),
                        const SizedBox(height: 20),
                        TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Edit Email',
                          ),
                          initialValue: usermodel.email,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: 'Edit gender',
                          ),
                          initialValue: usermodel.gender,
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                    Visibility(
                      visible: isEditable,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 45,
                            child: FilledButton(
                                onPressed: () {
                                  setState(() {
                                    isEditable = !isEditable;
                                  });
                                },
                                child: const Text('save')),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 100,
                            height: 45,
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    isEditable = !isEditable;
                                  });
                                },
                                child: const Text('cancel')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
