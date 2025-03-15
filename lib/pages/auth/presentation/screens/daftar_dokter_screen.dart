import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/auth/presentation/components/app_dropdown.dart';
import 'package:myskin_mobile/pages/auth/presentation/components/app_file_picker.dart';
import 'package:myskin_mobile/pages/dokter/navbar_doctor_screen.dart';

class DaftarDokterScreen extends StatefulWidget {
  static const route = '/daftardokter';
  const DaftarDokterScreen({super.key});

  @override
  State<DaftarDokterScreen> createState() => _DaftarDokterScreenState();
}

class _DaftarDokterScreenState extends State<DaftarDokterScreen> {
  int _selectedForm = 0;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _konfirmasiPasswordController =
      TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.as.loginPadding),
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
                if (_selectedForm == 0)
                  Column(
                    children: [
                      Text('Daftar Dokter', style: AppTypograph.heading2.bold),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Buat akun dokter Anda',
                          style: AppTypograph.label2.regular.copyWith(
                            color: AppColor.greyTextColor,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                          title: 'Nama Lengkap', controller: _namaController),
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
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                          title: 'Alamat Praktik',
                          controller: _alamatController),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                if (_selectedForm == 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppDropDown(
                                kategoriItems: const ['tes', 'aa'],
                                title: 'Spesialisasi',
                                onItemSelected: (value) {}),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: AppTextField(
                                title: 'Nomor Registrasi Dokter',
                                controller: _emailController),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppFilePicker(
                          onDateTimeSelected: (value) {},
                          title: 'Surat Tanda Registrasi'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppFilePicker(
                                onDateTimeSelected: (value) {},
                                title: 'Ijazah Kedokteran'),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: AppFilePicker(
                                onDateTimeSelected: (value) {},
                                title: 'Sertifikat Keahlian (opsional)'),
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
                              title: 'Institusi Kerja',
                              controller: _passwordController,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: AppTextField(
                              title: 'Pengalaman Kerja',
                              controller: _konfirmasiPasswordController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                          title: 'Publikasi Ilmiah (opsional)',
                          hintext: 'Masukkan Publikasi Ilmiah',
                          controller: _namaController),
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
                    ],
                  ),
                AppButton(
                    onPressed: () {
                      if (_selectedForm == 0) {
                        setState(() {
                          _selectedForm = 1;
                        });
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed(NavbarDoctorScreen.route);
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          (_selectedForm == 0) ? 'Next' : 'Daftar',
                          style: AppTypograph.label1.bold
                              .copyWith(color: AppColor.whiteColor),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedForm = 0;
                        });
                      },
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            color: (_selectedForm == 0)
                                ? AppColor.primaryColor
                                : AppColor.greyColor,
                            shape: BoxShape.circle),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedForm = 1;
                        });
                      },
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            color: (_selectedForm == 0)
                                ? AppColor.greyColor
                                : AppColor.primaryColor,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
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
