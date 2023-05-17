import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/chat_model.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
    required this.nextMessageHasSameOwner,
    required this.isShowDateDivider,
  });

  final ChatMessageModel message;
  final bool nextMessageHasSameOwner;
  final bool isShowDateDivider;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final isMe = user.uid == message.userId; // !DONT FORGET TO REMOVE !
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        renderMsgWithProfile(
            isMe, nextMessageHasSameOwner, user, isShowDateDivider),
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1.15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMe
                      ? 12
                      : !nextMessageHasSameOwner || isShowDateDivider
                          ? 2
                          : 12),
                  topRight: Radius.circular(isMe
                      ? !nextMessageHasSameOwner || isShowDateDivider
                          ? 2
                          : 12
                      : 12),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
                color: isMe
                    ? primaryColor.shade900
                    : const Color.fromARGB(255, 228, 226, 226),
              ),
              child: Text(
                message.message,
                softWrap: true,
                style: TextStyle(
                    fontSize: 14, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderMsgWithProfile(bool isMe, bool nextMessageHasSameOwner,
      User user, bool isShowDateDivider) {
    if (!isMe && (!nextMessageHasSameOwner || isShowDateDivider)) {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.only(left: 44), // (2 * radius) + padding
    );
  }
}
