import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('about')), backgroundColor: Colors.blue),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "English Forum App\n\n"
          "Version: 1.0.0\n"
          "Developed with Flutter.\n\n"
          "This application helps learners improve their English skills "
          "through discussions, resources, and community interaction.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
