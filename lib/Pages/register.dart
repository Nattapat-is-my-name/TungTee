import 'package:flutter/material.dart';
import 'package:tungtee/Widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Create account!",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("Register to get started."),
                      ),
                      SizedBox(height: 10),
                      InputForm(),
                      SizedBox(height: 10),
                      Center(
                          child: Text("Or Connect Via",
                              style: TextStyle(
                                color: Colors.grey,
                              ))),
                      Google(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class Google extends StatelessWidget {
  const Google({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SizedBox(
          height: 35,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.purple)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png', //รอเอารูปจากของ boss มาใช้เลย
                    fit: BoxFit.cover),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Google',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
