import 'package:flutter/material.dart';

class dynamicChip extends StatefulWidget {
  const dynamicChip({super.key});

  @override
  State<dynamicChip> createState() => _dynamicChipState();
}

class _dynamicChipState extends State<dynamicChip> {
  final List<String> _filters = <String>[];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Wrap(
        spacing: 8.0,
        children: _Hobby.map((_Hobby) {
          return FilterChip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            label: Text(_Hobby),
            selected: _filters.contains(_Hobby),
            selectedColor: Colors.deepPurple[100],
            showCheckmark: false,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  if (!_filters.contains(_Hobby)) {
                    _filters.add(_Hobby);
                  }
                } else {
                  _filters.removeWhere((String name) {
                    return name == _Hobby;
                  });
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
