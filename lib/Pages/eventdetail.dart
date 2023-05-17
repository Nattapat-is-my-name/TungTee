import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tungtee/Pages/chat_event.dart';
import 'package:tungtee/Pages/edit_event.dart';
import 'package:tungtee/Services/chat_provider.dart';
import 'package:tungtee/Widgets/timewidget.dart';
import 'package:tungtee/constants/colors.dart';
import 'package:tungtee/navigation/bottom_navbar.dart';
import 'package:tungtee/services/event_provider.dart';
import 'package:tungtee/services/user_provider.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key, required this.eventId, required this.image});
  final String eventId;
  final String image;

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
            bool is5MinClose = false;
            if (event!.dateOfEvent.start.difference(DateTime.now()).inMinutes <=
                5) {
              print('hi');
              is5MinClose = true;
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(event.eventTitle),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Image(
                      image: MemoryImage(base64Decode(widget.image)),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          // Text(
                          //   // '${event.dateOfEvent.start} - ${event.dateOfEvent.end}', // !need to pull from boss-sora
                          //   '${getTimeConvert(event.dateOfEvent.start)} - ${getTimeConvert(event.dateOfEvent.end)}',
                          //   style: const TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          DateCard(
                              icons: Icons.calendar_month_outlined,
                              label: getDateConvert(event.dateOfEvent.start)),
                          const SizedBox(width: 10),
                          DateCard(
                              icons: Icons.alarm,
                              label: getTimeConvert(event.dateOfEvent.start))
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
                                    !is5MinClose
                                        ? FilledButton(
                                            onPressed: () async {
                                              if (is5MinClose || isJoin) return;
                                              await UserProvider().joinEvent(
                                                  widget.eventId,
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid);
                                              await EventProvider()
                                                  .addUserToEvent(
                                                      widget.eventId,
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid);
                                              setState(() {
                                                isJoin = true;
                                              });
                                            },
                                            child: const Text('Join'))
                                        : FilledButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xFF797979))),
                                            onPressed: () async {},
                                            child: const Text('Lock')),
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditEvent(
                                                              event: event,
                                                              eventId: event
                                                                  .eventId)));
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
                                                await Future.forEach(
                                                    event.joinedUsers,
                                                    (userId) async =>
                                                        await UserProvider()
                                                            .leftEvent(
                                                                event.eventId,
                                                                userId));

                                                await EventProvider()
                                                    .deleteEventById(
                                                        widget.eventId);
                                                await UserProvider()
                                                    .userDeleteEvent(
                                                        widget.eventId,
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid);
                                                await UserProvider().leftEvent(
                                                    widget.eventId,
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid);
                                                await ChatProvider()
                                                    .deleteChatRoom(
                                                        widget.eventId);
                                                // if (context.mounted) {
                                                //   Navigator.pushReplacement(
                                                //       context,
                                                //       MaterialPageRoute(
                                                //           builder: (context) =>
                                                //               const Bottomnavbar()));
                                                // }
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
                                                await ChatProvider()
                                                    .userLeftEvent(
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

String getDateConvert(DateTime time) {
  String string = DateFormat("dd-MM-yy").format(time);
  return string;
}

String getTimeConvert(DateTime time) {
  String string = DateFormat("HH:mm").format(time);
  return string;
}
