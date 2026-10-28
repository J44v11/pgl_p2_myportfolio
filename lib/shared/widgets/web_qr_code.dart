import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_colors.dart';

class WebQrCode extends StatelessWidget {
  const WebQrCode({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
      child: QrImageView(
        data: url,
        version: QrVersions.auto,
        size: 150,
        backgroundColor: AppColors.background,
        eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: AppColors.textMain),
        dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: AppColors.textMain),
      ),
    );
  }
}
