import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungtee/Models/event_model.dart';
import 'package:tungtee/Pages/eventdetail.dart';
import 'package:tungtee/Services/user_provider.dart';
import 'package:tungtee/Widgets/cardevent.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String? _selectedValue = 'All';

  void onChanged(String? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("History"),
                          const SizedBox(width: 15),
                          DropdownButton<String>(
                            value: _selectedValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            items: <String>['Joined', 'Created', 'All']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              renderEvents(_selectedValue!),
            ],
          ),
        ),
      ),
    );
  }

  renderEvents(String selectedValue) {
    final user = FirebaseAuth.instance.currentUser!;
    return Expanded(
      child: FutureBuilder<List<EventModel>?>(
          future: selectedValue == 'Created'
              ? UserProvider().getCreatedEvents(user.uid)
              : selectedValue == 'Joined'
                  ? UserProvider().getJoinedEvents(user.uid)
                  : UserProvider().getJoinedAndCreatedEvents(user.uid),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<EventModel> eventList = snapshot.data;
              return ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDetail(
                                          eventId: eventList
                                              .elementAt(index)
                                              .eventId,
                                          image: eventList[index].image,
                                        )));
                          },
                          child: CardLayout(
                            thumbnail: eventList[index].image,
                            title: eventList.elementAt(index).eventTitle,
                            subtitle: eventList.elementAt(index).location,
                            toptitle: eventList
                                .elementAt(index)
                                .dateOfEvent
                                .start
                                .toString(),
                            amountPerson: eventList
                                .elementAt(index)
                                .joinedUsers
                                .length
                                .toString(),
                            maxPerson: eventList
                                .elementAt(index)
                                .maximumPeople
                                .toString(),
                          ),
                        ),
                        const SizedBox(height: 10)
                      ],
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
