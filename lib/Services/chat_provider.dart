import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tungtee/Models/chat_model.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Services/user_provider.dart';

class ChatProvider {
  final _chatCollection = FirebaseFirestore.instance.collection('Chats');

  Future<List<UserModel?>> getChatMembers(String eventId) async {
    final event = await EventProvider().getEventById(eventId);
    final futures = event.joinedUsers.map((userId) {
      return UserProvider().getUserById(userId);
    });

    final users = await Future.wait(futures);
    return users;
  }

  Future<ChatRoomModel> getChatMessage(String eventId) async {
    final DocumentReference docRef = _chatCollection.doc(eventId);
    final DocumentSnapshot docSnap = await docRef.get();
    return ChatRoomModel.fromJSON(docSnap.data() as Map<String, dynamic>);
  }

  Future<void> createMessage(
      String eventId, String userId, String message) async {
    final DocumentReference docRef = _chatCollection.doc(eventId);
    final chatMessage = ChatMessageModel(
      dateSend: DateTime.now(),
      message: message,
      userId: userId,
      images: [],
    );
    docRef.update({
      'chatMessages': FieldValue.arrayUnion([chatMessage.toJSON()])
    });
  }

  Future<void> initChatRoom(
      String eventId, int maximumPeople, List<String> joinedUsers) async {
    final chatRoom = ChatRoomModel(
        eventId: eventId,
        maximumPeople: maximumPeople,
        joinedUsers: joinedUsers,
        chatMessages: []);
    await _chatCollection.doc(eventId).set(chatRoom.toJSON());
  }

  Future<void> deleteChatRoom(String eventId) async {
    await _chatCollection.doc(eventId).delete();
  }

  Future<void> userLeftEvent(String eventId, String userId) async {
    final DocumentReference docRef = _chatCollection.doc(eventId);
    await docRef.update({
      'joinedEvents': FieldValue.arrayRemove([userId])
    });
  }

  Future<void> userJoinEvent(String eventId, String userId) async {
    final DocumentReference docRef = _chatCollection.doc(eventId);
    await docRef.update({
      'joinedEvents': FieldValue.arrayUnion([userId])
    });
  }
}
