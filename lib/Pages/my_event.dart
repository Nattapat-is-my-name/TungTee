import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungtee/Pages/edit_event.dart';
import 'package:tungtee/Pages/profile.dart';

import '../Models/event_model.dart';
import '../Services/user_provider.dart';
import '../Widgets/cardevent.dart';
import 'package:flutter/material.dart';

import 'eventdetail.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({super.key});

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  String? _selectedValue = 'Joined';

  void onChanged(String? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
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
                        const Icon(Icons.notifications_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()));
                          },
                          child: CircleAvatar(
                              // backgroundImage: NetworkImage(user.photoURL!),
                              ),
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'List of your Events:',
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
                                  DropdownButton<String>(
                                    value: _selectedValue,
                                    underline: Container(),
                                    onChanged: onChanged,
                                    items: <String>[
                                      'Joined',
                                      'Created',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _selectedValue == 'Created'
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: FutureBuilder<List<EventModel>?>(
                          future: UserProvider().getCreatedEvents(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final List<EventModel> eventList = snapshot.data;
                              final List<EventModel> createdEvents = eventList
                                  .where((event) =>
                                      event.ownerId ==
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .toList();
                              // print(eventList);
                              return ListView.builder(
                                  itemCount: createdEvents.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditEvent(
                                                          eventId: createdEvents
                                                              .elementAt(index)
                                                              .eventId,
                                                        )));
                                          },
                                          child: CardLayout(
                                            thumbnail: const Image(
                                              image: NetworkImage(
                                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 80,
                                            ),
                                            title: createdEvents
                                                .elementAt(index)
                                                .eventTitle,
                                            subtitle: createdEvents
                                                .elementAt(index)
                                                .location,
                                            toptitle: createdEvents
                                                .elementAt(index)
                                                .dateOfEvent
                                                .start
                                                .toString(),
                                            amountPerson: createdEvents
                                                .elementAt(index)
                                                .joinedUsers
                                                .length
                                                .toString(),
                                            maxPerson: createdEvents
                                                .elementAt(index)
                                                .maximumPeople
                                                .toString(),
                                          ),
                                        ),
                                        const SizedBox(height: 10)
                                      ],
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  )
                // joined events
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: FutureBuilder<List<EventModel>?>(
                          future: UserProvider().getJoinedEvents(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              final List<EventModel> eventList = snapshot.data;
                              return ListView.builder(
                                  itemCount: eventList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventDetail(
                                                          eventId: eventList
                                                              .elementAt(index)
                                                              .eventId,
                                                        )));
                                          },
                                          child: CardLayout(
                                            thumbnail: const Image(
                                              image: NetworkImage(
                                                  'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 80,
                                            ),
                                            title: eventList
                                                .elementAt(index)
                                                .eventTitle,
                                            subtitle: eventList
                                                .elementAt(index)
                                                .location,
                                            toptitle: eventList
                                                .elementAt(index)
                                                .dateOfEvent
                                                .start
                                                .toString(),
                                            amountPerson: eventList
                                                .elementAt(index)
                                                .joinedUsers
                                                .length
                                                .toString(),
                                            maxPerson: eventList
                                                .elementAt(index)
                                                .maximumPeople
                                                .toString(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
