import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/utils/format_util.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/components/app_photo_picker.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_patient_screen.dart';

class DeteksiKulitScreen extends StatefulWidget {
  static const route = '/deteksiKulitPasien';
  const DeteksiKulitScreen({super.key});

  @override
  State<DeteksiKulitScreen> createState() => _DeteksiKulitScreenState();
}

class _DeteksiKulitScreenState extends State<DeteksiKulitScreen> {
  File? imageFile;
  final TextEditingController _keluhanController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String error = "";
  bool _showSpinner = false;
  bool _showSpinnerDokter = false;
  bool isPengajuan = false;
  Map<String, dynamic> ajuans = {};
  List<Map<String, dynamic>> listDokter = [];
  int selectedDoctorIndex = 0;

  Future<void> _submitPengajuan() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    dynamic response = {};
    try {
      String? token = await getToken();
      var responseWelcome = await getDataToken('/v1/welcome', token!);

      int id = responseWelcome['accountId'];
      Map<String, String> data = {
        'patient_id': id.toString(),
      };
      response =
          await postDataTokenWithImage("/v1/submissions", data, imageFile!);
      Map<String, dynamic> parsedData = response['data'];
      print(response);
      setState(() {
        ajuans = parsedData;
      });
      print(response['message']);
    } catch (e) {
      setState(() {
        _showSpinner = false;
        error = "${response['message']}";
      });
      print('Login error: $e');
      print(response);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> _ajukanVerifikasi(int dcotorId) async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    dynamic response = {};
    try {
      Map<String, dynamic> data = {
        'doctorId': dcotorId,
        'complaint': _keluhanController.text,
      };
      await updateDataToken('/v1/patient/submission/${ajuans['id']}', data);

      if (mounted) {
        Navigator.pushReplacementNamed(context, NavbarPatientScreen.route);
        const snackBar = SnackBar(
          content: Text('Data berhasil ditambahkan!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      print(response['message']);
    } catch (e) {
      setState(() {
        _showSpinner = false;
        error = "${response['message']}";
      });
      print('Login error: $e');
      print(response);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  Future<void> _getListDokter() async {
    error = "";
    setState(() {
      _showSpinnerDokter = true;
    });
    try {
      String? token = await getToken();
      var response = await getDataToken('/v1/patient/doctors?limit=5', token!);
      List<Map<String, dynamic>> parsedData = (response['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(response);
      setState(() {
        listDokter = parsedData;
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    } finally {
      setState(() {
        _showSpinnerDokter = false;
      });
    }
  }

  Future<void> _getListDokterOnSearch(String keyword) async {
    error = "";
    setState(() {
      _showSpinnerDokter = true;
    });
    try {
      String? token = await getToken();
      var response =
          await getDataToken('/v1/patient/doctors?search=$keyword', token!);
      List<Map<String, dynamic>> parsedData = (response['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(response);
      setState(() {
        listDokter = parsedData;
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    } finally {
      setState(() {
        _showSpinnerDokter = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Column(children: [
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
                AppPhotoPicker(onImageSelected: (image) async {
                  setState(() {
                    imageFile = image;
                  });
                  await _submitPengajuan();
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
                      Row(
                        children: [
                          Expanded(
                            child: CardContainer(
                                child: IconItem(
                                    title: 'Melanoma',
                                    image: 'assets/icons/melanoma_icon.png',
                                    value: isMelanoma(ajuans['diagnosisAi'] ??
                                            '0% Melanoma')
                                        ? 'Iya'
                                        : 'Tidak',
                                    color: AppColor.blackColor)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CardContainer(
                                child: IconItem(
                                    title: 'Keakuratan',
                                    image: 'assets/icons/spedometer_icon.png',
                                    value: '${ajuans['percentage']}% '
                                        ' ${ajuans['diagnosisAi']}',
                                    color: AppColor.maroonColor)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                            colorButton: AppColor.primaryColor,
                            isOutline: isPengajuan,
                            onPressed: () async {
                              setState(() {
                                isPengajuan = !isPengajuan;
                              });
                              if (isPengajuan) {
                                await _getListDokter();
                              }
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Ajukan Verifikasi/Keluhan',
                                  style: AppTypograph.label1.bold.copyWith(
                                      color: isPengajuan
                                          ? AppColor.primaryColor
                                          : AppColor.whiteColor),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                if (isPengajuan)
                  Column(
                    children: [
                      SizedBox(height: context.as.loginPadding),
                      Form(
                        key: _formKey,
                        child: AppTextField(
                          title: 'Keluhan',
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
                      SearchTextField(
                        controller: _searchController,
                        hintText: 'Cari dokter',
                        isPadding: false,
                        onChanged: (value) async {
                          if (value!.isNotEmpty) {
                            await _getListDokterOnSearch(value);
                          } else {
                            await _getListDokter();
                          }
                        },
                      ),
                      (_showSpinnerDokter)
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            )
                          : (listDokter.isEmpty)
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text('Tidak ada dokter'),
                                  ),
                                )
                              : SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    itemCount: listDokter.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Container(
                                      margin: EdgeInsets.only(
                                          top: context.as.padding,
                                          right: context.as.padding,
                                          bottom: context.as.padding),
                                      padding:
                                          EdgeInsets.all(context.as.padding),
                                      decoration: BoxDecoration(
                                        color: AppColor.whiteColor,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: selectedDoctorIndex == index
                                                ? AppColor.primaryColor
                                                : AppColor.whiteColor),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.greyTextColor
                                                .withOpacity(0.1),
                                            blurRadius: 12.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.asset(
                                              'assets/images/profilDokter.png',
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Expanded(
                                            child: SizedBox(
                                              width: 120,
                                              child: Center(
                                                child: Text(
                                                  listDokter[index]['name'] ??
                                                      'Tidak ada',
                                                  textAlign: TextAlign.center,
                                                  style: AppTypograph
                                                      .label2.bold
                                                      .copyWith(
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          AppButton(
                                              isOutline:
                                                  index == selectedDoctorIndex,
                                              padding: 4,
                                              child: Text(
                                                  index == selectedDoctorIndex
                                                      ? 'Dokter Dipilih'
                                                      : 'Pilih Dokter',
                                                  style: AppTypograph
                                                      .label2.bold
                                                      .copyWith(
                                                          color: index ==
                                                                  selectedDoctorIndex
                                                              ? AppColor
                                                                  .primaryColor
                                                              : AppColor
                                                                  .whiteColor)),
                                              onPressed: () {
                                                setState(() {
                                                  selectedDoctorIndex = index;
                                                });
                                                 print(listDokter[selectedDoctorIndex]['name']);
                                                print(listDokter[selectedDoctorIndex]['id']);
                                              })
                                        ],
                                      ),
                                    ),
                                  )),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                            colorButton: (_keluhanController.text.isEmpty)
                                ? AppColor.greyTextColor
                                : AppColor.primaryColor,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print(listDokter[selectedDoctorIndex]['id']);
                                await _ajukanVerifikasi(
                                    listDokter[selectedDoctorIndex]['id']);
                              } else {
                                print('error');
                              }
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
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
