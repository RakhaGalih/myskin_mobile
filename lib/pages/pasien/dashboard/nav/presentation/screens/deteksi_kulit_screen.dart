import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/components/app_photo_picker.dart';

class DeteksiKulitScreen extends StatelessWidget {
  static const route = '/deteksiKulitPasien';
  const DeteksiKulitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const DevAppbar(
        title: 'Deteksi Kanker Kulit',
        isBack: true,
      ),
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.as.loginPadding),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Masukkan gambar untuk mendeteksi kanker dari gambar yang diberikan',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: context.as.loginPadding),
              AppPhotoPicker(onImageSelected: (image) {}),
              SizedBox(height: context.as.loginPadding),
              Row(
                children: [
                  Text('1. Format: JPEG, PNG ',
                      style: AppTypograph.label2.regular),
                  Text(
                    '*',
                    style: AppTypograph.label2.regular
                        .copyWith(color: AppColor.redTextColor),
                  )
                ],
              ),
              Row(
                children: [
                  Text('2. Ukuran: Maksimum 5 MB ',
                      style: AppTypograph.label2.regular),
                  Text(
                    '*',
                    style: AppTypograph.label2.regular
                        .copyWith(color: AppColor.redTextColor),
                  )
                ],
              ),
              Row(
                children: [
                  Text('3. Resolusi: Minimal 800 x 600 piksel ',
                      style: AppTypograph.label2.regular),
                  Text(
                    '*',
                    style: AppTypograph.label2.regular
                        .copyWith(color: AppColor.redTextColor),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
