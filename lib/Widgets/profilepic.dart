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
    final image = usermodel!.profileImage;
    return SizedBox(
        height: h,
        width: w,
        child: image.isNotEmpty && !(image.startsWith('https'))
            ? CircleAvatar(
                backgroundImage: MemoryImage(base64Decode(image)),
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
