import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('help')), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "Help & Support",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "1. To register, go to the Register screen and enter your information.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              "2. If you forgot your password, use the Forgot Password option.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              "3. For further help, please contact support at englishforum@example.com",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
