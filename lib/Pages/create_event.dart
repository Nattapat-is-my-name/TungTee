import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:tungtee/Pages/Register.dart';

class Createevent extends StatefulWidget {
  const Createevent({super.key});

  @override
  State<Createevent> createState() => _CreateeventState();
}

class _CreateeventState extends State<Createevent> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  bool showWidget = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Event Name',
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 200,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descscript Here',
                  labelText: 'Detail',
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller:
                          dateController, //editing controller of this TextField
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          //icon of text field
                          labelText: "Enter Date" //label text of field
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
                            dateController.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller:
                          dateController, //editing controller of this TextField
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),

                          //icon of text field
                          labelText: "Enter Date" //label text of field
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
                            dateController.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showWidget = !showWidget;
                  });
                },
                child: const Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
              ),
              Column(
                children: [
                  showWidget
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Icon(Icons.ac_unit),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Icon(Icons.accessible),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Icon(Icons.backpack),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Icon(Icons.cached),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
              SizedBox(
                width: 150,
                child: TextField(
                  controller:
                      dateController, //editing controller of this TextField
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),

                      //icon of text field
                      labelText: "Enter Date" //label text of field
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
                        dateController.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
