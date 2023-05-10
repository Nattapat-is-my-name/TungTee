import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/services/event_provider.dart';
import 'package:uuid/uuid.dart';
import '../widgets/cardevent.dart';
import '../widgets/dynamicchip.dart';
// import '../widgets/pick.dart';

class Createevent extends StatefulWidget {
  const Createevent({super.key});

  @override
  State<Createevent> createState() => _CreateeventState();
}

class _CreateeventState extends State<Createevent> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController ageM = TextEditingController();
  TextEditingController ageN = TextEditingController();
  TextEditingController title = TextEditingController();
  EventModel event = EventModel(
      eventId: Uuid().v4(),
      ownerId: Uuid().v4(),
      eventTitle: "eventTitle",
      eventDescription: "eventDescription",
      maximumPeople: 5,
      tags: ['1', '2'],
      ageRestriction: AgeRestrictionModel(minimumAge: 18, maximumAge: 25),
      dateCreated: DateTime.now(),
      dateOfEvent: DateOfEventModel(end: DateTime.now(), start: DateTime.now()),
      location: LocationModel(latitude: 23.212323, longitude: 12.334442),
      images: [],
      joinedUsers: []);

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
    dateStart.text = "";
    detail.text = '';
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Event Name',
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
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
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                dateStart.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
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
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                dateEnd.text = formattedDate;
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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showWidget = !showWidget;
                        });
                      },
                      label: Text("Set Age"),
                      icon: Icon(Icons.add, size: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showWidget1 = !showWidget1;
                        });
                      },
                      label: Text("Set Person"),
                      icon: Icon(Icons.add, size: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    showWidget
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                    labelText: 'Set Minimum Age',
                                  ),
                                ),
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
                                    labelText: 'Set Max Age',
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
                Column(
                  children: [
                    showWidget1
                        ? RangeSlider(
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
                      hintText: "Enter Detail", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Choice Hobbys"),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [dynamicChip()],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Choice Photo"),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      await EventProvider().createEvent(EventModel(
                          eventId: Uuid().v4(),
                          ownerId: user.uid,
                          eventTitle: title.text,
                          eventDescription: detail.text,
                          maximumPeople: _endValue.toInt(),
                          tags: [],
                          ageRestriction: AgeRestrictionModel(
                              minimumAge: int.parse(ageN.text),
                              maximumAge: int.parse(ageM.text)),
                          dateCreated: DateTime.now(),
                          dateOfEvent: DateOfEventModel(
                              end: DateTime.parse(dateStart.text),
                              start: DateTime.parse(dateEnd.text)),
                          location: LocationModel(
                              latitude: 23.212323, longitude: 12.334442),
                          images: [],
                          joinedUsers: [user.uid]));

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
