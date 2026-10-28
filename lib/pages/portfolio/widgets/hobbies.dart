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
    final double screenWidth = MediaQuery.of(context).size.width;

    final int columns = screenWidth >= 900
        ? 4
        : screenWidth >= 600
        ? 3
        : 2;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: hobbiesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        return HobbieBox(text: hobbiesList[index]);
      },
    );
  }
}
