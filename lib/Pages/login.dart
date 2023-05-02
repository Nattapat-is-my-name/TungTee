import 'package:flutter/material.dart';
import 'package:tungtee/Pages/register.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/services/auth_provider.dart';
import 'package:tungtee/Widgets/custom_appbar.dart';
import 'package:tungtee/Widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to \nTung Tee!',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please enter your detail',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 32),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    children: [
                      const LoginForm(),
                      const SizedBox(height: 45),
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
                              child: const Text('Or Login With')),
                          const Expanded(
                              child: Divider(
                            height: 1.2,
                            thickness: 2,
                          )),
                        ],
                      ),
                      const SizedBox(height: 31),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await AuthProvider().signInWithGoogle();
                          },
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
                      const SizedBox(height: 85),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('You don\'t have an account? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 12)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()));
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: rawPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
