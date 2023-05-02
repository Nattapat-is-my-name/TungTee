import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 80.0,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'Home',
              icon: const Icon(Icons.home_outlined),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Open popup menu',
              icon: const Icon(Icons.today),
              onPressed: () {},
            ),
            FloatingActionButton(
              tooltip: 'Add New Item',
              child: const Icon(Icons.add),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.mail_outline),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
    ;
  }
}

// final SnackBar snackBar = SnackBar(
//                   content: const Text('Yay! A SnackBar!'),
//                   action: SnackBarAction(
//                     label: 'Undo',
//                     onPressed: () {},
//                   ),
//                 );
//                 // Find the ScaffoldMessenger in the widget tree
//                 // and use it to show a SnackBar.
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);