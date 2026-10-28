import 'package:flutter/material.dart';
import '../../../shared/widgets/web_qr_code.dart';
import '../../../shared/theme/app_colors.dart';

const String torLogoPath = 'assets/images/Tor_logo.png';
const String firefoxText = '¡El navegador Tor mola más!';
const String githubUrl = 'https://github.com/J44v11';

class RepositoryInfo extends StatelessWidget {
  const RepositoryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset(torLogoPath, width: 100, fit: BoxFit.contain),
        const Text(
          firefoxText,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textMain, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const Center(
          child: WebQrCode(url: githubUrl),
        ),
      ],
    );
  }
}