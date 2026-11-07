import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'shared/theme/app_colors.dart';
import 'services/local_storage_service.dart';

void main() async {

  // Asegura que los bindings nativos estén listos antes de usar plugins
  WidgetsFlutterBinding.ensureInitialized(); //Esto me ayudo la IA
  
  // Inicializa nuestro servicio de almacenamiento local
  await LocalStorageService.init();

  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Senderos de Canarias',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}