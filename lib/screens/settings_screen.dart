import 'package:flutter/material.dart';

import 'privacy_screen.dart';
import '../l10n/translations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    // Initialize the displayed language label based on the current locale.
    final code = LocaleService.current.value;
    _language = code == 'vi' ? 'Tiếng Việt' : 'English';
  }

  void _showLanguagePicker() async {
    final chosen = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(t('change_language')),
        children: [
          // Language selection options as tappable ListTiles
          ListTile(
            title: Text(t('language_english')),
            trailing: _language == 'English'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () => Navigator.of(ctx).pop('English'),
          ),
          ListTile(
            title: Text(t('language_vietnamese')),
            trailing: _language == 'Tiếng Việt'
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () => Navigator.of(ctx).pop('Tiếng Việt'),
          ),
        ],
      ),
    );

    // Ensure the widget is still mounted before using context-dependent APIs
    if (!mounted) return;

    if (chosen != null && chosen != _language) {
      setState(() {
        _language = chosen;
      });
      // update global locale
      LocaleService.setLocale(_language == 'Tiếng Việt' ? 'vi' : 'en');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('settings')), backgroundColor: Colors.blue),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(t('change_language')),
                subtitle: Text(_language),
                onTap: _showLanguagePicker,
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: Text(t('privacy_security')),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()),
                ),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.notifications),
                title: Text(t('notifications')),
                value: _notificationsEnabled,
                onChanged: (v) => setState(() => _notificationsEnabled = v),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(
                  t('logout'),
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  // Capture Navigator before awaiting to avoid using BuildContext
                  final navigator = Navigator.of(context);
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(t('logout')),
                      content: Text(t('are_you_sure_logout')),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: Text(t('cancel')),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text(t('logout')),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    // Guard against the widget being disposed while the dialog was open
                    if (!mounted) return;
                    // Use captured navigator to change routes
                    navigator.pushNamedAndRemoveUntil(
                      '/login',
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
