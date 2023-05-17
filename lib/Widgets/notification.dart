import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Services/notificationLocal_service.dart';
import 'package:tungtee/Widgets/profilepic.dart';

import '../Models/user_model.dart';
import '../Services/user_provider.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  static const List<String> _days = <String>[
    'Neng joined หมูกระทะ Party',
    'Sora joined OS234 Party',
    'Joe  joined ตี๋น้อย Party',
  ];
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserProvider().getUserById(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final UserModel? usermodel = snapshot.data;
          return ListView.separated(
            itemCount: _days.length,
            itemBuilder: (BuildContext context, index) {
              return Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    NotificationService().showNotification(
                        title: "TungTee", body: "new notification");
                  },
                  child: SizedBox(
                    height: 80,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          ProfilePic(
                              usermodel: usermodel, user: user, h: 50, w: 50),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_days[index])
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
