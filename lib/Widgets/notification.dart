import 'package:flutter/material.dart';
import 'package:tungtee/Services/notification_service.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  static const List<String> _days = <String>[
    'Neng joined หมูกระทะ Party',
    'Sora joined OS234 Party',
    'Joe  joined ตี๋น้อย Party',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _days.length,
      itemBuilder: (BuildContext context, index) {
        return Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () {
              NotificationService()
                  .showNotification(title: "neng", body: "neng");
            },
            child: SizedBox(
              height: 80,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://scontent.fbkk13-1.fna.fbcdn.net/v/t39.30808-6/339419775_225868136786641_7265213081379350621_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeH9DbscdvKBlji1_sxzgQ83wh1M2Q1ZAfPCHUzZDVkB8wfyta-y0YC2b6HTyjQ9TTI6si9nzMywMRQnckUeG9dM&_nc_ohc=QlwC5iKU3SgAX83Af7j&_nc_ht=scontent.fbkk13-1.fna&oh=00_AfBChvl6Ojph8lMs3_kad1soafOWhsR4pNu_ZuNURAyyBA&oe=645E4DC1"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(_days[index])
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
