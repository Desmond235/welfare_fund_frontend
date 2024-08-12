import 'dart:io';

import 'package:church_clique/core/components/settings_item.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/settings/providers/image_provider.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

typedef List_int = List<int>;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  File? _userImage;
  savedImage() {
    userImage();
  }

  void userImage() async {
    
    final pickedUserImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 150,
    );
    if (pickedUserImage == null) {
      return;
    }
    setState(() {
      _userImage = File(pickedUserImage.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

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
                Navigator.of(context).pushNamedAndRemoveUntil(
                  'auth',
                  (route) => false,
                );
                Provider.of<SignInProvider>(context,listen: false).removeSigninSate();
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
     String imagePath =context.read<ImagePathProvider>().imagePath;
     print(imagePath);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mainSystemUiOverlayStyle(context),
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // CachedNetworkImage(
                            //   imageUrl: imagePath,
                            //   placeholder: (context, url) => const CircleAvatar(
                            //     backgroundColor: Colors.amber,
                            //     radius: 50,
                            //   ),
                            //   imageBuilder: (context, image) => CircleAvatar(
                            //     backgroundImage: _userImage != null
                            //       ? FileImage(_userImage!)
                            //       : AssetImage(
                            //           'assets/images/user-icon.png',
                            //         ),
                            //     radius: 50,
                            //   ),
                            // ),

                            CircleAvatar(
                              backgroundColor: Provider.of<ThemeProvider>(
                                              context,
                                              listen: false)
                                          .isDarkMode ||
                                      Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .isDarkTheme
                                  ? const Color.fromARGB(31, 17, 17, 17)
                                      .withOpacity(0.03)
                                  : Colors.grey.shade200.withOpacity(0.4),
                              radius: 50,
                              backgroundImage: _userImage != null
                                  ? FileImage(_userImage!)
                                  : AssetImage(
                                      'assets/images/user-icon.png',
                                    ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Desmond Adabe',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: 3000,
                              ),
                              key: ValueKey(_animation),
                              child: Icon(
                                color: Colors.deepPurple.shade300,
                                Provider.of<ThemeProvider>(context,
                                                listen: false)
                                            .isDarkMode ||
                                        Provider.of<ThemeProvider>(context,
                                                listen: false)
                                            .isDarkTheme
                                    ? MaterialCommunityIcons
                                        .moon_waning_crescent
                                    : Icons.sunny,
                              ),
                            ),
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
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.5,
                  top: 65,
                  child: ProfileImage(
                    onTap: () {
                        print(imagePath);
                      savedImage();
                      },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
