// ignore_for_file: public_member_api_docs, sort_constructors_first
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
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_patient_screen.dart';

class AjukanVerifikasiScreen extends StatefulWidget {
  static const route = '/deteksiKulitPasien';
  final Map<String, dynamic> ajuans;
  const AjukanVerifikasiScreen({
    super.key,
    required this.ajuans,
  });

  @override
  State<AjukanVerifikasiScreen> createState() => _AjukanVerifikasiScreenState();
}

class _AjukanVerifikasiScreenState extends State<AjukanVerifikasiScreen> {
  File? imageFile;
  final TextEditingController _keluhanController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String error = "";
  bool _showSpinner = false;
  bool _showSpinnerDokter = false;
  bool isPengajuan = false;

  List<Map<String, dynamic>> listDokter = [];
  int selectedDoctorIndex = 0;

  @override
  void initState() {
    super.initState();
    _keluhanController.text = widget.ajuans['complaint'] ?? '';
    _getListDokter();
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
      await updateDataToken(
          '/v1/patient/submission/${widget.ajuans['id']}', data);

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/melanoma.jpeg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ID Deteksi: ${widget.ajuans['id']}',
                      style: AppTypograph.label1.bold,
                    ),
                    const SizedBox(height: 8),
                    AppButton(
                        padding: 8,
                        onPressed: () {},
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Unduh Gambar',
                              style: AppTypograph.label2.bold
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ),
                        )),
                    Row(
                      children: [
                        const Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Melanoma',
                                  image: 'assets/icons/melanoma_icon.png',
                                  value: 'iya',
                                  color: AppColor.blackColor)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Keakuratan',
                                  image: 'assets/icons/spedometer_icon.png',
                                  value: '${widget.ajuans['percentage']}% '
                                      ' ${widget.ajuans['diagnosisAi']}',
                                  color: AppColor.maroonColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '*Hasil deteksi belum dipastikan benar karena web hanya memberikan indikasi awal, silahkan ajukan hasil verifikasi ke dokter.',
                      style: AppTypograph.label3.regular
                          .copyWith(color: AppColor.greyTextColor),
                    )
                  ],
                ),
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
                                    padding: EdgeInsets.all(context.as.padding),
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
                                                style: AppTypograph.label2.bold
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
                                                style: AppTypograph.label2.bold
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
