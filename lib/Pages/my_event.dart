import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/dynamicchip.dart';
import '../Widgets/cardevent.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/services/event_provider.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Services/event_provider.dart';

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
  final List<EventModel> eventData = [
    EventModel(
        eventId: "123",
        ownerId: "123",
        eventTitle: "Test",
        eventDescription: "test",
        maximumPeople: 0,
        tags: [],
        ageRestriction: AgeRestrictionModel(minimumAge: 0, maximumAge: 0),
        dateCreated: DateTime(2),
        dateOfEvent: DateOfEventModel(start: DateTime(2), end: DateTime(4)),
        location: LocationModel(latitude: 2, longitude: 232),
        images: [],
        joinedUsers: [])
  ];
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      const Spacer(),
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
                            backgroundImage: NetworkImage(
                                (user.photoURL == null) ? "" : user.photoURL!),
                          ),
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
                                  children: const [
                                    DropdownButtonExample(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: eventData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final EventModel event = eventData[index];
                          return CardLayout(
                            thumbnail: const Image(
                              image: NetworkImage(
                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 80,
                            ),
                            title: event.eventTitle,
                            subtitle: event.eventDescription,
                            toptitle: event.eventTitle,
                            amountPerson: event.ownerId,
                            maxPerson: event.ownerId,
                          );
                        },
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
