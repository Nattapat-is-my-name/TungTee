import 'package:flutter/material.dart';
import 'package:tungtee/Pages/chat_list.dart';
import 'package:tungtee/Pages/homepage.dart';

import '../Pages/create_event.dart';
import '../Pages/my_event.dart';
import '../Pages/profile.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _TabbarState();
}

class _TabbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;
  final List<Widget> screens = [
    const HomePages(),
    const MyEvent(),
    const Createevent(),
    const ChatListPage(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Createevent()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'My Event',
          ),
          BottomNavigationBarItem(
            icon: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Center(child: Icon(Icons.add)),
              ),
            ),
            label: 'Create Event',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
    );
  }
}
