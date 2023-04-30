class ChatRoomModel {
  final String eventId;
  final int maximumPeople; // same data in the EventModel
  final List<String> joinedUsers = [];
  final List<ChatMessageModel> chatMessages = [];

  ChatRoomModel({
    required this.eventId,
    required this.maximumPeople,
  });

  Map<String, dynamic> toJSON() {
    return {
      'event_id': eventId,
      'maximum_people': maximumPeople,
      'joined_users': joinedUsers,
      'chat_messages': chatMessages.map((message) => message.toJSON()).toList(),
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
      'user_id': userId,
      'date_send': dateSend.toIso8601String(),
      'message': message,
      'images': images,
    };
  }
}
