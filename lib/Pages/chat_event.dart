import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/chat_model.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Pages/member_list.dart';
import 'package:tungtee/Services/chat_provider.dart';
import 'package:tungtee/Widgets/message.dart';

class ChatEvent extends StatefulWidget {
  const ChatEvent({super.key, required this.event});
  final EventModel event;

  @override
  State<ChatEvent> createState() => _ChatEventState();
}

class _ChatEventState extends State<ChatEvent> {
  final _chatMessageFormKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  final DateTime noDateSet = DateTime(1111);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemberList(event: widget.event)));
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
        title: Text(widget.event.eventTitle),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: <Widget>[
              chatMessages(),
              Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    color: const Color(0xFFFFFBFE),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt, color: primaryColor),
                        ),
                        Expanded(
                          child: Form(
                            key: _chatMessageFormKey,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: messageController,
                              style: const TextStyle(color: Color(0xFF5B5B5B)),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFECF0F0),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                  hintText: 'Start typing...',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(999))),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (messageController.text.isNotEmpty) {
                              await ChatProvider().createMessage(
                                widget.event.eventId,
                                FirebaseAuth.instance.currentUser!.uid,
                                messageController.text,
                              );
                              setState(() {
                                messageController.text = '';
                              });
                            }

                            if (context.mounted) {
                              FocusScope.of(context).unfocus();
                            }
                          },
                          icon: Icon(Icons.send, color: primaryColor),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: ChatProvider().getChatMessage(widget.event.eventId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final chatRoom = ChatRoomModel.fromJSON(
              snapshot.data!.data() as Map<String, dynamic>);
          return ListView.builder(
            itemCount: chatRoom.chatMessages.length,
            itemBuilder: (context, index) {
              final message = chatRoom.chatMessages.elementAt(index);
              bool nextMessageHasSameOwner = false;

              if (index - 1 >= 0) {
                nextMessageHasSameOwner = message.userId ==
                    chatRoom.chatMessages.elementAt(index - 1).userId;
              }

              return renderMsgWithOutDateDivider(
                  message, nextMessageHasSameOwner);
            },
          );
        }
        return Container();
      },
    );
  }

  Widget renderMsgWithOutDateDivider(
      ChatMessageModel message, bool nextMessageHasSameOwner) {
    return Message(
      message: message,
      nextMessageHasSameOwner: nextMessageHasSameOwner,
      isShowDateDivider: false,
    );
  }
}
