import 'package:flutter/material.dart';

enum _Hobby {
  walking,
  running,
  cycling,
  hiking,
  food,
  sport,
  eSport,
}

class dynamicChip extends StatefulWidget {
  const dynamicChip({super.key});

  @override
  State<dynamicChip> createState() => _dynamicChipState();
}

class _dynamicChipState extends State<dynamicChip> {
  bool favorite = false;
  final List<String> _filters = <String>[];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Wrap(
        spacing: 5.0,
        children: _Hobby.values.map((_Hobby hobby) {
          return FilterChip(
            avatar: Icon(Icons.abc),
            label: Text(hobby.name),
            selected: _filters.contains(hobby.name),
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  if (!_filters.contains(hobby.name)) {
                    _filters.add(hobby.name);
                  }
                } else {
                  _filters.removeWhere((String name) {
                    return name == hobby.name;
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
