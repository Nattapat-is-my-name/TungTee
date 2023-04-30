import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Pages/forgot_password.dart';
import 'package:tungtee/Pages/register.dart';
import 'package:tungtee/colors/colors.dart';
import 'package:tungtee/components/custom_appbar.dart';
import 'package:tungtee/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isShowPassword = false;

  void handleShowPassword() {
    setState(() {
      if (isShowPassword) {
        isShowPassword = false;
      } else {
        isShowPassword = true;
      }
    });
  }

  Future<void> handleSignInWithEmailAndPassword() async {
    try {
      if (_loginFormKey.currentState!.validate()) {
        await AuthService().signInWithEmailAndPassword(
            emailController.text, passwordController.text);
      }
    } on FirebaseAuthException catch (error) {
      AuthService.handleSignInError(error.code);
    }
  }

  Future<void> handleSignInWithGoogle() async {
    try {
      await AuthService().signInWithGoogle();
    } on FirebaseAuthException catch (error) {
      AuthService.handleSignInError(error.code);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email/Username'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email/username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'your_email@mail.com',
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        const SizedBox(height: 24),
                        const Text('Password'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          autocorrect: false,
                          obscureText: !isShowPassword,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: handleShowPassword,
                                  child: isShowPassword
                                      ? const Icon(Icons.visibility, size: 18)
                                      : const Icon(Icons.visibility_off,
                                          size: 18)),
                              hintText: '*******',
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()));
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: rawPrimaryColor),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: FilledButton(
                              onPressed: handleSignInWithEmailAndPassword,
                              child: const Text('Login')),
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
                            onPressed: handleSignInWithGoogle,
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
