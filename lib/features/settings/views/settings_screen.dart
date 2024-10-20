
import 'package:church_clique/core/components/settings_item.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String ? 
  imagePath;

  Future<void> _loadImagePath() async{
    final prefs = await sharedPrefs;
    setState(() {
      imagePath =  prefs.getString('imagePath') ?? 'http://10.0.2.2/3000/images/de1724059544206close-up-of-a-group-of-happy-multiracial-people-holding-money-banknotes-and-celebrating-isolated-over-white-background-MY0HTD.jpg';
    });
  }


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
  
  }

  @override
  void initState() {
    super.initState();
    _loadImagePath();
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
          title: const Row(
            children: [
              Icon(Icons.logout),
              SizedBox(width: 20),
              Text('Logout')
            ],
          ),
          content: const Text(
            'You are about to log out',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
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
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      const Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SettingsCard(
                        label: 'General',
                        children: [
                          // const SettingsListItem(
                          //   icon: MaterialCommunityIcons.account,
                          //   label: 'Account',
                          // ),
                          SettingsListItem(
                            label: 'Theme',
                            toggle: true,
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
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                       SettingsCard(
                        label: 'About',
                        children: [
                          SettingsListItem(
                            onTap:(){
                              Navigator.of(context).pushNamed('about');
                            } ,
                            icon: MaterialCommunityIcons.information_outline,
                            label: 'About developer',
                          ),
                          SettingsListItem(
                            onTap: (){
                              Navigator.of(context).pushNamed('contact developer');
                            },
                            icon: MaterialCommunityIcons.email_outline,
                            label: 'Contact developer',
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
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ProfileImageButton extends StatelessWidget {
  const ProfileImageButton({
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
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
