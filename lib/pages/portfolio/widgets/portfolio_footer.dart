import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.footerBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.hobbieBoxBorder,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Mis hobbies',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'Mi repositorio',
        ),
      ],
    );
  }
}