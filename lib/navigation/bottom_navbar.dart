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
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_rounded,
                    color: currentTap == 0 ? Colors.deepPurple : Colors.black),
                onPressed: () {
                  setState(() {
                    currentScreen = const HomePages();
                    currentTap = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.event_note_rounded,
                    color: currentTap == 1 ? Colors.deepPurple : Colors.black),
                onPressed: () {
                  setState(() {
                    currentScreen = const Myevent();
                    currentTap = 1;
                  });
                },
              ),
              FloatingActionButton(
                child: Icon(Icons.add_rounded,
                    color: currentTap == 2 ? Colors.deepPurple : Colors.black),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Createevent()));
                },
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: Icon(Icons.mark_email_unread_outlined,
                    color: currentTap == 3 ? Colors.deepPurple : Colors.black),
                onPressed: () {
                  setState(() {
                    currentScreen = const Groupchat();
                    currentTap = 3;
                  });
                },
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: Icon(Icons.account_circle_rounded,
                    color: currentTap == 4 ? Colors.deepPurple : Colors.black),
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
      ),
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
    );
  }
}
