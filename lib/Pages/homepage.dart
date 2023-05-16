import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Pages/eventdetail.dart';
import 'package:tungtee/Pages/profile.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Services/user_provider.dart';
import 'package:tungtee/Widgets/dynamicchip.dart';
import 'package:tungtee/Widgets/profilepic.dart';
import '../Widgets/cardevent.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({
    super.key,
  });

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  late Future<List<EventModel>> events;
  List<String> selectedTag = [];
  bool isTagSelect = false;

  void handleTagSelect(String tag) {
    setState(() {
      if (tag.isNotEmpty) {
        if (selectedTag.contains(tag)) {
          selectedTag.remove(tag);
        } else {
          selectedTag.add(tag);
        }
      }
      if (selectedTag.isEmpty) {
        isTagSelect = false;
      } else {
        isTagSelect = true;
      }
    });
  }

  @override
  void initState() {
    events = EventProvider().getEvents();
    super.initState();
  }

  Future<List<EventModel>> getdataEvents() async {
    events = EventProvider().getEvents();
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: FutureBuilder<List>(
        future: Future.wait([
          UserProvider().getUserById(user.uid),
          (isTagSelect)
              ? EventProvider().getEventsByTags(selectedTag)
              : getdataEvents()
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final UserModel usermodel = snapshot.data![0];
            final List<EventModel> eventList = snapshot.data![1];
            final List<EventModel> nonEmptyEvents = eventList.where((event) {
              return event.maximumPeople != event.joinedUsers.length &&
                  event.dateOfEvent.start.isAfter(DateTime.now());
            }).toList();
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Welcome Name
                            Column(
                              children: [
                                Text('Welcome ${usermodel.nickname}',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        height: 1.33,
                                        color: Color(0xff3b383e))),
                                const Text(
                                  // tungtee9sD (57:18316)
                                  'TUNG TEE',
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
                                              builder: (context) =>
                                                  const Profile()));
                                    },
                                    child: ProfilePic(
                                        usermodel: usermodel,
                                        user: user,
                                        h: 50,
                                        w: 50)),
                              ],
                            ),
                          ],
                        ),

                        //Search Bar
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 16),
                            child: TextField(
                                decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search Event',
                            ))),
                      ]),
                    ),
                    //Chip
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          DynamicChip(
                            handleTagSelect: handleTagSelect,
                            selectedTags: selectedTag,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                      'Event',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2222222222,
                                        color: Color(0xff000000),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: ListView.builder(
                            itemCount: nonEmptyEvents.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EventDetail(
                                                    eventId: nonEmptyEvents
                                                        .elementAt(index)
                                                        .eventId,
                                                  )));
                                    },
                                    child: CardLayout(
                                      thumbnail: nonEmptyEvents[index].image,
                                      title: nonEmptyEvents
                                          .elementAt(index)
                                          .eventTitle,
                                      subtitle: nonEmptyEvents
                                          .elementAt(index)
                                          .location,
                                      toptitle: nonEmptyEvents
                                          .elementAt(index)
                                          .dateOfEvent
                                          .start
                                          .toString(),
                                      amountPerson: nonEmptyEvents
                                          .elementAt(index)
                                          .joinedUsers
                                          .length
                                          .toString(),
                                      maxPerson: nonEmptyEvents
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
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
