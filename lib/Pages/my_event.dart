import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/dynamicchip.dart';
import '../Widgets/cardevent.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/eventdetail.dart';

import 'notification.dart';

// import 'CardT.dart';
const List<String> list = <String>['Joined', 'Created'];

class Myevent extends StatefulWidget {
  const Myevent({
    super.key,
  });

  @override
  State<Myevent> createState() => _Myevent_user_state();
}

class _Myevent_user_state extends State<Myevent> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Welcome Name
                      Column(
                        children: const [
                          Text(
                            // tungtee9sD (57:18316)
                            'My Event',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                              height: 1.2222222222,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const NotificationPage();
                                }));
                              },
                              child: const Icon(Icons.notifications_outlined)),
                          CircleAvatar(
                              backgroundImage: NetworkImage(user.photoURL!)),
                        ],
                      ),
                    ],
                  ),
                ]),
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
                            children: [
                              const Text(
                                'Joined Event',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2222222222,
                                  color: Color(0xff000000),
                                ),
                              ),
                              Expanded(
                                child: Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    DropdownButtonExample(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EventDetail()));
                      },
                      child: Column(
                        children: const [
                          CardLayout(
                            thumbnail: Image(
                              image: NetworkImage(
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 80,
                            ),
                            title: 'หมู',
                            subtitle:
                                'Flutter continues to improve and expand its horizons. '
                                'This text should max out at two lines and clip',
                            toptitle: 'Fri 17 Mar 08:09',
                            amountPerson: '5',
                            maxPerson: '10',
                          ),
                          CardLayout(
                            thumbnail: Image(
                              image: NetworkImage(
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 80,
                            ),
                            title: 'หมู',
                            subtitle:
                                'Flutter continues to improve and expand its horizons. '
                                'This text should max out at two lines and clip',
                            toptitle: 'Fri 17 Mar 08:09',
                            amountPerson: '5',
                            maxPerson: '10',
                          ),
                          CardLayout(
                            thumbnail: Image(
                              image: NetworkImage(
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 80,
                            ),
                            title: 'หมู',
                            subtitle:
                                'Flutter continues to improve and expand its horizons. '
                                'This text should max out at two lines and clip',
                            toptitle: 'Fri 17 Mar 08:09',
                            amountPerson: '5',
                            maxPerson: '10',
                          ),
                          CardLayout(
                            thumbnail: Image(
                              image: NetworkImage(
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 80,
                            ),
                            title: 'หมู',
                            subtitle:
                                'Flutter continues to improve and expand its horizons. '
                                'This text should max out at two lines and clip',
                            toptitle: 'Fri 17 Mar 08:09',
                            amountPerson: '5',
                            maxPerson: '10',
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

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      alignment: Alignment.centerLeft,
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
