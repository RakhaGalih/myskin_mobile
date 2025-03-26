import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_patient_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                      'assets/images/loginImage.jpeg',
                      height: context.as.appWidth - 60,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 16,
                ),
                Text('Masuk', style: AppTypograph.heading2.bold),
                const SizedBox(
                  height: 4,
                ),
                Text('Masuk untuk tetap terhubung',
                    style: AppTypograph.label2.regular.copyWith(
                      color: AppColor.greyTextColor,
                    )),
                AppTextField(title: 'Email', controller: _emailController),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  title: 'Kata Sandi',
                  controller: _passwordController,
                  isPassword: true,
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
                      'Ingat saya',
                      style: AppTypograph.label2.regular
                          .copyWith(color: AppColor.blackColor),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Lupa kata sandi?',
                          style: AppTypograph.label2.regular
                              .copyWith(color: AppColor.blackColor),
                        ))
                  ],
                ),
                AppButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, NavbarPatientScreen.route);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Masuk',
                          style: AppTypograph.label1.bold
                              .copyWith(color: AppColor.whiteColor),
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
                      'Belum memiliki akun? ',
                      style: AppTypograph.label2.regular,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/daftar');
                      },
                      child: Text(
                        'Klik di sini untuk daftar',
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
