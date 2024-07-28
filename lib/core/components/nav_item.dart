import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavItem extends StatefulWidget {
  const NavItem({super.key, required this.icon, required this.index});
  final IconData icon;
  final int index;

  String get name {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Pay";
      case 2:
        return 'Form';
      default:
        return "Home";
    }
  }

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (context, value, child) {
      int currPage = value.currentPage;

      return InkWell(
        onTap: () {
          value.setCurrentPage(widget.index);
        },
        child: Consumer<ThemeProvider>(
          builder: (_, ref, __) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon,
                      color: currPage == widget.index
                          ? Theme.of(context).colorScheme.primary
                          : ref.isDarkMode || ref.isDarkTheme
                              ? Colors.white.withOpacity(0.8)
                              : Colors.black45),
                  currPage == widget.index
                      ? Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.8),
                          ),
                        )
                      : const SizedBox.shrink(),
                  currPage == widget.index
                      ? const SizedBox.shrink()
                      : Text(
                          widget.name,
                          style: TextStyle(fontSize: 10),
                        ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
