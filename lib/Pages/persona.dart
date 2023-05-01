import 'package:flutter/material.dart';

class Persona extends StatelessWidget {
  const Persona({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Interests",
                style: TextStyle(fontSize: 47, fontWeight: FontWeight.w500),
              ),
              Myform(),
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
    return Form(
        child: Column(
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(103, 80, 164, 0.1),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Interest(title: "🏈 Soccer"),
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
                    Interest(title: "🎾 Tennis")
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
                    Interest(title: "👨🏻‍🎤 Hip-hop"),
                    Interest(title: "🎵 Jazz")
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🏖️ Beaches"),
                    Interest(title: "⛰️ Moutains"),
                    Interest(title: "🌆 City sightseeing"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🌍 International destination"),
                    Interest(title: "🛣️ Road trips"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Interest(title: "🍿 Movies"),
                    Interest(title: "📺 TV shows"),
                    Interest(title: "🎮 Video games"),
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
    ));
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
            margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: Text(widget.title),
          ),
        )
      ],
    );
  }
}
