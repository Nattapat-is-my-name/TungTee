import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungtee/Models/event_model.dart';
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

  @override
  void initState() {
    events = EventProvider().getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                                backgroundImage: NetworkImage(user.photoURL!),
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
                    children: const [DynamicChip()],
                  ),
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
                      FutureBuilder<List<EventModel>>(
                          future: events,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              final eventList = snapshot.data;
                              print(eventList);
                              return ListView.builder(
                                  itemCount: eventList.length,
                                  itemBuilder: (context, index) {
                                    return CardLayout(
                                      thumbnail: const Image(
                                        image: NetworkImage(
                                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 80,
                                      ),
                                      title: eventList[index]['title'],
                                      subtitle: eventList[index]['location'],
                                      toptitle: eventList[index]['dateOfEvent'],
                                      amountPerson: eventList[index]
                                              ['joinedUsers']
                                          .length,
                                      maxPerson: eventList[index]
                                          ['maximumPeople'],
                                    );
                                  });
                            } else {
                              print('mee error: ${snapshot.hasError}');
                              print(snapshot.error);
                              return const CircularProgressIndicator();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
