import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tungtee/Constants/colors.dart';

import '../Provider/persona_provider.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
        var provider = Provider.of<PersonaProvider>(context, listen: false);
        if (_selected) {
          provider.addPersona(widget.title);
        } else {
          provider.deletePersona(widget.title);
        }
      },
      child: Chip(
          backgroundColor: primaryColor.shade100,
          side: BorderSide(
            color: (_selected) ? primaryColor.shade900 : Colors.transparent,
          ),
          label: Text(widget.title)),
    );
  }
}
