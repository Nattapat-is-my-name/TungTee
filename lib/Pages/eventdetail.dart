import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/chat_event.dart';
import 'package:tungtee/constants/colors.dart';
import 'package:tungtee/services/event_provider.dart';
import 'package:tungtee/services/user_provider.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key, required this.eventId});
  final String eventId;

  @override
  State<EventDetail> createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  TextEditingController dateController = TextEditingController();

  bool showWidget = false;
  bool showWidget1 = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: EventProvider().getEventById(widget.eventId),
        builder: (context, snapshot) {
          final event = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text(event!.eventTitle),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const Image(
                      image: NetworkImage(
                          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      fit: BoxFit.fill,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Chip(
                            label: const Text(
                              "food", // !need to pull from boss-sora
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            side: BorderSide.none,
                            backgroundColor: rawPrimaryColor,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '25 Jul 18 at 12:00 am - 2:00 pm', // !need to pull from boss-sora
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      event.eventTitle,
                                      style: const TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.location_on),
                                      Text(
                                        'Susco ,Thanon Puttabucha Bang Mod', // !need to pull from boss-sora
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(event.eventDescription)),
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
                                  children: [
                                    const Icon(Icons.cake_outlined),
                                    Text(
                                        '${event.ageRestriction.minimumAge} - ${event.ageRestriction.maximumAge}'),
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Text('2/5'), // !need to pull from boss-sora
                                    Text('person'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          event.joinedUsers.contains(
                                  FirebaseAuth.instance.currentUser!.uid)
                              ?

                              // joined
                              Row(
                                  children: [
                                    FilledButton(
                                        onPressed: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.check),
                                            SizedBox(width: 10),
                                            Text('Joined')
                                          ],
                                        )),
                                    const SizedBox(width: 5),
                                    FilledButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatEvent(event: const <
                                                          String, dynamic>{})));
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(Icons.chat_bubble_outline),
                                            SizedBox(width: 10),
                                            Text('Chat')
                                          ],
                                        )),
                                  ],
                                  // not joined
                                )
                              : Row(
                                  children: [
                                    FilledButton(
                                        onPressed: () async {
                                          await UserProvider().joinEvent(
                                              widget.eventId,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);
                                          initState();
                                        },
                                        child: const Text("Join")),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancle"))
                                  ],
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
