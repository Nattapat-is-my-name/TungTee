import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Pages/chat_event.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final chatData = [
    {
      'title': 'หมูกระทะ',
      'lastMessage': 'Let\'s go!',
      'lastMessageDate': 'Yesterday',
      'image': 'https://mpics.mgronline.com/pics/Images/565000005463801.JPEG'
    },
    {
      'title': 'หมูกระทะ',
      'lastMessage': 'Let\'s go!',
      'lastMessageDate': 'Yesterday',
      'image': 'https://images.deliveryhero.io/image/fd-th/LH/ujjl-hero.jpg'
    },
  ];

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
                child: ListView.separated(
                  itemCount: chatData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Text(chatData[index]['lastMessageDate']!),
                      leading: SizedBox(
                          height: 100,
                          width: 80,
                          child: Image.network(
                              fit: BoxFit.cover, chatData[index]['image']!)),
                      title: Text(
                        chatData[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(chatData[index]['lastMessage']!),
                      splashColor: primaryColor.shade50,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatEvent(
                                      event: chatData[index],
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
