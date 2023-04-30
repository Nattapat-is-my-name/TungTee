import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/pages/forgot_password.dart';
import 'package:tungtee/colors/colors.dart';
import 'package:tungtee/services/auth_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isShowPassword = false;
  bool isShowClearIcon = false;

  void handleShowPassword() {
    setState(() {
      if (isShowPassword) {
        isShowPassword = false;
      } else {
        isShowPassword = true;
      }
    });
  }

  void handleClearEmail() {
    setState(() {
      emailController.clear();
      isShowClearIcon = false;
    });
  }

  void handleEmailFieldChange(value) {
    setState(() {
      isShowClearIcon = value.isNotEmpty;
    });
  }

  Future<void> handleSignInWithEmailAndPassword() async {
    try {
      if (_loginFormKey.currentState!.validate()) {
        await AuthService().signInWithEmailAndPassword(
            emailController.text, passwordController.text);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == SignInError.invalidEmail && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: rawPrimaryColor,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              padding: EdgeInsets.all(8),
              content: Text('Invalid Email, Please enter a correct email',
                  style: TextStyle(fontSize: 16))),
        );
      }
      if (error.code == SignInError.wrongPassword && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: rawPrimaryColor,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              padding: EdgeInsets.all(8),
              content: Text('Wrong Password, Please try again',
                  style: TextStyle(fontSize: 16))),
        );
      }
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
    return Form(
      key: _loginFormKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          onChanged: handleEmailFieldChange,
          decoration: InputDecoration(
              hintText: 'your_email@mail.com',
              suffixIcon: isShowClearIcon
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          emailController.clear();
                          isShowClearIcon = false;
                        });
                      },
                      child: const Icon(Icons.clear, size: 18),
                    )
                  : null,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                      : const Icon(Icons.visibility_off, size: 18)),
              hintText: '*******',
              border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(8))),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage()));
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
      ]),
    );
  }
}
