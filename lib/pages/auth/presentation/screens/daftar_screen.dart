import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/auth/presentation/components/app_datetime_picker.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_dokter_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_patient_screen.dart';

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
  final TextEditingController _konfirmasiPasswordController =
      TextEditingController();
  DateTime? _tanggalLahir;
  bool agreeWTnC = false;
  final _formKey = GlobalKey<FormState>();

  String error = "";
  bool _showSpinner = false;
  Future<void> _register() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    Map<String, dynamic> response = {};
    try {
      print(_tanggalLahir);
      String formattedDate = DateFormat('yyyy-MM-dd').format(_tanggalLahir!);
      Map<String, dynamic> data = {
        'name': "${_namaDepanController.text} ${_namaBelakangController.text}",
        'email': _emailController.text,
        'phone': _noTeleponController.text,
        'dob': formattedDate,
        'password': _passwordController.text,
        'password_confirmation': _konfirmasiPasswordController.text,
      };
      response = await postData("/v1/auth/register/patient", data);
      Map<String, dynamic> userData = response['data'];
      String token = response['token']; // Ambil token dari response
      await saveToken(token, 'patient');
      if (mounted) {
        Navigator.pushReplacementNamed(context, NavbarPatientScreen.route);
      }
      print('berhasil login!');
      String? accessToken = await getToken();
      print(accessToken);
    } catch (e) {
      setState(() {
        _showSpinner = false;
        error = "${response['message']}";
      });

      if (error == "null") {
        setState(() {
          error = "Network Error. Please change your connection";
        });
      }
      print('Register error: $e');
      print(response);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(context.as.loginPadding),
              child: Form(
                key: _formKey,
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
                          setState(() {
                            _tanggalLahir = dateTime;
                          });
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
                            validator: (p0) => (p0 == null || p0.isEmpty)
                                ? 'Tolong masukkan kata sandi'
                                : (p0.length < 8)
                                    ? 'Kata sandi minimal 8 karakter'
                                    : null,
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
                          value: agreeWTnC,
                          onChanged: (value) {
                            setState(() {
                              agreeWTnC = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Saya setuju dengan persyaratan penggunaan',
                            style: AppTypograph.label2.regular
                                .copyWith(color: AppColor.blackColor),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      error,
                      style: AppTypograph.label2.medium
                          .copyWith(color: AppColor.redButtonColor),
                    ),
                    AppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _register();
                          }
                        },
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
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
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
        ),
      ),
    );
  }
}
