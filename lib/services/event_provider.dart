import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Services/user_provider.dart';

class EventProvider {
  final _eventCollection = FirebaseFirestore.instance
      .collection("Events"); // use _ to hide value from outside

  /// Take `EventModel` as argument to add to Firestore database
  ///
  /// return `EventModel` that successfully added to Firestore database
  Future<void> createEvent(EventModel event) async {
    await _eventCollection.doc(event.eventId).set(event.toJSON());
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
  Future<void> updateEventTitle(String eventId, String eventTitle) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'eventTitle': eventTitle});
  }

  /// Update event's description, it takes `eventId` and new `eventDescription`
  Future<void> updateEventDescription(
      String eventId, String eventDesription) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'eventDescription': eventDesription});
  }

  /// Update event's maximum people , it takes `eventId` and new `maximumPeople`
  Future<void> updateEventMaximumPeople(
      String eventId, int maximumPeople) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'maximumPeople': maximumPeople});
  }

  /// Update event's tag, it takes `eventId` and new `tag`
  Future<void> updateEventTag(String eventId, String tag) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'tag': tag});
  }

  /// Update event's minimum age, it takes `eventId` and new `minimumAge`
  Future<void> updateEventMinimumAge(String eventId, int minimumAge) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'ageRestriction.minimumAge': minimumAge});
  }

  /// Update event's maximum age, it takes `eventId` and new `maximumAge`
  Future<void> updateEventMaximumAge(String eventId, int maximumAge) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'ageRestriction.maximumAge': maximumAge});
  }

  /// Update event's start date, it takes `eventId` and new `startDate`
  Future<void> updateEventStartDate(String eventId, DateTime startDate) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'dateOfEvent.start': startDate.toIso8601String()});
  }

  /// Update event's end date, it takes `eventId` and new `endDate`
  Future<void> updateEventEndDate(String eventId, DateTime endDate) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({'dateOfEvent.end': endDate.toIso8601String()});
  }

  /// Update event's location, it takes `eventId` and new `location`
  Future<void> updateEventLocation(
      String eventId, LocationModel location) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({
      'location.latitude': location.latitude,
      'location.longitude': location.longitude
    });
  }

  /// Remove event's images, it takes `eventId` and `index` of image to remove
  Future<void> removeImageFromEvent(String eventId, String image) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({
      'images': FieldValue.arrayRemove([image])
    });
  }

  /// Add event's images, it takes `eventId` and new `image` (type: `Base64` String)
  Future<void> addImageToEvent(String eventId, String image) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);
    await docRef.update({
      'images': FieldValue.arrayUnion([image])
    });
  }

  /// Add event's user, it takes `eventId` and new `userId`
  Future<void> addUserToEvent(String eventId, String userId) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);

    await docRef.update({
      'joinedUsers': FieldValue.arrayUnion([userId])
    });

    await UserProvider().joinEvent(eventId, userId);
  }

  /// Remove event's user, it takes `eventId` and `index` of user to remove
  Future<void> removeUserFromEvent(String eventId, String userId) async {
    final DocumentReference docRef = _eventCollection.doc(eventId);

    await docRef.update({
      'joinedUsers': FieldValue.arrayRemove([userId])
    });

    await UserProvider().leftEvent(eventId, userId);
  }

  /// delete event by `eventId` (String)
  Future<void> deleteEventById(String eventId) async {
    await _eventCollection.doc(eventId).delete();
  }

  Future<bool> isJoinedEvent(String eventId, String userId) async {
    final EventModel event = await getEventById(eventId);
    int isFound = event.joinedUsers.indexOf(userId);
    return isFound != -1;
  }

  Future<bool> isEventOwner(String eventId, String userId) async {
    final EventModel event = await getEventById(eventId);
    return userId == event.ownerId;
  }

  /// *NO LONGER USE BUT DON'T DELETE*
  /// Update event's image, it takes `eventId` and new `image` (type: `Base64` String)
  // Future<void> updateEventImage(String eventId, String image) async {
  //   final DocumentReference docRef = _eventCollection.doc(eventId);
  //   await docRef.update({'image': image});
  // }

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
}
