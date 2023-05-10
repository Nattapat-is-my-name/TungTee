import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Imgpicker extends StatefulWidget {
  const Imgpicker({super.key});

  @override
  State<Imgpicker> createState() => _Imgpicker();
}

class _Imgpicker extends State<Imgpicker> {
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
  Widget build(BuildContext context) {
    return image == null
        ? GestureDetector(
            onTap: () {
              pickImage();
            },
            child: const Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Center(
                child: Text('Upload Images'),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                image = null;
              });
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
              ),
              child: Image.file(
                image!,
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.all(0),
            ),
          );
  }
}
