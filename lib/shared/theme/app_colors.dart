import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF512DA8); // Morado principal
  static const Color primaryDark = Color(0xFF311B5E); // Morado oscuro para el Drawer
  static const Color primaryDarker = Color(0xFF221242); // Morado muy oscuro para cabecera del Drawer
  
  static const Color background = Colors.white;
  static const Color textMain = Colors.black;
  static const Color textLight = Colors.white;

  static final Color headerBackground = Colors.grey[200]!;
  static final Color footerBackground = Colors.grey[200]!;
  
  static final Color hobbieBoxBackground = Colors.blue[50]!;
  static final Color hobbieBoxBorder = Colors.blue;
  
  static const Color accent = Colors.amber;
}