import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class HobbieBox extends StatelessWidget {
  const HobbieBox({super.key, required this.text});

  final String text;
  static const double _width = 160;
  static const double _height = 60;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  
  
  static const TextStyle _textStyle = TextStyle(color: AppColors.textMain, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: AppColors.hobbieBoxBackground,
        border: Border.all(color: AppColors.hobbieBoxBorder, width: 2),
      ),
      child: Center(
        child: Padding(
          padding: _padding,
          child: Text(
            text, 
            style: _textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}