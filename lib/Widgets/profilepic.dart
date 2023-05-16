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
        child: usermodel!.profileImage != ""
            ? CircleAvatar(
                backgroundImage: usermodel!.profileImage.startsWith('https')
                    ? null
                    : MemoryImage(base64Decode(usermodel!.profileImage)),
                child: usermodel!.profileImage.startsWith('https')
                    ? Image.network(usermodel!.profileImage)
                    : null,
                // backgroundImage:
                //     MemoryImage(base64Decode(usermodel!.profileImage)),
              )
            : (user.photoURL != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                  )
                : CircleAvatar(
                    backgroundColor: primaryColor.shade100,
                  ));
  }
}
