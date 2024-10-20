import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/components/bottom_nav_bar.dart';
import 'package:church_clique/core/components/dialog_box.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _drawerController = AdvancedDrawerController();
  bool canPop = true;


  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeDrawer(
      controller: _drawerController,
      child: Consumer(
        builder: (context, MainPageProvider pageState, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: mainSystemUiOverlayStyle(context),
            child: Scaffold(
              // appBar: AppBar(
              //   leading: IconButton(
              //     onPressed: _handleMenuButtonPressed,
              //     icon: ValueListenableBuilder<AdvancedDrawerValue>(
              //       valueListenable: _drawerController,
              //       builder: (_, value, __) {
              //         return AnimatedSwitcher(
              //           duration: const Duration(milliseconds: 250),
              //           child: Icon(
              //             value.visible ? Icons.clear : Icons.menu,
              //             key: ValueKey<bool>(value.visible),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              body: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result){
                  dialogBox(context);
                },
                child: KMainPages[pageState.currentPage],
              ),
              bottomNavigationBar: const BottomNavBar(),
            ),
          );
        },
      ),
    );
  }
}
