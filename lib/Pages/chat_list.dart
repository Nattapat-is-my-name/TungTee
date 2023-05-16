import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Pages/chat_event.dart';
import 'package:tungtee/Services/user_provider.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Scrollbar(
                  child: FutureBuilder(
                future: UserProvider().getJoinedAndCreatedEvents(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final events = snapshot.data;
                    return ListView.separated(
                      itemCount: events!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: const Text('Yesterday'),
                          leading: SizedBox(
                              height: 100,
                              width: 80,
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://mpics.mgronline.com/pics/Images/565000005463801.JPEG')),
                          title: Text(
                            events.elementAt(index).eventTitle,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: const Text('Let\'s go!'),
                          splashColor: primaryColor.shade600,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatEvent(
                                          event: events.elementAt(index),
                                        )));
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          indent: 16,
                          endIndent: 16,
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
