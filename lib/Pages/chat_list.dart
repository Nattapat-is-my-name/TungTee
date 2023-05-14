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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Form(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search Chat',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20, right: 10),
                        child: Icon(Icons.search, size: 28),
                      ),
                      filled: true,
                      fillColor: primaryColor.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(999)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Divider(
              indent: 64,
              endIndent: 64,
              height: 1.2,
              thickness: 1.5,
            ),
            const SizedBox(height: 28),
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
