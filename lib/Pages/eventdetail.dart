import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tungtee/Widgets/dynamicchip.dart';
import 'package:tungtee/constants/colors.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key});

  @override
  State<EventDetail> createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  TextEditingController dateController = TextEditingController();

  bool showWidget = false;
  bool showWidget1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หมูกระทะ'),
      ),
      bottomNavigationBar: MyBottomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // Image(
            //       image: NetworkImage(
            //           'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
            //       fit: BoxFit.cover,
            //       height: 20,
            //       width: 80,
            //     ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Chip(
                    label: const Text(
                      'Food',
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: BorderSide.none,
                    backgroundColor: rawPrimaryColor,
                  ),
                  const Text(
                    '25 Jul 18 at 12:00 am - 2:00 pm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'หมูกะทะ',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.pin),
                              Text('Susco ,Thanon Puttabucha Bang Mod')
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Row(
                              children: const [
                                Expanded(
                                    child: Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: const [
                              Icon(Icons.cake_outlined),
                              Text('14-18'),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('2/5'),
                              Text('person'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FilledButton(
            child: const Text('Join'),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  BorderSide(color: Color(0xFF6750A4))),
            ),
            child: const Text('Cancel'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
