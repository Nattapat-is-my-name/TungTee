import 'package:flutter/material.dart';
import 'package:tungtee/Constants/event_interests.dart';

class DynamicChip extends StatefulWidget {
  const DynamicChip({super.key});

  @override
  State<DynamicChip> createState() => _DynamicChipState();
}

class _DynamicChipState extends State<DynamicChip> {
  final List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Wrap(
        spacing: 8.0,
        children: interests.map((interest) {
          return FilterChip(
            showCheckmark: false,
            label: Text(interest),
            selected: selectedInterests.contains(interest),
            onSelected: (bool? value) {
              setState(() {
                if (selectedInterests.contains(interest)) {
                  selectedInterests.remove(interest);
                } else {
                  selectedInterests.add(interest);
                }
              });
            },
            backgroundColor: const Color.fromRGBO(246, 237, 255, 1),
            shape: const StadiumBorder(),
            side: selectedInterests.contains(interest)
                ? const BorderSide(
                    width: 1.0, color: Color.fromRGBO(103, 80, 164, 1))
                : BorderSide.none,
          );
        }).toList(),
      ),
    );
  }
}
