import 'package:flutter/material.dart';
import 'package:tungtee/Constants/event_interests.dart';

class DynamicChip extends StatefulWidget {
  const DynamicChip(
      {super.key, required this.handleTagSelect, required this.selectedTags});
  final void Function(String) handleTagSelect;
  final List<String> selectedTags;

  @override
  State<DynamicChip> createState() => _DynamicChipState();
}

class _DynamicChipState extends State<DynamicChip> {
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
            selected: widget.selectedTags.contains(interest),
            onSelected: (bool? value) {
              widget.handleTagSelect(interest);
            },
            backgroundColor: const Color.fromRGBO(246, 237, 255, 1),
            shape: const StadiumBorder(),
            side: widget.selectedTags.contains(interest)
                ? const BorderSide(
                    width: 1.0, color: Color.fromRGBO(103, 80, 164, 1))
                : BorderSide.none,
          );
        }).toList(),
      ),
    );
  }
}
