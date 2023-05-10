import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Models/user_model.dart';
import 'package:tungtee/Pages/home.dart';
import 'package:tungtee/Services/auth_provider.dart';
import 'package:tungtee/Services/user_provider.dart';

class PersonaPage extends StatefulWidget {
  const PersonaPage({
    super.key,
    this.email,
    this.password,
    required this.fullname,
    required this.nickname,
    required this.phone,
    required this.gender,
    required this.birthDate,
  });

  final String? email;
  final String? password;
  final String fullname;
  final String nickname;
  final String phone;
  final String gender;
  final DateTime birthDate;

  @override
  State<PersonaPage> createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  final List<String> interests = [
    '⚽️ Sport',
    '🎵Music',
    '✏️ Drawing',
    '🛒 Shopping',
    '🎯 Board games',
    '🍲 Cooking',
    '📚 Reading',
    '🎤 Singing',
    '🌱 Gardening',
    '🍿 Movies',
    '🎮 Video games',
    '✈️ Traveling',
    '🎣 Fishing',
    '📸 Photography',
  ];

  final List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Interests",
                style: TextStyle(fontSize: 47, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 8,
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: interests.map((interest) {
                  return FilterChip(
                    showCheckmark: false,
                    label: Text(interest),
                    selected: selectedInterests.contains(interest),
                    onSelected: (bool? value) {
                      setState(() {
                        if (selectedInterests.contains(interest)) {
                          selectedInterests.remove(interest);
                        } else {
                          selectedInterests.add(interest);
                        }
                      });
                    },
                    backgroundColor: const Color.fromRGBO(246, 237, 255, 1),
                    shape: const StadiumBorder(),
                    side: selectedInterests.contains(interest)
                        ? const BorderSide(
                            width: 1.0, color: Color.fromRGBO(103, 80, 164, 1))
                        : BorderSide.none,
                  );
                }).toList(),
              ),
              const SizedBox(height: 64),
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FilledButton(
                      onPressed: () async {
                        // EMAIL AND PASSWORD USER
                        if (widget.email != null && widget.password != null) {
                          final userCredential = await AuthProvider()
                              .registerWithEmailAndPassword(
                                  widget.email!, widget.password!);
                          final user = userCredential.user;
                          if (user != null) {
                            await UserProvider().createUser(UserModel(
                              userId: user.uid,
                              fullname: widget.fullname,
                              nickname: widget.nickname,
                              email: widget.email!,
                              phone: widget.phone,
                              gender: widget.gender,
                              birthDate: widget.birthDate,
                              interests: selectedInterests,
                              createdEvents: [],
                              joinedEvents: [],
                              behaviorPoint: 3,
                              profileImage: "",
                            ));
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          }
                          // GOOGLE USER
                        } else if (widget.email != null) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await UserProvider().createUser(UserModel(
                              userId: user.uid,
                              fullname: widget.fullname,
                              nickname: widget.nickname,
                              email: widget.email!,
                              phone: widget.phone,
                              gender: widget.gender,
                              birthDate: widget.birthDate,
                              interests: selectedInterests,
                              createdEvents: [],
                              joinedEvents: [],
                              behaviorPoint: 3,
                              profileImage: '',
                            ));
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Done'),
                          SizedBox(width: 16),
                          Icon(Icons.arrow_forward_ios, size: 14)
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
