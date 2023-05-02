import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';

class EventProvider {
  final _eventCollection = FirebaseFirestore.instance
      .collection("Events"); // use _ to hide value from outside

  Future<EventModel> createEvent(EventModel event) async {
    final DocumentReference docRef = await _eventCollection.add(event.toJSON());
    final DocumentSnapshot docSnap = await docRef.get();
    return EventModel.fromJSON(docSnap.data() as Map<String, dynamic>);
  }

  Future<List<EventModel>> getEvents() async {
    final QuerySnapshot querySnapshot = await _eventCollection.get();
    final List<EventModel> events = querySnapshot.docs
        .map((docSnap) =>
            EventModel.fromJSON(docSnap.data() as Map<String, dynamic>))
        .toList();
    return events;
  }

  Future<List<EventModel>> getEventsByInterests(List<String> interests) async {
    final QuerySnapshot querySnapshot =
        await _eventCollection.where('tags', arrayContainsAny: interests).get();
    final List<EventModel> events = querySnapshot.docs
        .map((docSnap) =>
            EventModel.fromJSON(docSnap.data() as Map<String, dynamic>))
        .toList();
    return events;
  }

  Future<EventModel> getEventById(String eventId) async {
    final QuerySnapshot querySnapshot =
        await _eventCollection.where('eventId', isEqualTo: eventId).get();
    return EventModel.fromJSON(
        querySnapshot.docs.first.data() as Map<String, dynamic>);
  }

  Future<void> deleteEventById(String eventId) async {
    _eventCollection.doc(eventId).delete();
  }
}
