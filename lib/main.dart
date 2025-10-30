import 'package:flutter/material.dart';
import 'package:mobile/screens/daily_tasks_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_screen.dart';
import 'l10n/translations.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const EnglishForumApp());
}

class EnglishForumApp extends StatefulWidget {
  const EnglishForumApp({super.key});

  @override
  State<EnglishForumApp> createState() => _EnglishForumAppState();
}

class _EnglishForumAppState extends State<EnglishForumApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LocaleService.current,
      builder: (context, localeCode, _) {
        return MaterialApp(
          title: t('app_title'),
          theme: AppTheme.light(),
          builder: (context, child) {
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const MainNavigation(),
          },
        );
      },
    );
  }
}

/// Widget quản lý Bottom Navigation
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    DailyTasksScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: ValueListenableBuilder<String>(
        valueListenable: LocaleService.current,
        builder: (context, _, __) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 0.5),
              ),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: t('home'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: t('search'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.school),
                  label: t('daily'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.notifications),
                  label: t('alerts'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: t('settings'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
