import 'package:flutter/material.dart';

class PersonaProvider with ChangeNotifier {
  List<String> persona = [];
  List<String> getPersona() {
    return persona;
  }

  void addPersona(String persona) {
    this.persona.add(persona);
  }

  void deletePersona(String text) {
    persona.removeWhere((element) => element == text);
  }
}
