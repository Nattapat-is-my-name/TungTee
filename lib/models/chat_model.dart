class ChatRoomModel {
  final String eventId;
  final int maximumPeople; // same data in the EventModel
  final List<String> joinedUsers = [];
  final List<ChatMessageModel> chatMessages = [];

  ChatRoomModel({
    required this.eventId,
    required this.maximumPeople,
  });
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
}
