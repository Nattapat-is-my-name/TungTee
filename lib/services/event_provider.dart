import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:uuid/uuid.dart';

class EventProvider {
  final _eventCollection = FirebaseFirestore.instance
      .collection("Events"); // use _ to hide value from outside

  /// Take `EventModel` as argument to add to Firestore database
  ///
  /// return `EventModel` that successfully added to Firestore database
  Future<void> createEvent(EventModel event) async {
    final String documentId = const Uuid().v4();
    await _eventCollection.doc(documentId).set(event.toJSON());
  }

  /// return all events (type: `List<EventModel>`) from Firestore database
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
  /// return all events (type: `List<EventModel>`) from Firestore database that matched with interests
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
    final DocumentReference docRef = _eventCollection.doc(eventId);
    final DocumentSnapshot docSnap = await docRef.get();
    return EventModel.fromJSON(docSnap.data() as Map<String, dynamic>);
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
  void updateEventTitle(String eventId, String eventTitle) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'eventTitle': eventTitle});
  }

  /// Update event's description, it takes `eventId` and new `eventDescription`
  void updateEventDescription(String eventId, String eventDesription) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'eventDescription': eventDesription});
  }

  /// Update event's maximum people , it takes `eventId` and new `maximumPeople`
  void updateEventMaximumPeople(String eventId, int maximumPeople) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'maximumPeople': maximumPeople});
  }

  /// Update event's tag, it takes `eventId` and new `tag`
  void updateEventTag(String eventId, String tag) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'tag': tag});
  }

  /// *USE updateEventTag() instead*
  /// *NO LONGER USE BUT DON'T DELETE*
  /// Add event's tags, it takes `eventId` and new `tag`
  // Future<void> addEventTag(String eventId, String tag) async {
  //   final DocumentReference docRef = _eventCollection.doc(eventId);

  //   final List<String> tags = await getEventTags(eventId);
  //   tags.add(tag);

  //   docRef.set({'tags': tags}, SetOptions(merge: true));
  // }

  /// *USE updateEventTag() instead*
  /// *NO LONGER USE BUT DON'T DELETE*
  /// Remove event's tags, it takes `eventId` and `index` of tag to remove
  // Future<void> removeEventTagByIndex(String eventId, int index) async {
  //   final DocumentReference docRef = _eventCollection.doc(eventId);

  //   final List<String> tags = await getEventTags(eventId);
  //   tags.removeAt(index);

  //   docRef.set({'tags': tags}, SetOptions(merge: true));
  // }

  /// Update event's minimum age, it takes `eventId` and new `minimumAge`
  void updateEventMinimumAge(String eventId, int minimumAge) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'ageRestriction.minimumAge': minimumAge});
  }

  /// Update event's maximum age, it takes `eventId` and new `maximumAge`
  void updateEventMaximumAge(String eventId, int maximumAge) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'ageRestriction.maximumAge': maximumAge});
  }

  /// Update event's start date, it takes `eventId` and new `startDate`
  void updateEventStartDate(String eventId, DateTime startDate) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'dateOfEvent.start': startDate.toIso8601String()});
  }

  /// Update event's end date, it takes `eventId` and new `endDate`
  void updateEventEndDate(String eventId, DateTime endDate) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'dateOfEvent.end': endDate.toIso8601String()});
  }

  /// Update event's location, it takes `eventId` and new `location`
  void updateEventLocation(String eventId, LocationModel location) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({
      'location.latitude': location.latitude,
      'location.longitude': location.longitude
    });
  }

  /// Update event's image, it takes `eventId` and new `image` (type: `Base64` String)
  void updateEventImage(String eventId, String image) {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    docRef.update({'image': image});
  }

  /// *USE updateEventImage() instead*
  /// *NO LONGER USE BUT DON'T DELETE*
  /// Remove event's images, it takes `eventId` and `index` of image to remove
  // Future<void> removeEventImageByIndex(String eventId, int index) async {
  //   final DocumentReference docRef = _eventCollection.doc(eventId);

  //   final List<String> images = await getEventImages(eventId);
  //   images.removeAt(index);

  //   docRef.update({'images': images});
  // }

  /// *USE updateEventImage() instead*
  /// *NO LONGER USE BUT DON'T DELETE*
  /// Add event's images, it takes `eventId` and new `image` (type: `Base64` String)
  // Future<void> addImageToEvent(String eventId, String image) async {
  //   final DocumentReference docRef = _eventCollection.doc(eventId);

  //   final List<String> images = await getEventImages(eventId);
  //   images.add(image);

  //   docRef.update({'images': images});
  // }

  /// Add event's user, it takes `eventId` and new `userId`
  void addUserToEvent(String eventId, String userId) {
    final DocumentReference docRef = _eventCollection.doc(eventId);

    docRef.update({
      'joinedUsers': FieldValue.arrayUnion([userId])
    });
  }

  /// Remove event's user, it takes `eventId` and `index` of user to remove
  void removeUserFromEvent(String eventId, String userId) {
    final DocumentReference docRef = _eventCollection.doc(eventId);

    docRef.update({
      'joinedUsers': FieldValue.arrayRemove([userId])
    });
  }

  /// delete event by `eventId` (String)
  void deleteEventById(String eventId) {
    _eventCollection.doc(eventId).delete();
  }

  /// *NO LONGER USE BUT DON'T DELETE*
  /// Get tags from event, take `eventId` as an argument
  ///
  /// return tags (type: `List<String>`) which is a list of tag strings
  // Future<List<String>> getEventTags(String eventId) async {
  //   final EventModel event = await getEventById(eventId);
  //   return event.tags;
  // }

  /// *NO LONGER USE BUT DON'T DELETE*
  /// Get images from event, take `eventId` as an argument
  ///
  /// return tags (type: `List<String>`, String is encoded in `Base64` form) which is a list of image strings
  // Future<List<String>> getEventImages(String eventId) async {
  //   final EventModel event = await getEventById(eventId);
  //   return event.images;
  // }

  /// *NO LONGER USE BUT DON'T DELETE*
  /// Get images from event, take `eventId` as an argument
  ///
  /// return tags (type: `List<String>`) which is a list of `userId` strings
  // Future<List<String>> getJoinedUserInEvent(String eventId) async {
  //   final EventModel event = await getEventById(eventId);
  //   return event.joinedUsers;
  // }
}
