import 'package:flutter/material.dart';

import 'hobbie_box.dart';

const List<String> hobbiesList = [
  'Salir a pasear',
  'Ver Series',
  'Senderismo',
  'Ir al Cine',
  'Los videojuegos',
  'Domingo de caminata',
  'Hacer Deporte',
  'Música variadita',
  'El Monte',
  'Conducir',
  'Ir de cena romantica',
  'Viajar',
];

class Hobbies extends StatelessWidget {
  const Hobbies({super.key});

  @override
  Widget build(BuildContext context) {
    final int halfIndex = hobbiesList.length ~/ 2;
    final List<String> firstColumn = hobbiesList.sublist(0, halfIndex);
    final List<String> secondColumn = hobbiesList.sublist(halfIndex);

    return Row(
      spacing: 50,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: firstColumn.map((hobby) => HobbieBox(text: hobby)).toList(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: secondColumn.map((hobby) => HobbieBox(text: hobby)).toList(),
        ),
      ],
    );
  }
}
