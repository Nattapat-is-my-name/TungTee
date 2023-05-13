import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/chat_model.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Pages/member_list.dart';
import 'package:tungtee/Services/chat_provider.dart';
import 'package:tungtee/Widgets/message.dart';

class ChatEvent extends StatefulWidget {
  ChatEvent({super.key, required this.event});
  final EventModel event;

  @override
  State<ChatEvent> createState() => _ChatEventState();
}

class _ChatEventState extends State<ChatEvent> {
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
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 1, color: Colors.grey.shade400),
                          vertical: BorderSide.none),
                      color: const Color(0xFFFFFBFE),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt, color: primaryColor),
                        ),
                        Expanded(
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
                                    borderRadius: BorderRadius.circular(999))),
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
    return FutureBuilder(
      future: ChatProvider().getChatMessage(widget.event.eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          final chat = snapshot.data;
          return ListView.builder(
            itemCount: chat!.chatMessages.length,
            itemBuilder: (context, index) {
              final message = chat.chatMessages.elementAt(index);
              bool nextMessageHasSameOwner = false;
              // DateTime nxtMsgDate = message.dateSend;
              // DateTime nowMsgDate = message.dateSend;
              // DateTime prvMsgDate = message.dateSend;

              if (index - 1 >= 0) {
                nextMessageHasSameOwner = message.userId ==
                    chat.chatMessages.elementAt(index - 1).userId;
                // prvMsgDate = chat.chatMessages.elementAt(index - 1).dateSend;
              }

              return renderMsgWithOutDateDivider(
                  message, nextMessageHasSameOwner);

              // if (index + 1 < chat.chatMessages.length) {
              //   nxtMsgDate = chat.chatMessages.elementAt(index + 1).dateSend;
              //   bool isShowDateDivider =
              //       nowMsgDate.difference(nxtMsgDate).inHours <= -1;

              //   bool isSameMonth = nowMsgDate.year == nxtMsgDate.year &&
              //       nowMsgDate.month == nxtMsgDate.month;

              //   bool isSameWeek =
              //       isSameMonth && nowMsgDate.day - nxtMsgDate.day < 7;

              //   bool isSameDate =
              //       isSameMonth && nowMsgDate.day == nxtMsgDate.day;

              //   bool isSameHour =
              //       isSameDate && nowMsgDate.hour - nxtMsgDate.hour <= 1;

              // }
            },
          );
        }
        return Container();
      },
    );
  }

  String getDateDivider(DateTime nxtMsg) {
    return '';
  }

  String getWeekDay(int d) {
    switch (d) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Day of week not exist';
    }
  }

  Widget renderMsgWithOutDateDivider(
      ChatMessageModel message, bool nextMessageHasSameOwner) {
    return Message(
      message: message,
      nextMessageHasSameOwner: nextMessageHasSameOwner,
      isShowDateDivider: false,
    );
  }

  // Message with Date divider
  Widget renderMsgWithDateDivider(
      ChatMessageModel message, bool nextMessageHasSameOwner) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          child: Center(
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                // child: Text(getTimeDivider(prvMsgSendDate,
                //     message.dateSend, timeBtwMsg))),
                child: const Text('test')),
          ),
        ),
        Message(
          message: message,
          nextMessageHasSameOwner: nextMessageHasSameOwner,
          isShowDateDivider: true,
        ),
      ],
    );
  }
}
