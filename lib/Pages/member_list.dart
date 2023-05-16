import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/chat_provider.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Services/user_provider.dart';

class MemberList extends StatefulWidget {
  const MemberList({super.key, required this.event});

  final EventModel event;

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  List<UserModel?>? users;

  @override
  void initState() {
    super.initState();
    ChatProvider().getChatMembers(widget.event.eventId).then((value) {
      if (value != null) {
        setState(() {
          users = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.event.eventTitle),
      ),
      body: Column(
        children: [
          const Divider(
            indent: 64,
            endIndent: 64,
            height: 1.2,
            thickness: 1.5,
          ),
          const SizedBox(height: 28),
          Expanded(
            child: Scrollbar(
              child: users != null
                  ? ListView.separated(
                      itemCount: users!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SizedBox(
                            height: 100,
                            width: 80,
                            child: FutureBuilder(
                                future: UserProvider().getUserById(
                                    users!.elementAt(index)!.userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final image = snapshot.data?.profileImage;
                                    return image == null || image == ""
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor:
                                                  primaryColor.shade100,
                                              child: const Icon(Icons.person),
                                            ))
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: CircleAvatar(
                                              radius: 18,
                                              backgroundImage:
                                                  image.startsWith('https')
                                                      ? null
                                                      : MemoryImage(
                                                          base64Decode(image)),
                                              child: image.startsWith('https')
                                                  ? Image.network(image)
                                                  : null,
                                            ));
                                  }
                                  return Container();
                                }),
                            // child: Image.network(
                            //     fit: BoxFit.cover,
                            //     'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
                          ),
                          title: Text(
                            '${users!.elementAt(index)!.fullname} ${users!.elementAt(index)!.userId == widget.event.ownerId ? "(👑 Owner)" : ""}',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                              '${(DateTime.now().year) - (users!.elementAt(index)!.birthDate.year)}, ${users!.elementAt(index)!.gender}'),
                          trailing: FirebaseAuth.instance.currentUser!.uid ==
                                      widget.event.ownerId &&
                                  users!.elementAt(index)!.userId !=
                                      widget.event.ownerId
                              ? IconButton(
                                  onPressed: () async {
                                    UserProvider().leftEvent(
                                        widget.event.eventId,
                                        users!.elementAt(index)!.userId);
                                    EventProvider().removeUserFromEvent(
                                        widget.event.eventId,
                                        users!.elementAt(index)!.userId);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromRGBO(103, 80, 164, 1),
                                    size: 24,
                                  ),
                                )
                              : null,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          indent: 16,
                          endIndent: 16,
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
