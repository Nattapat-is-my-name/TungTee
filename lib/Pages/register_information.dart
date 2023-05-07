import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tungtee/Pages/persona.dart';

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
  final birthDateController = TextEditingController();

  bool isShowClearFullName = false;
  bool isShowClearNickName = false;
  bool isShowClearPhone = false;
  bool isBirthDateEmpty = true;
  bool isClickedValidate = false;
  bool isGenderEmpty = true;
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

  Future<void> handleBirthDateField() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        birthDateController.text = formattedDate;
        isBirthDateEmpty = false;
      });
    } else {
      setState(() {
        isBirthDateEmpty = true;
      });
    }
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
                            margin: EdgeInsets.only(
                                // Add margin because birthdate field add padding after validated error
                                bottom: isBirthDateEmpty && isClickedValidate
                                    ? 25
                                    : 0),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.2,
                                    color: isGenderEmpty &&
                                            isClickedValidate &&
                                            gender == null
                                        ? Colors.red.shade900
                                        : Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(8)),
                            child: DropdownButton<String>(
                                underline:
                                    Container(), // https://stackoverflow.com/questions/53588785/remove-underline-from-dropdownbuttonformfield
                                isExpanded: true,
                                iconEnabledColor: isGenderEmpty &&
                                        isClickedValidate &&
                                        gender == null
                                    ? Colors.red.shade900
                                    : Colors.grey.shade800,
                                value: gender,
                                hint: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  child: Text('Gender',
                                      style: TextStyle(
                                          color:
                                              isGenderEmpty && isClickedValidate
                                                  ? Colors.red.shade900
                                                  : Colors.grey.shade800)),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                      value: 'male',
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 0),
                                        child: Text('Male'),
                                      )),
                                  DropdownMenuItem(
                                      value: 'female',
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 0),
                                        child: Text('Female'),
                                      )),
                                  DropdownMenuItem(
                                      value: 'others',
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 0),
                                        child: Text('Others'),
                                      )),
                                ],
                                onChanged: handleGenderFieldChange),
                          ),
                        ),
                        const SizedBox(width: 32),
                        // DATE FIELD
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: birthDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Birthdate';
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: handleBirthDateField, // open date picker
                            decoration: InputDecoration(
                                labelText: 'Birthdate',
                                contentPadding: const EdgeInsets.all(16),
                                hintText: 'dd/MM/yyyy',
                                suffixIcon: IconButton(
                                  onPressed:
                                      handleBirthDateField, // open date picker
                                  icon: const Icon(Icons.calendar_month),
                                  iconSize: 22,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FilledButton(
                            onPressed: () {
                              if (_registerInfoFormKey.currentState!
                                  .validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PersonaPage(
                                              email: widget.email,
                                              password: widget.password,
                                              fullname: fullnameController.text,
                                              nickname: nicknameController.text,
                                              phone: phoneController.text,
                                              gender: genderController.text,
                                              birthDate:
                                                  birthDateController.text,
                                            )));
                              } else {
                                setState(() {
                                  isClickedValidate = true;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Next'),
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
