import 'package:church_clique/core/components/settings_item.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  _logoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Row(
            children: [
              Icon(Icons.logout),
              const SizedBox(width: 20),
              Text('Logout')
            ],
          ),
          content: Text(
            'You are about to log out',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil('auth', (route) => false,);
                
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Desmond Adabe',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'adabedesmond@gmail.com',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SettingsCard(
                label: 'General',
                children: [
                  SettingsListItem(
                    icon: MaterialCommunityIcons.account,
                    label: 'Account',
                  ),
                  SettingsListItem(
                    icon: MaterialCommunityIcons.moon_waning_crescent,
                    label: 'Theme',
                    toggle: true,
                  )
                ],
              ),
              const SizedBox(height: 15),
              SettingsCard(
                label: 'About',
                children: [
                  SettingsListItem(
                    icon: MaterialCommunityIcons.information_outline,
                    label: 'About us',
                  ),
                  SettingsListItem(
                    icon: MaterialCommunityIcons.email_outline,
                    label: 'Contact us',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SettingsCard(
                label: 'Logout',
                children: [
                  SettingsListItem(
                    onTap: () => _logoutDialog(context),
                    icon: Icons.logout,
                    label: 'Logout',
                    txtColor: Colors.red,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
