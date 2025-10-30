import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('profile')), backgroundColor: Colors.blue),
      body: const Center(
        child: Text(
          "This is the Profile Screen",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
