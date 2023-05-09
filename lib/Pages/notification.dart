import 'package:flutter/material.dart';

import '../Widgets/dropdownwidget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Notification",
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text("Notification"),
                      SizedBox(
                        width: 15,
                      ),
                      MyButton(),
                    ],
                  ),
                  TextButton(
                      onPressed: () {}, child: const Text("Mark all as read"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
