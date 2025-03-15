// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class VerifikasiItem extends StatelessWidget {
  final String title;
  final Widget value;
  const VerifikasiItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title,
              textAlign: TextAlign.center,
              style: AppTypograph.label2.bold.copyWith(
                color: AppColor.blackColor,
              )),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: value
        ),
      ],
    );
  }
}
