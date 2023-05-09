import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Models/event_model.dart';
import '../Pages/create_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('${user.email}'),
            FilledButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Sign out')),
            FilledButton(
                onPressed: () async {
                  final event = await EventProvider().createEvent(EventModel(
                      eventId: "eventId_test",
                      ownerId: "ownerId_test",
                      eventTitle: "test event",
                      eventDescription: "",
                      maximumPeople: 5,
                      tags: ["test1", "test2"],
                      ageRestriction:
                          AgeRestrictionModel(minimumAge: 20, maximumAge: 30),
                      dateCreated: DateTime.now(),
                      dateOfEvent: DateOfEventModel(
                          start: DateTime.now(), end: DateTime.now()),
                      location: LocationModel(latitude: 20, longitude: 20),
                      images: [],
                      joinedUsers: []));
                  print(event);
                },
                child: const Text('Create Event')),
            FilledButton(
                onPressed: () async {
                  print(await EventProvider().getEvents());
                },
                child: const Text('get events')),
            FilledButton(
                onPressed: () async {
                  print(await EventProvider().getEventById('eventId_test'));
                },
                child: const Text('get event by id'))
          ],
        ),
      ),
    );
  }
}
