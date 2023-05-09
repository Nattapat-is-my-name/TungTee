import 'package:flutter/material.dart';
import 'package:tungtee/Widgets/notification.dart';

import '../Widgets/dropdownwidget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
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
              ),
              const Expanded(child: NotificationWidget())
            ],
          ),
        ),
      ),
    );
  }
}
