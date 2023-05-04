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

  /* Updatable field
   * eventTitle
   * eventDescription
   * maximumPeople
   * tags
   * ageRestriction
   * dateOfEvent
   * location
   * images
   * joinedUsers
   * 
   * Q: Why updating each field by separate function?
   * A: It is easier to manage.
   */

  /// Update event's title, it takes `eventId` and new `eventTitle`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventTitle(String eventId, String eventTitle) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventTitle': eventTitle}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's description, it takes `eventId` and new `eventDescription`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventDescription(String eventId, String eventDesription) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventDescription': eventDesription},
        SetOptions(merge: true)).then((_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's maximum people , it takes `eventId` and new `maximumPeople`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventMaximumPeople(String eventId, int maximumPeople) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'maximumPeople': maximumPeople}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  // more work here
  bool addEventTag(String eventId, String tag) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventTitle': tag}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  bool removeEventTag(String eventId, String tag) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventTitle': tag}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's minimum age, it takes `eventId` and new `minimumAge`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventMinimumAge(String eventId, int minimumAge) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'ageRestriction.minimumAge': minimumAge},
        SetOptions(merge: true)).then((_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's maximum age, it takes `eventId` and new `maximumAge`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventMaximumAge(String eventId, int maximumAge) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'ageRestriction.maximumAge': maximumAge},
        SetOptions(merge: true)).then((_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's start date, it takes `eventId` and new `startDate`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventStartDate(String eventId, DateTime startDate) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'dateOfEvent.start': startDate}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's end date, it takes `eventId` and new `endDate`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventEndDate(String eventId, DateTime endDate) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'dateOfEvent.end': endDate}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  /// Update event's location, it takes `eventId` and new `location`
  ///
  /// return `true` if update succeed otherwise `false`
  bool updateEventLocation(String eventId, LocationModel location) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({
      'location.latitude': location.latitude,
      'location.longitude': location.longitude
    }, SetOptions(merge: true)).then((_) => isUpdated = true);
    return isUpdated;
  }

  // need more work
  bool updateEventImages(String eventId, String eventTitle) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventTitle': eventTitle}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  // need more work here
  bool updateEventJoining(String eventId, String userId) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventTitle': userId}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  // need more work here
  bool updateEventLeft(String eventId, String userId) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    bool isUpdated = false;
    docRef.set({'eventTitle': userId}, SetOptions(merge: true)).then(
        (_) => isUpdated = true);
    return isUpdated;
  }

  /// delete event by `eventId` (String)
  void deleteEventById(String eventId) {
    _eventCollection.doc(eventId).delete();
  }

  /// Get tags from event, take `eventId` as an argument
  ///
  /// return tags (type: `List<String>`) which is a list of tag strings
  Future<List<String>> getEventTags(String eventId) async {
    final EventModel event = await getEventById(eventId);
    return event.tags;
  }

  /// Get images from event, take `eventId` as an argument
  ///
  /// return tags (type: `List<String>`, String is encoded in `Base64` form) which is a list of image strings
  Future<List<String>> getEventImages(String eventId) async {
    final EventModel event = await getEventById(eventId);
    return event.images;
  }

  /// Get images from event, take `eventId` as an argument
  ///
  /// return tags (type: `List<String>`) which is a list of `userId` strings
  Future<List<String>> getJoinedUserInEvent(String eventId) async {
    final EventModel event = await getEventById(eventId);
    return event.joinedUsers;
  }
}
