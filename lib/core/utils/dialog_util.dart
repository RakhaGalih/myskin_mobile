import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

void updateDialog(BuildContext context,
    VoidCallback onConfirm) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Text(
            'Perbarui Keluhan',
            style: AppTypograph.label1.bold.copyWith(
              color: AppColor.blackColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                      colorButton: AppColor.whiteColor,
                      child: const Text('Kembali'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  AppButton(
                      colorButton: AppColor.yellowColor,
                      child: const Text('Kembali'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          ),
        );
      });
}
