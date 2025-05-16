import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
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
  final TextEditingController _noRegistrasiController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _institusiController = TextEditingController();
  final TextEditingController _pengalamanKerjaController =
      TextEditingController();
  final TextEditingController _publikasiIlmiahController =
      TextEditingController();

  bool rememberMe = false;
  String? kategori;
  File? _selectedFileTandaRegistrasi;
  File? _selectedFileIjazah;
  File? _selectedFileSertifikat;

  bool _showSpinner = false;
  String? error;

  Future<void> _registerDokter() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    Map<String, dynamic> response = {};
    try {
      Map<String, String> data = {
        'name': _namaController.text,
        'email': _emailController.text,
        'phone': _noTeleponController.text,
        'password': _passwordController.text,
        'password_confirmation': _konfirmasiPasswordController.text,
        'practice_address': _noRegistrasiController.text,
        'specialization': kategori!,
        'license_number': _emailController.text,
        'current_institution': _institusiController.text,
        'work_history': _pengalamanKerjaController.text,
        'publications': _publikasiIlmiahController.text,
      };
      response = await postDataDoctorRegister(
          '/v1/auth/register/doctor',
          data,
          _selectedFileTandaRegistrasi,
          _selectedFileIjazah,
          _selectedFileSertifikat);
      Map<String, dynamic> userData = response['data'];
      String token = response['token']; // Ambil token dari response
      await saveToken(token, 'doctor');
      if (mounted) {
        Navigator.pushReplacementNamed(context, NavbarDoctorScreen.route);
      }
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
                        Text('Daftar Dokter',
                            style: AppTypograph.heading2.bold),
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
                        Text('Profil Dokter Spesialis',
                            style: AppTypograph.heading2.bold),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Detail Profesional dan Dokumen Pendukung',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.greyTextColor,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppDropDown(
                                  kategoriItems: const [
                                    '(Sp.PD) Spesialis Penyakit Dalam',
                                    '(Sp.B) Spesialis Bedah Umum',
                                    '(Sp.BS) Spesialis Bedah Saraf',
                                    '(Sp.OT) Spesialis Bedah Ortopedi'
                                  ],
                                  title: 'Spesialisasi',
                                  onItemSelected: (selectedItem) {
                                    // Handle the selected item here
                                    setState(() {
                                      kategori = selectedItem!;
                                    });
                                    print('Selected item: $selectedItem');
                                  }),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: AppTextField(
                                  title: 'Nomor Registrasi Dokter',
                                  controller: _noRegistrasiController),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppFilePicker(
                          onFileSelected: (value) {
                            setState(() {
                              _selectedFileTandaRegistrasi = value;
                            });
                          },
                          title: 'Surat Tanda Registrasi',
                          selectedFile: _selectedFileTandaRegistrasi,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppFilePicker(
                                  onFileSelected: (value) {
                                    setState(() {
                                      _selectedFileIjazah = value;
                                    });
                                  },
                                  title: 'Ijazah Kedokteran',
                                  selectedFile: _selectedFileIjazah),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: AppFilePicker(
                                onFileSelected: (value) {
                                  setState(() {
                                    _selectedFileSertifikat = value;
                                  });
                                },
                                title: 'Sertifikat Keahlian (opsional)',
                                selectedFile: _selectedFileSertifikat,
                              ),
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
                                controller: _institusiController,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: AppTextField(
                                title: 'Pengalaman Kerja',
                                controller: _pengalamanKerjaController,
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
                            controller: _publikasiIlmiahController),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
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
                              Expanded(
                                child: Text(
                                  'Saya setuju dengan persyaratan penggunaan',
                                  style: AppTypograph.label2.regular
                                      .copyWith(color: AppColor.blackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      if (_selectedForm == 1)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: AppButton(
                                isOutline: true,
                                onPressed: () {
                                  if (_selectedForm == 1) {
                                    setState(() {
                                      _selectedForm = 0;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      'Sebelumnya',
                                      style: AppTypograph.label1.bold.copyWith(
                                          color: AppColor.primaryColor),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      Expanded(
                        child: AppButton(
                            onPressed: () async {
                              if (_selectedForm == 0) {
                                setState(() {
                                  _selectedForm = 1;
                                });
                              } else {
                                if (_namaController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _noTeleponController.text.isEmpty ||
                                    _konfirmasiPasswordController
                                        .text.isEmpty ||
                                    _alamatController.text.isEmpty ||
                                    kategori == null ||
                                    _selectedFileIjazah == null ||
                                    _selectedFileTandaRegistrasi == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Silahkan lengkapi semua data',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  await _registerDokter();
                                }
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
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
