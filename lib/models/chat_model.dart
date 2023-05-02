class ChatRoomModel {
  final String eventId;
  final int maximumPeople; // same data in the EventModel
  final List<String> joinedUsers;
  final List<ChatMessageModel> chatMessages;

  ChatRoomModel({
    required this.eventId,
    required this.maximumPeople,
    required this.joinedUsers,
    required this.chatMessages,
  });

  Map<String, dynamic> toJSON() {
    return {
      'eventId': eventId,
      'maximumPeople': maximumPeople,
      'joinedUsers': joinedUsers,
      'chatMessages': chatMessages.map((message) => message.toJSON()).toList(),
    };
  }
}

class ChatMessageModel {
  final String userId;
  final DateTime dateSend;
  final String message;
  final List<String>? images; // images are optional

  ChatMessageModel({
    required this.userId,
    required this.dateSend,
    required this.message,
    required this.images,
  });

  Map<String, dynamic> toJSON() {
    return {
      'userId': userId,
      'dateSend': dateSend.toIso8601String(),
      'message': message,
      'images': images,
    };
  }
}
