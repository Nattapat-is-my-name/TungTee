import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
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
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create account!",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text("Register to get started."),
                      ),
                      const SizedBox(height: 20),
                      const InputForm(),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Expanded(
                              child: Divider(
                            height: 1.2,
                            thickness: 2,
                          )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 8),
                              child: const Text('Or Connect Via')),
                          const Expanded(
                              child: Divider(
                            height: 1.2,
                            thickness: 2,
                          )),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () async {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: const BorderSide(
                                          color: rawPrimaryColor))),
                              elevation: MaterialStateProperty.all(0)),
                          icon: Image.asset('assets/images/google.png',
                              height: 21, width: 21),
                          label: const Text('Google',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
