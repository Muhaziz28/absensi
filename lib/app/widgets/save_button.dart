import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  SaveButton({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
