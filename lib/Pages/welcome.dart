import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Tung Tee",
            style: TextStyle(fontSize: 47),
          ),
          SizedBox(
            height: 80,
          ),
          MyButton()
        ],
      )),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Get Start'),
          SizedBox(
            width: 5,
          ),
          Icon(
            // <-- Icon
            Icons.arrow_forward_ios_rounded,
            size: 15.0,
          ), // <-- Text
        ],
      ),
    );
  }
}
