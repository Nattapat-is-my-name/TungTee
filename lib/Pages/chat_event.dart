import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Widgets/message.dart';

class ChatEvent extends StatelessWidget {
  // const ChatEvent({super.key, required this.event});
  ChatEvent({super.key, required this.event});
  final Map<String, dynamic> event;

  // final EventModel event;

  final List<String> messages = [
    'Fire in the hole!',
    'Let\'s eat moo gra ta!',
    'Go go go!',
    'Moving now!',
    'Fire in the hole!',
    'Let\'s eat moo gra ta!',
    'Go go go!',
    'Moving now!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          )
        ],
        title: Text(event['title']),
        centerTitle: true,
      ),
      body: Container(
        color: primaryColor.shade50,
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return Message(message: messages[index]);
          },
        ),
      ),
    );
  }
}
