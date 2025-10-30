import 'package:flutter/material.dart';
import '../l10n/translations.dart';
import 'home_screen.dart';
import 'help_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    HelpScreen(),
    ProfileScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ValueListenableBuilder<String>(
        valueListenable: LocaleService.current,
        builder: (context, _, __) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: t('home')),
              BottomNavigationBarItem(icon: Icon(Icons.help), label: t('help')),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: t('profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: t('settings'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: t('about'),
              ),
            ],
          );
        },
      ),
    );
  }
}
