import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Pages/edit_profile.dart';
import 'package:tungtee/Services/user_provider.dart';

final user = FirebaseAuth.instance.currentUser!;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            // return SafeArea(
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           width: 150,
            //           height: 150,
            //           child: CircleAvatar(
            //             backgroundImage: NetworkImage(
            //                 (user.photoURL == null) ? "" : user.photoURL!),
            //           ),
            //         ),
            //         const SizedBox(height: 20),
            //         Text(usermodel!.fullname),
            //         Text(usermodel.email),
            //         const SizedBox(height: 10),
            //         const Divider(),
            //         const SizedBox(height: 10),
            //         Column(
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => const Editprofile()));
            //               },
            //               child: const ListTile(
            //                 leading: Icon(Icons.person),
            //                 title: Text('Profile'),
            //               ),
            //             ),
            //             const ListTile(
            //               leading: Icon(Icons.history_rounded),
            //               title: Text('History'),
            //             ),
            //             const Divider(),
            //           ],
            //         ),
            //         const Spacer(),
            //         SizedBox(
            //           width: double.infinity,
            //           height: 45,
            //           child: FilledButton(
            //               onPressed: () {
            //                 FirebaseAuth.instance.signOut();
            //               },
            //               child: const Text('Logout')),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
            return SingleChildScrollView(
              child: SafeArea(
                  child: Container(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (user.photoURL == null) ? "" : user.photoURL!),
                        ),
                      ),
                      Text(usermodel!.fullname),
                      Text(usermodel.email),
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
                      const ListTile(
                        leading: Icon(Icons.history_rounded),
                        title: Text('History'),
                      ),
                      const Divider(),
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
              )),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
