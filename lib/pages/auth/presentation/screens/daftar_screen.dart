import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/auth/presentation/components/app_datetime_picker.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_dokter_screen.dart';

class DaftarScreen extends StatefulWidget {
  static const route = '/daftar';
  const DaftarScreen({super.key});

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final TextEditingController _namaDepanController = TextEditingController();
  final TextEditingController _namaBelakangController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _konfirmasiPasswordController =
      TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.as.padding),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/dokter.jpeg',
                      height: context.as.appWidth - 60,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 16,
                ),
                Text('Daftar', style: AppTypograph.heading2.bold),
                const SizedBox(
                  height: 4,
                ),
                Text('Buat akun Anda',
                    style: AppTypograph.label2.regular.copyWith(
                      color: AppColor.greyTextColor,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                          title: 'Nama Depan',
                          controller: _namaDepanController),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: AppTextField(
                          title: 'Nama Belakang',
                          controller: _namaBelakangController),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                          title: 'Email', controller: _emailController),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: AppTextField(
                          title: 'No Telepon',
                          isNumber: true,
                          controller: _noTeleponController),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AppDatePicker(
                    onDateTimeSelected: (dateTime) {
                      print(dateTime);
                    },
                    title: 'Tanggal Lahir'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        title: 'Kata Sandi',
                        controller: _passwordController,
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: AppTextField(
                        title: 'Konfirmasi Kata Sandi',
                        controller: _konfirmasiPasswordController,
                        isPassword: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: AppColor.whiteColor,
                      activeColor: AppColor.primaryColor,
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
                        });
                      },
                    ),
                    Text(
                      'Saya setuju dengan persyaratan penggunaan',
                      style: AppTypograph.label2.regular
                          .copyWith(color: AppColor.blackColor),
                    ),
                  ],
                ),
                AppButton(
                    onPressed: () {},
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Daftar',
                          style: AppTypograph.label1.bold
                              .copyWith(color: AppColor.whiteColor),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Atau',
                  style: AppTypograph.label2.regular,
                ),
                const SizedBox(
                  height: 8,
                ),
                AppButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(DaftarDokterScreen.route);
                    },
                    isOutline: true,
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Daftar sebagai Dokter',
                          style: AppTypograph.label1.bold
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: AppTypograph.label2.regular
                            .copyWith(color: AppColor.blackColor),
                        children: [
                          const TextSpan(
                              text:
                                  'Email harus mengandung salah satu dari domain berikut:'),
                          TextSpan(
                              text: '@pasien.myskin.ac.id ',
                              style: AppTypograph.label2.regular
                                  .copyWith(color: AppColor.blueColor)),
                          const TextSpan(
                              text: 'untuk Login sebagai pasien, atau '),
                          TextSpan(
                              text: '@dokter.myskin.ac.id ',
                              style: AppTypograph.label2.regular
                                  .copyWith(color: AppColor.blueColor)),
                          const TextSpan(text: 'untuk Login sebagai dokter.')
                        ])),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah memiliki akun? ',
                      style: AppTypograph.label2.regular,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Text(
                        'Masuk',
                        style: AppTypograph.label2.bold
                            .copyWith(color: AppColor.blueColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
