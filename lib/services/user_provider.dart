import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Models/user_model.dart';

class UserProvider {
  final _userCollection = FirebaseFirestore.instance.collection('Users');
  final _eventCollection = FirebaseFirestore.instance.collection('Events');

  Future<UserModel> createUser(User user) async {
    final UserModel newUser = UserModel(
      userId: user.uid,
      fullname: user.displayName!,
      nickname: '',
      email: user.email!,
      phone: user.phoneNumber!,
      gender: '',
      birthDate: DateTime.now(),
      interests: [],
      createdEvents: [],
      joinedEvents: [],
      behaviorPoint: 3,
    );
    final DocumentReference docRef =
        await _userCollection.add(newUser.toJSON());
    final DocumentSnapshot docSnap = await docRef.get();
    return UserModel.fromJSON(docSnap.data() as Map<String, dynamic>);
  }

  Future<UserModel> getUserById(String userId) async {
    final QuerySnapshot querySnapshot =
        await _userCollection.where('userId', isEqualTo: userId).get();
    return UserModel.fromJSON(
        querySnapshot.docs.first.data() as Map<String, dynamic>);
  }
}
