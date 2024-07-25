import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:icons_flutter/icons_flutter.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.child,
    required this.controller,
  });
  final Widget child;
  final AdvancedDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
            Theme.of(context).colorScheme.primary
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
      ),
      controller: controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      disabledGestures: false,
      childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.only(top: 24, bottom: 50),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.black26, shape: BoxShape.circle),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.hideDrawer();
                  },
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                ),
                ListTile(
                  onTap:(){
                    controller.hideDrawer();
                    Navigator.of(context).pushNamed('settings');
                  },
                  leading: const Icon(MaterialCommunityIcons.settings),
                  title: const Text("Settings"),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //           builder: (context) => const ProfileScreen()),
                //     );
                //     controller.hideDrawer();
                //   },
                //   leading: const Icon(MaterialCommunityIcons.account),
                //   title: const Text("Profile")
                // ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Welfare Fund',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Copyright © 2024',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
