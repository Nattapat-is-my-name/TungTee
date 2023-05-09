import 'package:flutter/material.dart';

// !NOT USE BUT DO NOT DELETE
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _resetPasswordFormKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  void handleShowPassword() {
    setState(() {
      if (isShowPassword) {
        isShowPassword = false;
      } else {
        isShowPassword = true;
      }
    });
  }

  void handleShowConfirmPassword() {
    setState(() {
      if (isShowConfirmPassword) {
        isShowConfirmPassword = false;
      } else {
        isShowConfirmPassword = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),
              Text(
                'Enter new password',
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              const SizedBox(height: 32),
              Form(
                key: _resetPasswordFormKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password'),
                      const SizedBox(height: 4),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            contentPadding: const EdgeInsets.all(16),
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
                      const Text('Confirm Password'),
                      const SizedBox(height: 4),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: confirmPassController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        autocorrect: false,
                        obscureText: !isShowConfirmPassword,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16),
                            suffixIcon: GestureDetector(
                                onTap: handleShowConfirmPassword,
                                child: isShowConfirmPassword
                                    ? const Icon(Icons.visibility, size: 18)
                                    : const Icon(Icons.visibility_off,
                                        size: 18)),
                            hintText: '*******',
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
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Reset Password'),
                                  SizedBox(width: 16),
                                  Icon(Icons.arrow_forward_ios, size: 14)
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
