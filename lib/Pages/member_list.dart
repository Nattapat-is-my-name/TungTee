import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';

class MemberList extends StatelessWidget {
  MemberList({super.key, required this.event});

  final Map<String, dynamic> event;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(event['title']),
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
              child: ListView.separated(
                itemCount: event.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 80,
                        child: Image.network(
                            fit: BoxFit.cover, userData[index]['image']!)),
                    title: Text(
                      userData[index]['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      userData[index]['age_sex']!,
                    ),
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
    );
  }
}
