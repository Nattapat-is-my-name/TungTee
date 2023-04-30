import 'package:flutter/material.dart';

class BasicInformationPage extends StatelessWidget {
  const BasicInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Enter your basic information",
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Please fill your basic account information so that we know who you are"),
                Form(),
                SizedBox(height: 10,),
                Button(),
              ],
            ),
          )
      ),
    );
  }
}

class Form extends StatelessWidget {
  const Form({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Material(
      child: Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Nickname",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(),
                      ),
                    ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  flex: 6,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                ),
              ],
            ),
          ),
      ],
    ),
    ),);
  }
}

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SizedBox(
        width: 200,
        height: 35,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Next'),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}