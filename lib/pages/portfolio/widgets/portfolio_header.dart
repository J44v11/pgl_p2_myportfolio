import 'package:flutter/material.dart';

import '../../../shared/theme/app_colors.dart';

const String profileDescription = 'Me gusta dart pero hay veces que no me gusta tanto como yo espero :)';

const String hobbiesProfileImageUrl = 'https://i.imgur.com/gLmsMrS.png';
const String repositoryProfileImageUrl = 'https://i.imgur.com/hhtxjs7.png';

class PortfolioHeader extends StatelessWidget {
  const PortfolioHeader({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.isRepositoryPage,
  });

  final double screenHeight;
  final double screenWidth;
  final bool isRepositoryPage;

  @override
  Widget build(BuildContext context) {
    final String profileImageUrl = isRepositoryPage ? repositoryProfileImageUrl : hobbiesProfileImageUrl;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.15,
      color: AppColors.headerBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 15,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(profileImageUrl)),
            ),
          ),
          const Expanded(
            child: Text(profileDescription, style: TextStyle(color: AppColors.textMain, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
