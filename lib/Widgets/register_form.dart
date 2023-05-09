import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Pages/register_information.dart';
import 'package:tungtee/Services/user_provider.dart';

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool hidePassword = true;
  bool hidePasswordConfirm = true;
  String? confirmPassword;
  bool isChecked = false;
  bool isShowClearName = false;
  bool isShowClearEmail = false;

  final _registerFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  void handleEmailFieldChange(value) {
    setState(() {
      isShowClearEmail = value.isNotEmpty;
    });
  }

  void handleNameFieldChange(value) {
    setState(() {
      isShowClearName = value.isNotEmpty;
    });
  }

  void handleSignUp() async {
    if (_registerFormKey.currentState!.validate() && isChecked) {
      final email = emailController.text;
      final password = passwordController.text;
      final user = await UserProvider().getUserByEmail(email);
      // NO USER EXIST IN DATABASE (NORMAL CASE)
      if (user == null) {
        if (context.mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterInformation(
                        email: email,
                        password: password,
                      )));
        }
        // USER ALREADY EXIST (ERROR CASE)
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              padding: EdgeInsets.all(8),
              content:
                  Text('User already exist', style: TextStyle(fontSize: 16))));
        }
      }
    } else if (_registerFormKey.currentState!.validate() && !isChecked) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: rawPrimaryColor,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              padding: EdgeInsets.all(8),
              content: Text('You have to agree on our Term and Policy',
                  style: TextStyle(fontSize: 16))),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //2
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 15),
            child: Text("Email"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFormField(
                onChanged: handleEmailFieldChange,
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  suffixIcon: isShowClearEmail
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              emailController.clear();
                              isShowClearEmail = false;
                            });
                          },
                          child: const Icon(Icons.clear, size: 18),
                        )
                      : null,
                  contentPadding: const EdgeInsets.all(16),
                  hintText: "your_email@mail.com",
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter email in correct format';
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
              controller: passwordController,
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
                if (value == null || value.isEmpty) {
                  return 'Please enter the password';
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
              controller: confirmPassController,
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
                } else if (value != passwordController.text) {
                  return 'Password does not match with each other';
                }
                return null;
              },
              obscureText: hidePasswordConfirm,
            ),
          ),
          const SizedBox(height: 16),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: primaryColor.shade900,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                          text: "By registering, you are agreeing with our ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                        text: "Terms of Use",
                        style: TextStyle(
                            color: primaryColor.shade900,
                            decoration: TextDecoration.underline),
                      ),
                      const TextSpan(
                        text: " and ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                            color: primaryColor.shade900,
                            decoration: TextDecoration.underline),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
              width: double.infinity,
              height: 45,
              child: FilledButton(
                  onPressed: handleSignUp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Register'),
                      SizedBox(width: 16),
                      Icon(Icons.arrow_forward_ios, size: 14)
                    ],
                  )
                  // child: const Text('Login')),
                  )),
        ],
      ),
    );
  }
}
