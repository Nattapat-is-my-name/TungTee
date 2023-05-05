import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/event_provider.dart';

class UserProvider {
  final _userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(UserModel user) async {
    await _userCollection.doc(user.userId).set(user.toJSON());
  }

  Future<UserModel> getUserById(String userId) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    final DocumentSnapshot docSnap = await docRef.get();
    return UserModel.fromJSON(docSnap.data() as Map<String, dynamic>);
  }

  Future<List<EventModel>> getJoinedEvents(String userId) async {
    final UserModel user = await getUserById(userId);
    final List<Future<EventModel>> futures =
        user.joinedEvents.map((String eventId) async {
      return await EventProvider().getEventById(eventId);
    }).toList();
    final List<EventModel> joinedEvents = await Future.wait(futures);
    return joinedEvents;
  }

  Future<List<EventModel>> getCreatedEvents(String userId) async {
    final UserModel user = await getUserById(userId);
    final List<Future<EventModel>> futures =
        user.createdEvents.map((String eventId) async {
      return await EventProvider().getEventById(eventId);
    }).toList();
    final List<EventModel> createdEvents = await Future.wait(futures);
    return createdEvents;
  }

  }
}
