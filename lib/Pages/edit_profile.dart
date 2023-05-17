import 'dart:convert';
import 'dart:io';

import 'package:image/image.dart' as image_lbrary;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  TextEditingController fullnameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    fullnameController.dispose();
    nicknameController.dispose();
    // Clean up the controller when the widget is disposed.
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
            fullnameController.text = usermodel!.fullname;
            nicknameController.text = usermodel.nickname;
            return SingleChildScrollView(
              child: SafeArea(
                  child: Form(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              if (isEditable) {
                                pickImage();
                              }
                            },
                            child: SizedBox(
                                height: 150,
                                width: 150,
                                child: image == null
                                    ? (usermodel.profileImage != "" &&
                                            !usermodel.profileImage
                                                .startsWith('https'))
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(
                                                base64Decode(
                                                    usermodel.profileImage)),
                                          )
                                        : (user.photoURL != null)
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    user.photoURL!),
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    primaryColor.shade100,
                                              )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(image!),
                                      )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            TextFormField(
                              controller: fullnameController,
                              enabled: isEditable,
                              decoration: const InputDecoration(
                                  filled: true,
                                  border: UnderlineInputBorder(),
                                  labelText: "Edit your fullname"),
                              // initialValue: usermodel!.fullname,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: nicknameController,
                              // onChanged: handleNickNameFieldChange,
                              enabled: isEditable,
                              decoration: const InputDecoration(
                                filled: true,
                                border: UnderlineInputBorder(),
                                labelText: 'Edit your nickname',
                              ),
                            ),
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
                                      UserProvider().updateUserFullName(
                                          user.uid, fullnameController.text);
                                      UserProvider().updateUserNickName(
                                          user.uid, nicknameController.text);

                                      //image handleler
                                      if (image != null) {
                                        final imageFile = File(image!.path);
                                        final imageBytes =
                                            imageFile.readAsBytesSync();
                                        image_lbrary.Image imageTemp =
                                            image_lbrary
                                                .decodeImage(imageBytes)!;
                                        image_lbrary.Image imageResize =
                                            image_lbrary.copyResize(imageTemp,
                                                width: 400, height: 400);
                                        final resizeBytes =
                                            image_lbrary.encodeJpg(imageResize);
                                        String image64 =
                                            base64Encode(resizeBytes);
                                        UserProvider().updateUserProfileImage(
                                            user.uid, image64);
                                      }

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
