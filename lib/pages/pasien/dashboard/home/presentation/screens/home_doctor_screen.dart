import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class HomeDoctorScreen extends StatelessWidget {
  const HomeDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Dokter',
          style: AppTypograph.heading2.bold.copyWith(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
