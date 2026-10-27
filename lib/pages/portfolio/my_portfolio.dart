import 'package:flutter/material.dart';
import '../../shared/widgets/app_drawer.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Portfolio')),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Portfolio (En construcción)')),
    );
  }
}