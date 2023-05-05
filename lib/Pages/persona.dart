import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Pages/home.dart';
import 'package:tungtee/Pages/welcome.dart';
import 'package:tungtee/Widgets/interest.dart';

class PersonaPage extends StatelessWidget {
  const PersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                "Interests",
                style: TextStyle(fontSize: 47, fontWeight: FontWeight.w500),
              ),
              MyList(),
              MyButton()
            ],
          ),
        ),
      ),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: const [
        Interest(title: "⚽️ Sport"),
        Interest(title: "🎵 Music"),
        Interest(title: "🎨 Drawing"),
        Interest(title: "🛒 Shopping"),
        Interest(title: "🎯 Board games"),
        Interest(title: "🛣️ Traveling"),
        Interest(title: "🏋🏻 Excersice"),
        Interest(title: "🏋🏻 Party"),
        Interest(title: "🍳 Cooking"),
        Interest(title: "📚 Reading"),
        Interest(title: "🎤 Singing"),
        Interest(title: "🎤 Gardening"),
        Interest(title: "🍿 Movies"),
        Interest(title: "🎣  Fishing"),
        Interest(title: "📷  Photography"),
        Interest(title: "🎮  Video games"),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor.shade900,
            fixedSize: const Size(1000, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: const Text(
          'Done',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
