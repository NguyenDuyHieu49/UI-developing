import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _privateAccount = false;
  bool _showLastSeen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('privacy_security'))),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            children: [
              SwitchListTile(
                title: Text(t('private_account')),
                subtitle: Text(t('private_account_subtitle')),
                value: _privateAccount,
                onChanged: (v) => setState(() => _privateAccount = v),
              ),
              SwitchListTile(
                title: Text(t('show_last_seen')),
                value: _showLastSeen,
                onChanged: (v) => setState(() => _showLastSeen = v),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(t('privacy_policy')),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(t('privacy_policy_title')),
                    content: Text(t('privacy_policy_placeholder')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(t('close')),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
