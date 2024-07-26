import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Palette.textColor2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: children,
          ),
        )
      ],
    );
  }
}

class SettingsListItem extends StatefulWidget {
  const SettingsListItem({
    super.key,
    this.onTap,
    required this.icon,
    required this.label,
    this.toggle = false,
    this.bgColor = Colors.white,
    this.txtColor = const Color.fromARGB(255, 165, 119, 238),
  });

  final void Function()? onTap;
  final String label;
  final IconData icon;
  final bool toggle;
  final Color? bgColor;
  final Color? txtColor;
  @override
  State<SettingsListItem> createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  bool isActive = false;

  void change(bool value) {
    setState(() {
      isActive = value;
    });
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.toggle) {
          change(!isActive);
        } else {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(widget.icon,
                color:
                    widget.txtColor ?? Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(widget.label,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: widget.txtColor)),
            ),
            widget.toggle == true
                ? Switch(
                    value: isActive,
                    inactiveThumbColor: Palette.textColor1,
                    inactiveTrackColor: Colors.white,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged:(value) => Provider.of<ThemeProvider>(context, listen:  false).toggleThemeMode(),)
                : Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: widget.txtColor ??
                        Theme.of(context).colorScheme.primary,
                  ),
          ],
        ),
      ),
    );
  }
}
