import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;

import 'package:intl/intl.dart';
import 'package:tungtee/Constants/event_interests.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Services/chat_provider.dart';
import 'package:tungtee/navigation/bottom_navbar.dart';
import 'package:tungtee/services/event_provider.dart';
import 'package:tungtee/services/user_provider.dart';
import 'package:uuid/uuid.dart';
// import '../widgets/pick.dart';

class Createevent extends StatefulWidget {
  const Createevent({super.key});

  @override
  State<Createevent> createState() => _CreateeventState();
}

class _CreateeventState extends State<Createevent> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController timeStart = TextEditingController();
  TextEditingController timeEnd = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController ageM = TextEditingController();
  TextEditingController ageN = TextEditingController();
  TextEditingController title = TextEditingController();
  DateTime dateStart1 = DateTime.now();
  DateTime dateEnd1 = DateTime.now();

  String selectedTag = "";

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    dateStart.text = '';
    detail.text = '';
    timeStart.text = '';
    timeEnd.text = '';
    location.text = '';
    dateEnd.text = '';
    ageM.text = '';
    ageN.text = '';
    title.text = '';

    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;
  @override
  void dispose() {
    detail.dispose();
    super.dispose();
  }

  double _startValue = 1.0;
  double _endValue = 2.0;

  bool showWidget = false;
  bool showWidget1 = false;

  final _createEventFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Event'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Form(
                key: _createEventFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length >= 20) {
                          return 'letter must be letter 30';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Event Name',
                        labelText: 'Title',
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller:
                                  dateStart, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),

                                  //icon of text field
                                  hintText: "Start Date" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    dateStart.text = formattedDate;
                                    dateStart1 = pickedDate;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller:
                                  dateEnd, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),

                                  //icon of text field
                                  hintText: "End Date" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    dateEnd.text = formattedDate;
                                    dateEnd1 = pickedDate;
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller:
                                  timeStart, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),

                                  //icon of text field
                                  hintText: "Start Time" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  setState(() {
                                    DateTime parsedTime = DateFormat("HH:mm").parse(
                                        "${pickedTime.hour.toString()}:${pickedTime.minute.toString()}");

                                    String formattedTime =
                                        DateFormat('HH:mm').format(parsedTime);

                                    timeStart.text = formattedTime;
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller:
                                  timeEnd, //editing controller of this TextField
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),

                                  //icon of text field
                                  hintText: "End Time" //label text of field
                                  ),
                              readOnly: true, // when true user cannot edit text
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  setState(() {
                                    DateTime parsedTime = DateFormat("HH:mm").parse(
                                        "${pickedTime.hour.toString()}:${pickedTime.minute.toString()}");

                                    String formattedTime =
                                        DateFormat('HH:mm').format(parsedTime);

                                    timeEnd.text = formattedTime;
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              showWidget = !showWidget;
                            });
                          },
                          label: const Text("Set Age"),
                          icon: const Icon(Icons.add, size: 20),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              showWidget1 = !showWidget1;
                            });
                          },
                          label: const Text("Set Person"),
                          icon: const Icon(Icons.add, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        showWidget
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: ageN,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Minimum Age',
                                        labelText: 'Minimum Age',
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      controller: ageM,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Max Age',
                                        labelText: 'Max Age',
                                      ),
                                    ),
                                    const SizedBox(height: 16)
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Column(
                      children: [
                        showWidget1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Number of People'),
                                  RangeSlider(
                                    min: 1,
                                    max: 20,
                                    divisions: 20,
                                    labels: RangeLabels(
                                      _startValue.round().toString(),
                                      _endValue.round().toString(),
                                    ),
                                    values: RangeValues(_startValue, _endValue),
                                    onChanged: (values) {
                                      setState(() {
                                        _startValue = values.start;
                                        _endValue = values.end;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: detail,
                      maxLength: 255,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "Enter Detail",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: location,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Event Location',
                          labelText: 'Location',
                          prefixIcon: Icon(Icons.location_pin)),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select tag"),
                        const SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Wrap(
                                  spacing: 8.0,
                                  children: interests.map((interest) {
                                    return FilterChip(
                                      showCheckmark: false,
                                      label: Text(interest),
                                      selected: selectedTag == interest,
                                      onSelected: (bool? value) {
                                        setState(() {
                                          selectedTag = interest;
                                        });
                                      },
                                      backgroundColor: const Color.fromRGBO(
                                          246, 237, 255, 1),
                                      shape: const StadiumBorder(),
                                      side: selectedTag == interest
                                          ? const BorderSide(
                                              width: 1.0,
                                              color: Color.fromRGBO(
                                                  103, 80, 164, 1))
                                          : BorderSide.none,
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Photo"),
                        const SizedBox(height: 15),
                        Card(
                          margin: const EdgeInsets.all(0),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: image == null
                                  ? GestureDetector(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: const Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Center(
                                          child: Text('Upload Images'),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0), //<-- SEE HERE
                                        ),
                                        margin: const EdgeInsets.all(0),
                                        child: Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              // setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        const SizedBox(width: 16),
                        FilledButton(
                          onPressed: () async {
                            if (!dateEnd1.isBefore(dateStart1) &&
                                image != null) {
                              if (_createEventFormKey.currentState!
                                  .validate()) {
                                final newEventId = const Uuid().v4();

                                final imageFile = File(image!.path);
                                final imageBytes = imageFile.readAsBytesSync();
                                Img.Image imageTemp =
                                    Img.decodeImage(imageBytes)!;
                                Img.Image imageResize = Img.copyResize(
                                    imageTemp,
                                    width: 400,
                                    height: 400);
                                final resizeBytes = Img.encodeJpg(imageResize);

                                String image64 = base64Encode(resizeBytes);

                                await EventProvider().createEvent(
                                  EventModel(
                                      eventId: newEventId,
                                      ownerId: user.uid,
                                      eventTitle: title.text,
                                      eventDescription: detail.text,
                                      maximumPeople: (showWidget1)
                                          ? _endValue.toInt()
                                          : 20,
                                      minimumPeople: (showWidget1)
                                          ? _startValue.toInt()
                                          : 1,
                                      tag: selectedTag,
                                      ageRestriction: AgeRestrictionModel(
                                          minimumAge: int.parse(
                                              (showWidget) ? ageN.text : "16"),
                                          maximumAge: int.parse(
                                              (showWidget) ? ageM.text : "60")),
                                      dateCreated: DateTime.now(),
                                      dateOfEvent: DateOfEventModel(
                                          end: DateTime.parse(
                                              "${dateEnd.text} ${timeEnd.text}"),
                                          start: DateTime.parse("${dateStart.text} ${timeStart.text}")),
                                      location: location.text,
                                      image: image64,
                                      joinedUsers: [user.uid]),
                                );

                                await UserProvider()
                                    .joinEvent(newEventId, user.uid);
                                await UserProvider()
                                    .userCreateEvent(newEventId, user.uid);
                                await ChatProvider().initChatRoom(
                                    newEventId,
                                    (showWidget1) ? _endValue.toInt() : 20,
                                    [user.uid]);

                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Bottomnavbar()));
                                }
                              }
                            } else {
                              // final snackBar = SnackBar(
                              //   content: const Text(
                              //       'End date must be after start date!'),
                              //   action: SnackBarAction(
                              //     label: 'Ok',
                              //     onPressed: () {
                              //       // Some code to undo the change.
                              //     },
                              //   ),
                              // );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: const Text("Can't create event"),
                                      content:
                                          const Text('Check time and image'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  }));
                            }
                          },
                          child: const Text('Create Event'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
