import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';

class EventProvider {
  final _eventCollection = FirebaseFirestore.instance
      .collection("Events"); // use _ to hide value from outside

  /// Take `EventModel` as argument to add to Firestore database
  ///
  /// return `EventModel` that successfully added to Firestore database
  Future<EventModel> createEvent(EventModel event) async {
    final DocumentReference docRef = await _eventCollection.add(event.toJSON());
    final DocumentSnapshot docSnap = await docRef.get();
    return EventModel.fromJSON(docSnap.data() as Map<String, dynamic>);
  }

  /// return `List<EventModel>` from Firestore database
  Future<List<EventModel>> getEvents() async {
    final QuerySnapshot querySnapshot = await _eventCollection.get();
    final List<EventModel> events = querySnapshot.docs
        .map((docSnap) =>
            EventModel.fromJSON(docSnap.data() as Map<String, dynamic>))
        .toList();
    return events;
  }

  /// Get list of `EventModel` that its `tags` field contain any of `interests` (List<String>) argument
  ///
  /// return `List<EventModel>` from Firestore database
  Future<List<EventModel>> getEventsByInterests(List<String> interests) async {
    final QuerySnapshot querySnapshot =
        await _eventCollection.where('tags', arrayContainsAny: interests).get();
    final List<EventModel> events = querySnapshot.docs
        .map((docSnap) =>
            EventModel.fromJSON(docSnap.data() as Map<String, dynamic>))
        .toList();
    return events;
  }

  /// return `EventModel` that match its `eventId` field with `eventId` (String) argument
  Future<EventModel> getEventById(String eventId) async {
    final QuerySnapshot querySnapshot =
        await _eventCollection.where('eventId', isEqualTo: eventId).get();
    return EventModel.fromJSON(
        querySnapshot.docs.first.data() as Map<String, dynamic>);
  }

  /// delete event by `eventId` (String)
  Future<void> deleteEventById(String eventId) async {
    _eventCollection.doc(eventId).delete();
  }
}
