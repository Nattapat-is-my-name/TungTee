import 'package:flutter/material.dart';
import 'package:tungtee/models/persona_model.dart';

class PersonaProvider with ChangeNotifier {
  List<PersonaModel> persona = [
    PersonaModel(title: "🏈 Soccer"),
    PersonaModel(title: "🏀 Basketball"),
    PersonaModel(title: "⚽️ Football"),
  ];
  List<PersonaModel> getPersona() {
    return persona;
  }

  void addPersona(PersonaModel persona) {
    this.persona.add(persona);
  }

  void deletePersona(String text) {
    persona.removeWhere((element) => element.title == text);
  }
}
