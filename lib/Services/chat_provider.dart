import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Services/user_provider.dart';

class ChatProvider {
  final _chatCollection = FirebaseFirestore.instance.collection('Chats');

  getChatMembers(String eventId) async {
    final event = await EventProvider().getEventById(eventId);
    final futures = event.joinedUsers.map((userId) {
      return UserProvider().getUserById(userId);
    });

    final users = await Future.wait(futures);
    return users;
  }
}
