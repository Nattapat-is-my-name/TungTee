import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/chat_event.dart';
import 'package:tungtee/Pages/edit_event.dart';
import 'package:tungtee/constants/colors.dart';
import 'package:tungtee/navigation/bottom_navbar.dart';
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
  bool isSetDelete = false;
  bool isSetLeft = false;
  bool isJoin = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: EventProvider().getEventById(widget.eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final event = snapshot.data;
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
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        alignment: WrapAlignment.start,
                        children: [
                          Chip(
                            label: Text(
                              event.tag, // !need to pull from boss-sora
                              style: const TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            side: BorderSide.none,
                            backgroundColor: rawPrimaryColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${event.dateOfEvent.start} - ${event.dateOfEvent.end}', // !need to pull from boss-sora
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                                    children: [
                                      const Icon(Icons.location_on),
                                      Text(
                                        event
                                            .location, // !need to pull from boss-sora
                                        style: const TextStyle(
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
                                  children: [
                                    Text(
                                        '${event.joinedUsers.length} - ${event.maximumPeople}'), // !need to pull from boss-sora
                                    const Text('person'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          !event.joinedUsers.contains(
                                  FirebaseAuth.instance.currentUser!.uid)
                              ? Row(
                                  // not joined
                                  children: [
                                    FilledButton(
                                        onPressed: () async {
                                          await UserProvider().joinEvent(
                                              widget.eventId,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);
                                          await EventProvider().addUserToEvent(
                                              widget.eventId,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);
                                          setState(() {
                                            isJoin = true;
                                          });
                                        },
                                        child: const Text("Join")),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancle"))
                                  ],
                                )
                              : event.ownerId ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Row(
                                      // joined owner
                                      children: [
                                        FilledButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xFF797979))),
                                            onPressed: () async {
                                              final isReload =
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditEvent(
                                                                  eventId: event
                                                                      .eventId)));
                                              if (isReload) {
                                                setState(() {});
                                              }
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit),
                                                SizedBox(width: 5),
                                                Text('Edit')
                                              ],
                                            )),
                                        const SizedBox(width: 10),
                                        FilledButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xFFDC362E))),
                                            onPressed: () async {
                                              final dialogResult =
                                                  await showDialog<bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Are you sure?'),
                                                          content: const Text(
                                                              'This will delete the event.'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'OK')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      false);
                                                                },
                                                                child: const Text(
                                                                    'Cancel')),
                                                          ],
                                                        );
                                                      });
                                              if (dialogResult != null &&
                                                  dialogResult) {
                                                event.joinedUsers
                                                    .map((userId) async {
                                                  await UserProvider()
                                                      .leftEvent(widget.eventId,
                                                          userId);
                                                });
                                                await EventProvider()
                                                    .deleteEventById(
                                                        widget.eventId);
                                                await UserProvider()
                                                    .userDeleteEvent(
                                                        widget.eventId,
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                if (context.mounted) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Bottomnavbar()));
                                                }
                                              }
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(Icons.delete_outline),
                                                SizedBox(width: 5),
                                                Text('Delete')
                                              ],
                                            )),
                                        const SizedBox(width: 10),
                                        FilledButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatEvent(
                                                            event: event,
                                                          )));
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(Icons.chat_bubble_outline),
                                                SizedBox(width: 5),
                                                Text('Chat')
                                              ],
                                            )),
                                      ],
                                    )
                                  : Row(
                                      // joined but not owner
                                      children: [
                                        FilledButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xFFDC362E))),
                                            onPressed: () async {
                                              final dialogResult =
                                                  await showDialog<bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Are you sure?'),
                                                          content: const Text(
                                                              'You are about to leave the event.'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'OK')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      false);
                                                                },
                                                                child: const Text(
                                                                    'Cancel')),
                                                          ],
                                                        );
                                                      });
                                              if (dialogResult != null &&
                                                  dialogResult) {
                                                await UserProvider().leftEvent(
                                                    widget.eventId,
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid);
                                                await EventProvider()
                                                    .removeUserFromEvent(
                                                        widget.eventId,
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                if (context.mounted) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Bottomnavbar()));
                                                }
                                              }
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(Icons.exit_to_app),
                                                SizedBox(width: 5),
                                                Text('Left')
                                              ],
                                            )),
                                        const SizedBox(width: 10),
                                        FilledButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatEvent(
                                                            event: event,
                                                          )));
                                            },
                                            child: Row(
                                              children: const [
                                                Icon(Icons.chat_bubble_outline),
                                                SizedBox(width: 5),
                                                Text('Chat')
                                              ],
                                            )),
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
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
