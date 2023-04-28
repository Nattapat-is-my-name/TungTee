import 'package:flutter/material.dart';
import 'package:tungtee/colors/colors.dart';
import 'package:tungtee/components/custom_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
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
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Email/Username'),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'your_email@mail.com',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      const SizedBox(height: 24),
                      const Text('Password'),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.visibility_off,
                              size: 18,
                            ),
                            hintText: '*******',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      const SizedBox(height: 16),
                      const Text('Forgot Password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FilledButton(
                            onPressed: () {}, child: const Text('Login')),
                      ),
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
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
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
                          TextButton(
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              ))
                        ],
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
