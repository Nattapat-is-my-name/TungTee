import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.toptitle,
    required this.amountPerson,
    required this.maxPerson,
  });

  final String title;
  final String subtitle;
  final String toptitle;
  final String amountPerson;
  final String maxPerson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getDateString(toptitle),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            color: Colors.black54),
                      ),
                      Wrap(children: [
                        const Icon(
                          Icons.person,
                          size: 15,
                          color: Colors.black54,
                        ),
                        Text(
                          maxLines: 2,
                          "$amountPerson" "/" "$maxPerson",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.black54),
                        ),
                      ]),
                    ],
                  ),
                ),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff1c1b1f),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardLayout extends StatelessWidget {
  const CardLayout({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.toptitle,
    required this.amountPerson,
    required this.maxPerson,
  });

  final String thumbnail;
  final String title;
  final String subtitle;
  final String toptitle;
  final String amountPerson;
  final String maxPerson;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              child: CardDetail(
                toptitle: toptitle,
                title: title,
                subtitle: subtitle,
                amountPerson: amountPerson,
                maxPerson: maxPerson,
              ),
            ),
            AspectRatio(
              aspectRatio: 1.1,
              child: Image.memory(
                base64Decode(thumbnail),
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getDateString(String value) {
  return DateFormat("E dd/MM/yy")
      .format(DateFormat("yyyy-MM-dd hh:mm").parse(value));
}
