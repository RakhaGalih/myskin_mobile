import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/components/app_photo_picker.dart';

class DeteksiKulitScreen extends StatefulWidget {
  static const route = '/deteksiKulitPasien';
  const DeteksiKulitScreen({super.key});

  @override
  State<DeteksiKulitScreen> createState() => _DeteksiKulitScreenState();
}

class _DeteksiKulitScreenState extends State<DeteksiKulitScreen> {
  File? imageFile;
  final TextEditingController _keluhanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
              AppPhotoPicker(onImageSelected: (image) {
                setState(() {
                  imageFile = image;
                });
              }),
              if (imageFile == null)
                Column(
                  children: [
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
              if (imageFile != null)
                Column(
                  children: [
                    SizedBox(height: context.as.loginPadding),
                    Form(
                      key: _formKey,
                      child: AppTextField(
                        title: 'Keluhan:',
                        controller: _keluhanController,
                        minLines: 5,
                        onChanged: (value) {
                          setState(() {});
                          print(value);
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                          colorButton:
                              (_keluhanController.text.isEmpty)
                                  ? AppColor.greyTextColor
                                  : AppColor.primaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Kirim',
                                style: AppTypograph.label1.bold
                                    .copyWith(color: AppColor.whiteColor),
                              ),
                            ),
                          )),
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
