import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/event_provider.dart';

class UserProvider {
  final _userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(UserModel user) async {
    await _userCollection.doc(user.userId).set(user.toJSON());
  }

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
