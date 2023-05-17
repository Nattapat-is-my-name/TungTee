import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tungtee/Constants/colors.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.icons, required this.label});
  final IconData icons;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: primaryColor.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
        label: Row(
          children: [
            Icon(icons, color: Colors.white),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}
