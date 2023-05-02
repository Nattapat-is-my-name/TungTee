import 'package:flutter/material.dart';

const Color rawPrimaryColor = Color.fromARGB(255, 103, 80, 164);
MaterialColor primaryColor =
    MaterialColor(rawPrimaryColor.value, const <int, Color>{
  50: Color.fromRGBO(103, 80, 164, 0.1),
  100: Color.fromRGBO(103, 80, 164, 0.2),
  200: Color.fromRGBO(103, 80, 164, 0.3),
  300: Color.fromRGBO(103, 80, 164, 0.4),
  400: Color.fromRGBO(103, 80, 164, 0.5),
  500: Color.fromRGBO(103, 80, 164, 0.6),
  600: Color.fromRGBO(103, 80, 164, 0.7),
  700: Color.fromRGBO(103, 80, 164, 0.8),
  800: Color.fromRGBO(103, 80, 164, 0.9),
  900: Color.fromRGBO(103, 80, 164, 1.0),
});
