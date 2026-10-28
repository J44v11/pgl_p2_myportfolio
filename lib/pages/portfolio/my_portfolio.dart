import 'package:flutter/material.dart';

import '../../shared/widgets/app_drawer.dart';
import 'widgets/portfolio_header.dart';
import 'widgets/hobbies.dart';
import 'widgets/repository_info.dart';
import 'widgets/portfolio_footer.dart';
import '../../shared/theme/app_colors.dart';

const String appTitle = 'Este es mi portfolio';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  static const int _hobbiesPage = 0;
  static const int _repositoryPage = 1;

  int _selectedPage = _hobbiesPage;

  void _selectPage(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final bool isRepo = _selectedPage == _repositoryPage;

    return Scaffold(
      backgroundColor: AppColors.background,
      // Menú lateral para la navegación general (Inicio / Portfolio)
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.12,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textLight),
        title: const Text(
          appTitle,
          style: TextStyle(color: AppColors.textLight, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            PortfolioHeader(
              screenHeight: screenHeight, 
              screenWidth: screenWidth, 
              isRepositoryPage: isRepo
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: screenWidth,
                  child: isRepo ? const RepositoryInfo() : const Hobbies(),
                ),
              ),
            ),
          ],
        ),
      ),
      // Menú inferior para la navegación interna (Hobbies / Repositorio)
      bottomNavigationBar: PortfolioFooter(
        currentIndex: _selectedPage,
        onTap: _selectPage,
      ),
    );
  }
}