import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';

class Message extends StatelessWidget {
  const Message({this.isOwnMessage = false, required this.message});

  final bool isOwnMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FractionallySizedBox(
      widthFactor: 0.8, // กำหนดความกว้างเป็น 80%
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor.shade900,
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
