import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryDark,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryDarker,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://i.imgur.com/gLmsMrS.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Javier',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.accent),
            title: const Text('Inicio', style: TextStyle(color: AppColors.accent)),
            onTap: () {
              context.go('/');
              Navigator.pop(context); // Cierra el menú al navegar
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder, color: Colors.white),
            title: const Text('Mi Portfolio', style: TextStyle(color: Colors.white)),
            onTap: () {
              context.go('/portfolio');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}