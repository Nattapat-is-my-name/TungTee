import 'package:flutter/material.dart';
import 'package:tungtee/Pages/homepage.dart';

import '../Pages/create_event.dart';
import '../Pages/group_chat.dart';
import '../Pages/my_event.dart';
import '../Pages/profile.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _TabbarState();
}

class _TabbarState extends State<Bottomnavbar> {
  int currentTap = 0;

  final List<Widget> screens = [
    const HomePages(),
    const Myevent(),
    const Createevent(),
    const Groupchat(),
    const Profile()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_rounded),
              onPressed: () {
                setState(() {
                  currentScreen = const HomePages();
                  currentTap = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.event_note_rounded),
              onPressed: () {
                setState(() {
                  currentScreen = const Myevent();
                  currentTap = 1;
                });
              },
            ),
            FloatingActionButton(
              child: const Icon(Icons.add_rounded),
              onPressed: () {
                setState(() {
                  currentScreen = const Createevent();
                  currentTap = 2;
                });
              },
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.mark_email_unread_outlined),
              onPressed: () {
                setState(() {
                  currentScreen = const Groupchat();
                  currentTap = 3;
                });
              },
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.account_circle_rounded),
              onPressed: () {
                setState(() {
                  currentScreen = const Profile();
                  currentTap = 4;
                });
              },
            ),
          ],
        ),
      ),
      body: PageStorage(bucket: bucket, child: currentScreen),
    );
  }
}
