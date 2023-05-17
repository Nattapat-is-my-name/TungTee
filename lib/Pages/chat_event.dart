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
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChatRoom(
      event: widget.event,
      messageController: messageController,
    );
  }
}

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    super.key,
    required this.event,
    required this.messageController,
  });
  final EventModel event;
  final TextEditingController messageController;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _chatMessageFormKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

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
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: <Widget>[
              Expanded(
                child: chatMessages(),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    color: const Color(0xFFFFFBFE),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 16),
                        Expanded(
                          child: Form(
                            key: _chatMessageFormKey,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: widget.messageController,
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
                            if (widget.messageController.text.isNotEmpty) {
                              await ChatProvider().createMessage(
                                widget.event.eventId,
                                FirebaseAuth.instance.currentUser!.uid,
                                widget.messageController.text,
                              );
                              widget.messageController.clear();
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

          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToBottom();
          });
          return ListView.builder(
            controller: _scrollController,
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
