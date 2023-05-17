import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Models/user_model.dart';

import '../Constants/colors.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.usermodel,
    required this.user,
    required this.h,
    required this.w,
  });

  final UserModel? usermodel;
  final User user;
  final double h;
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: h,
        width: w,
        child: usermodel!.profileImage != "" &&
                !usermodel!.profileImage.startsWith('https')
            ? CircleAvatar(
                backgroundImage: MemoryImage(
                base64Decode(usermodel!.profileImage),
              ))
            : usermodel!.profileImage.startsWith('https')
                ? CircleAvatar(
                    backgroundImage: NetworkImage(usermodel!.profileImage))
                : (user.photoURL != null)
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor: primaryColor.shade100,
                        child: const Icon(Icons.person),
                      ));
  }
}
