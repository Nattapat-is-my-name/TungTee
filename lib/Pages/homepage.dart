import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungtee/Pages/notification.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Pages/eventdetail.dart';
import 'package:tungtee/Pages/profile.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Widgets/dynamicchip.dart';
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
      body: GestureDetector(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Welcome Name
                      Column(
                        children: const [
                          Text('Welcome Boss',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                  color: Color(0xff3b383e))),
                          Text(
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
                              backgroundImage: NetworkImage(
                                  (user.photoURL == null)
                                      ? ""
                                      : user.photoURL!),
                            ),
                          ),
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
                  child: FutureBuilder<List<EventModel>>(
                      future: isTagSelect
                          ? EventProvider().getEventsByTags(selectedTag)
                          : getdataEvents(),
                      builder: (context, AsyncSnapshot snapshot) {
                        // getdataEvents();
                        if (snapshot.connectionState == ConnectionState.done) {
                          final List<EventModel> eventList = snapshot.data;
                          final List<EventModel> nonEmptyEvents =
                              eventList.where((event) {
                            return event.maximumPeople !=
                                    event.joinedUsers.length &&
                                event.dateOfEvent.start.isAfter(DateTime.now());
                          }).toList();
                          // print(eventList);
                          return ListView.builder(
                              itemCount: nonEmptyEvents.length,
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
                                                      eventId: nonEmptyEvents
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
      ),
    );
  }
}
