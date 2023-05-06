import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  String? confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //1
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Name"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: "Name",
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please type your name";
                }
                return null;
              },
            ),
          ),

          //2
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 15),
            child: Text("Email"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  hintText: "E-mail",
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return "Please type your email";
                  }
                  return null;
                }),
          ),

          //3
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 15),
            child: Text("Password"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: hidePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                confirmPassword = value;
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                } else if (value.length < 6) {
                  return 'Password must be 6 characters.';
                }
                return null;
              },
            ),
          ),

          //4
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 15),
            child: Text("Confirm Password"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePasswordConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePasswordConfirm = !hidePasswordConfirm;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the password';
                } else if (value != confirmPassword) {
                  return 'Password does not match with each other';
                }
                return null;
              },
              obscureText: hidePasswordConfirm,
            ),
          ),
        ],
      ),
    );
  }
}
