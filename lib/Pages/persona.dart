import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Models/persona_model.dart';
import 'package:tungtee/Provider/persona_provider.dart';

class PersonaPage extends StatelessWidget {
  const PersonaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Interests",
                style: TextStyle(fontSize: 47, fontWeight: FontWeight.w500),
              ),
              Myform(),
              MyButton()
            ],
          ),
        ),
      ),
    );
  }
}

class Myform extends StatefulWidget {
  const Myform({super.key});

  @override
  State<Myform> createState() => _MyformState();
}

class _MyformState extends State<Myform> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Column(
              children: [
                Row(
                  children: const [
                    Interest(title: "🎾 Tennis"),
                    Interest(title: "🏀 Basketball"),
                    Interest(title: "⚽️ Football")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🏋🏻 Body weight"),
                    Interest(title: "🏐 VolleyBall"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🎨 Painting"),
                    Interest(title: "✏️ Drawing"),
                    Interest(title: "✍🏻 Writing")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🎤 Pop"),
                    Interest(title: "🎸 Rock"),
                    Interest(title: "🎵 Jazz"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🏖️ Beaches"),
                    Interest(title: "⛰️ Moutains"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🛣️ Road trips"),
                    Interest(title: "🎮 Video games"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🍿 Movies"),
                    Interest(title: "📺 TV shows"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🎭 Stand-up comedy"),
                    Interest(title: "🎯 Board games"),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}

class Interest extends StatefulWidget {
  const Interest({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  //state
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selected = !_selected;
            });
            PersonaModel result = PersonaModel(title: widget.title);

            var provider = Provider.of<PersonaProvider>(context, listen: false);
            if (_selected) {
              provider.addPersona(result);
            } else {
              provider.deletePersona(result.title);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(103, 80, 164, 0.1),
                border: Border.all(
                    color: _selected
                        ? const Color.fromRGBO(103, 80, 164, 1)
                        : Colors.transparent)),
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Text(widget.title),
          ),
        )
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor.shade900,
            fixedSize: const Size(1000, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
