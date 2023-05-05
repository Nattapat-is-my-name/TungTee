import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/event_provider.dart';

class UserProvider {
  final _userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(UserModel user) async {
    await _userCollection.doc(user.userId).set(user.toJSON());
  }

  Future<UserModel?> getUserById(String userId) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    final DocumentSnapshot docSnap = await docRef.get();
    if (docSnap.data() != null) {
      return UserModel.fromJSON(docSnap.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<List<EventModel>?> getJoinedEvents(String userId) async {
    final UserModel? user = await getUserById(userId);
    if (user != null) {
      final List<Future<EventModel>> futures =
          user.joinedEvents.map((String eventId) async {
        return await EventProvider().getEventById(eventId);
      }).toList();
      final List<EventModel> joinedEvents = await Future.wait(futures);
      return joinedEvents;
    }
    return null;
  }

  Future<List<EventModel>?> getCreatedEvents(String userId) async {
    final UserModel? user = await getUserById(userId);
    if (user != null) {
      final List<Future<EventModel>> futures =
          user.createdEvents.map((String eventId) async {
        return await EventProvider().getEventById(eventId);
      }).toList();
      final List<EventModel> createdEvents = await Future.wait(futures);
      return createdEvents;
    }
    return null;
  }

  /* Updatable field
   * fullname
   * nickname
   * email
   * phone
   * gender
   * birth_date
   * interests
   * created_events
   * joined_events
   * behavior_point
   * 
   * Q: Why updating each field by separate function?
   * A: It is easier to manage.
   */

  Future<void> updateUserFullName(String userId, String fullname) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'fullname': fullname});
  }

  Future<void> updateUserNickName(String userId, String nickname) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'nickname': nickname});
  }

  Future<void> updateUserEmail(String userId, String email) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'email': email});
  }

  Future<void> updateUserPhone(String userId, String phone) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'phone': phone});
  }

  Future<void> updateUserGender(String userId, String gender) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'gender': gender});
  }

  Future<void> updateUserBirthDate(String userId, DateTime birthDate) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'birthDate': birthDate.toIso8601String()});
  }

  Future<void> addInterest(String userId, String interest) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({
      'interests': FieldValue.arrayUnion([interest])
    });
  }

  Future<void> removeInterest(String userId, String interest) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({
      'interests': FieldValue.arrayRemove([interest])
    });
  }

  Future<void> joinEvent(String eventId, String userId) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({
      'joinedEvents': FieldValue.arrayUnion([eventId])
    });
  }

  Future<void> leftEvent(String eventId, String userId) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({
      'joinedEvents': FieldValue.arrayRemove([eventId])
    });
  }

  Future<void> reduceBehaviorPoint(String userId) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'behaviorPoint': FieldValue.increment(-1)});
  }

  Future<void> increaseBehaviorPoint(String userId) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'behaviorPoint': FieldValue.increment(1)});
  }

  Future<bool?> isOnPenalty(String userId) async {
    final UserModel? user = await getUserById(userId);
    if (user != null) {
      return user.behaviorPoint <= 0;
    }
    return null;
  }

  Future<void> updateUserProfileImage(String userId, String image) async {
    final DocumentReference docRef = _userCollection.doc(userId);
    await docRef.update({'profileImage': image});
  }

  Future<bool> isUserRegistered(String userId) async {
    final DocumentSnapshot docSnap = await _userCollection.doc(userId).get();
    return docSnap.exists;
  }
}
