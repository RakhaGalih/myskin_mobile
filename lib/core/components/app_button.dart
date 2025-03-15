// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.radius = 24,
      this.isOutline = false,
      this.colorButton = AppColor.primaryColor,
      this.colorOverlay = AppColor.whiteColor,
      this.padding = 16});
  final Widget child;
  final VoidCallback onPressed;
  final bool isOutline;
  final double radius;
  final Color colorButton;
  final Color colorOverlay;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: colorOverlay,
        backgroundColor: (isOutline) ? AppColor.whiteColor : colorButton,
        side: (isOutline) ? BorderSide(color: colorButton, width: 1) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: padding), child: child),
    );
  }
}
