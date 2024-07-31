
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

SizedBox sendButton({
  required BuildContext context,
  required void Function() onTap,
  required String text,
  required IconData icon,
  required MainAxisAlignment mainAxisAlignment
}) {
  return SizedBox(
      width: double.infinity,
      height: 55,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.72),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.white,fontSize: 15.2),
              ),
              Icon(icon, color: Colors.white.withOpacity(0.7))
            ],
          ),
        ),
      ));
}
