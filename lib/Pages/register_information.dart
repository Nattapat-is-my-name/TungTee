import 'package:flutter/material.dart';

class RegisterInformation extends StatefulWidget {
  const RegisterInformation(
      {super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<RegisterInformation> createState() => _RegisterInformationState();
}

class _RegisterInformationState extends State<RegisterInformation> {
  final _registerInfoFormKey = GlobalKey<FormState>();

  final fullnameController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();

  bool isShowClearFullName = false;
  bool isShowClearNickName = false;
  bool isShowClearPhone = false;
  String? gender;

  void handleGenderFieldChange(String? value) {
    setState(() {
      gender = value;
    });
  }

  void handleClearFullName() {
    setState(() {
      fullnameController.clear();
      isShowClearFullName = false;
    });
  }

  void handleClearNickName() {
    setState(() {
      nicknameController.clear();
      isShowClearNickName = false;
    });
  }

  void handleClearPhone() {
    setState(() {
      phoneController.clear();
      isShowClearPhone = false;
    });
  }

  void handleFullNameFieldChange(value) {
    setState(() {
      isShowClearFullName = value.isNotEmpty;
    });
  }

  void handleNickNameFieldChange(value) {
    setState(() {
      isShowClearFullName = value.isNotEmpty;
    });
  }

  void handlePhoneFieldChange(value) {
    setState(() {
      isShowClearPhone = value.isNotEmpty;
    });
  }

  @override
  void dispose() {
    fullnameController.dispose();
    nicknameController.dispose();
    phoneController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                'Enter your basic\ninformation',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please fill your basic account information so that we know who you are',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Form(
                key: _registerInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // NAME FIELD
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: fullnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: handleFullNameFieldChange,
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          contentPadding: const EdgeInsets.all(16),
                          hintText: 'Full Name',
                          suffixIcon: isShowClearFullName
                              ? GestureDetector(
                                  onTap: handleClearFullName,
                                  child: const Icon(Icons.clear, size: 18),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 24),
                    // NICKNAME FIELD
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nicknameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your nickname';
                        }
                        return null;
                      },
                      onChanged: handleNickNameFieldChange,
                      decoration: InputDecoration(
                          labelText: 'Nickname',
                          contentPadding: const EdgeInsets.all(16),
                          hintText: 'Nickname',
                          suffixIcon: isShowClearNickName
                              ? GestureDetector(
                                  onTap: handleClearNickName,
                                  child: const Icon(Icons.clear, size: 18),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 24),
                    // PHONE FIELD
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onChanged: handlePhoneFieldChange,
                      decoration: InputDecoration(
                          labelText: 'Phone',
                          contentPadding: const EdgeInsets.all(16),
                          hintText: 'Phone',
                          suffixIcon: isShowClearPhone
                              ? GestureDetector(
                                  onTap: handleClearPhone,
                                  child: const Icon(Icons.clear, size: 18),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // GENDER FIELD
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Expanded(
                              child: DropdownButton<String>(
                                  underline:
                                      Container(), // https://stackoverflow.com/questions/53588785/remove-underline-from-dropdownbuttonformfield
                                  isExpanded: true,
                                  value: gender,
                                  hint: const Text('Gender'),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'male', child: Text('Male')),
                                    DropdownMenuItem(
                                        value: 'female', child: Text('Female')),
                                    DropdownMenuItem(
                                        value: 'others', child: Text('Others')),
                                  ],
                                  onChanged: handleGenderFieldChange),
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        // DATE FIELD
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onChanged: handlePhoneFieldChange,
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                contentPadding: const EdgeInsets.all(16),
                                hintText: 'Phone',
                                suffixIcon: isShowClearPhone
                                    ? GestureDetector(
                                        onTap: handleClearPhone,
                                        child:
                                            const Icon(Icons.clear, size: 18),
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    )
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
