import 'package:firebase_auth/firebase_auth.dart';

import '../Models/event_model.dart';
import '../Services/user_provider.dart';
import '../Widgets/DynamicChip.dart';
import '../Widgets/cardevent.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/eventdetail.dart';

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
  late Future<List<EventModel>?> joinedEvents;
  late Future<List<EventModel>?> createdEvents;

  Future<void> getUserEvents() async {
    print('this is auth user ${FirebaseAuth.instance.currentUser!}');
    final join =
        UserProvider().getJoinedEvents(FirebaseAuth.instance.currentUser!.uid);
    final create =
        UserProvider().getCreatedEvents(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      joinedEvents = join;
      createdEvents = create;
    });
  }

  @override
  void initState() {
    getUserEvents();
    super.initState();
  }

  String? _selectedValue = 'Joined';

  void onChanged(String? value) {
    setState(() {
      _selectedValue = value;
      print(_selectedValue);
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
                      children: const [
                        Icon(Icons.notifications_outlined),
                        Icon(Icons.account_circle),
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
                                  DropdownButton<String>(
                                    value: _selectedValue,
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
                          future: UserProvider().getJoinedEvents(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              final List<EventModel> eventList = snapshot.data;
                              // print(eventList);
                              return ListView.builder(
                                  itemCount: eventList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CardLayout(
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
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return Container(
                                  child: const CircularProgressIndicator());
                            }
                          }),
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: FutureBuilder<List<EventModel>?>(
                          future: UserProvider().getCreatedEvents(
                              FirebaseAuth.instance.currentUser!.uid),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              final List<EventModel> eventList = snapshot.data;
                              // print(eventList);
                              return ListView.builder(
                                  itemCount: eventList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        CardLayout(
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
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return Container(
                                  child: const CircularProgressIndicator());
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
