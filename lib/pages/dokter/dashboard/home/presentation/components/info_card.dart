import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onPressed;
  final IconData icon;
  const InfoCard(
      {super.key,
      required this.title,
      required this.value,
      required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CardContainer(
            child: SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypograph.label3.regular),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.whiteColor,
                        border: Border.all(color: AppColor.greyColor)),
                    child: Icon(
                      icon,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    value,
                    style: AppTypograph.label1.bold,
                  )
                ],
              )
            ]),
      ),
    )));
  }
}
