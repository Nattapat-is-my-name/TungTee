import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Constants/colors.dart';
import 'package:tungtee/Services/user_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _resetPassFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  bool isShowClearIcon = false;

  void handleEmailFieldChange(value) {
    setState(() {
      isShowClearIcon = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Account Recovery',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),
              Text(
                'Please enter your email address and we will send password reset instruction to you',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              const SizedBox(height: 32),
              Form(
                key: _resetPassFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email/username';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter email in correct format';
                        }
                        return null;
                      },
                      onChanged: handleEmailFieldChange,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16),
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
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 52),
                    SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FilledButton(
                            onPressed: () async {
                              if (_resetPassFormKey.currentState!.validate()) {
                                final user = await UserProvider()
                                    .getUserByEmail(emailController.text);
                                if (user == null) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          showCloseIcon: true,
                                          closeIconColor: Colors.white,
                                          padding: EdgeInsets.all(8),
                                          content: Text('Email doesn\'t exist',
                                              style: TextStyle(fontSize: 16))),
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    // TODO handle send email
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: emailController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: rawPrimaryColor,
                                          showCloseIcon: true,
                                          closeIconColor: Colors.white,
                                          padding: EdgeInsets.all(8),
                                          content: Text(
                                              'We send reset password instruction to your email',
                                              style: TextStyle(fontSize: 16))),
                                    );
                                  }
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Send Email'),
                                SizedBox(width: 16),
                                Icon(Icons.arrow_forward_ios, size: 14)
                              ],
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
