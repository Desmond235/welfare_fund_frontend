import 'package:church_clique/features/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class MenuItem extends StatefulWidget {
  const MenuItem(
      {super.key, required this.child, required this.drawerController});
  final Widget child;
  final AdvancedDrawerController drawerController;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return HomeDrawer(
      controller: widget.drawerController,
      child: widget.child,
    );
  }
}

class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final AdvancedDrawerController drawerController;
  final String title;

  const AppBarScreen({super.key, required this.drawerController, required this.title})
      : preferredSize = const Size.fromHeight(56.0);

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  void _handleMenuButtonPressed() {
    widget.drawerController.showDrawer();
  }

  @override
  void dispose() {
    super.dispose();
    widget.drawerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title:  Text(widget.title),
        leading: IconButton(
          onPressed: _handleMenuButtonPressed,
          icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: widget.drawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(value.visible ? Icons.clear : Icons.menu,
                        key: ValueKey<bool>(value.visible)));
              }),
        ));
  }
}
