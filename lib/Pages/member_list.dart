import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Services/chat_provider.dart';
import 'package:tungtee/Services/event_provider.dart';
import 'package:tungtee/Services/user_provider.dart';

class MemberList extends StatefulWidget {
  const MemberList({super.key, required this.event});

  final Map<String, dynamic> event;

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  List<UserModel?>? users;
  final userData = [
    {
      'name': 'john doe',
      'age_sex': 'male, 18',
      'image':
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg'
    },
    {
      'name': 'john doe',
      'age_sex': 'male, 18',
      'image':
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg'
    },
    {
      'name': 'john doe',
      'age_sex': 'male, 18',
      'image':
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg'
    },
    {
      'name': 'john doe',
      'age_sex': 'male, 18',
      'image':
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg'
    },
  ];

  @override
  void initState() {
    super.initState();
    ChatProvider()
        .getChatMembers('60566c7a-5e94-49ef-9a5f-f2973f30277b')
        .then((value) {
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
        title: Text(widget.event['title']),
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
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png')),
                          title: Text(
                            '${users!.elementAt(index)!.fullname} ${users!.elementAt(index)!.userId == '2cc7e547-8b7b-4966-96cc-7fc3036f7e0f' ? "(👑 Owner)" : ""}',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                              '${(DateTime.now().year) - (users!.elementAt(index)!.birthDate.year)}, ${users!.elementAt(index)!.gender}'),
                          trailing: users!.elementAt(index)!.userId !=
                                  '2cc7e547-8b7b-4966-96cc-7fc3036f7e0f'
                              ? IconButton(
                                  onPressed: () async {
                                    UserProvider().leftEvent(
                                        '60566c7a-5e94-49ef-9a5f-f2973f30277b',
                                        users!.elementAt(index)!.userId);
                                    EventProvider().removeUserFromEvent(
                                        '60566c7a-5e94-49ef-9a5f-f2973f30277b',
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
