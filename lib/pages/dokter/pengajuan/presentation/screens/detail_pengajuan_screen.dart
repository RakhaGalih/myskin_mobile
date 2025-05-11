// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/utils/format_util.dart';
import 'package:myskin_mobile/pages/dokter/navbar_doctor_screen.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';

class DetailPengajuanScreen extends StatefulWidget {
  static const route = '/detailPengajuan';
  final String id;
  const DetailPengajuanScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailPengajuanScreen> createState() => _DetailPengajuanScreenState();
}

class _DetailPengajuanScreenState extends State<DetailPengajuanScreen> {
  bool? _selectedRadioButton;
  final TextEditingController _catatanController = TextEditingController();
  String error = "";
  bool _showSpinner = false;
  Map<String, dynamic> ajuans = {};
  Map<String, dynamic> patient = {};
  @override
  void initState() {
    super.initState();
    _getAjuan();
  }

  Future<void> _getAjuan() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    try {
      String? token = await getToken();
      var response = await getDataToken(
          '/v1/doctor/submissions/${widget.id}/detail', token!);
      Map<String, dynamic> parsedData = response['data'];
      print(response);
      setState(() {
        ajuans = parsedData;
        _catatanController.text = ajuans['doctorNote'];
        if (ajuans['diagnosis'] == 'Melanoma') {
          _selectedRadioButton = true;
        } else if (ajuans['diagnosis'] == 'Bukan Melanoma') {
          _selectedRadioButton = false;
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    } finally {
      setState(() {
        _showSpinner = false;
      });
    }
  }

  Future<void> _ajukanVerifikasi() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    dynamic response = {};
    try {
      Map<String, dynamic> data = {
        'diagnosis': (_selectedRadioButton == true)
            ? 'Melanoma'
            : (_selectedRadioButton == false)
                ? 'Bukan Melanoma'
                : null,
        'doctorNote': _catatanController.text,
      };
      await updateDataToken('/v1/doctor/submissions/${ajuans['id']}', data);

      if (mounted) {
        Navigator.pushReplacementNamed(context, NavbarDoctorScreen.route);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Column(
          children: [
            const DevAppbar(
              title: 'Detail Pengajuan',
              isBack: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: context.as.padding),
                child: SafeArea(
                  top: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/melanoma.jpeg',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'ID Deteksi: ${widget.id}',
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
                      CardContainer(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Detail Pasien',
                              style: AppTypograph.heading2.bold.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Nama: ${ajuans['patientName']}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Nomor Telepon: ${ajuans['patientPhone']}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Email: ${ajuans['patientEmail']}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text(
                              'Umur: ${getAge(ajuans['patientDob'] ?? DateTime.now().toString())}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                        ],
                      )),
                      CardContainer(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Keluhan',
                                style: AppTypograph.heading2.bold.copyWith(
                                  color: AppColor.blackColor,
                                )),
                            const SizedBox(height: 12),
                            Text(ajuans['complaint'] ?? 'Tidak ada data',
                                style: AppTypograph.label1.regular.copyWith(
                                  color: AppColor.blackColor,
                                )),
                          ])),
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
                                    value: ajuans['diagnosisAi'] ??
                                        'Tidak Diketahui',
                                    color: AppColor.maroonColor)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CardContainer(
                                child: IconItem(
                                    title: 'Pengajuan Verifikasi',
                                    image: 'assets/icons/clock_icon.png',
                                    value: (ajuans['verifiedBy'] == null)
                                        ? 'Pending'
                                        : 'Sudah',
                                    color: (ajuans['verifiedBy'] == null)
                                        ? AppColor.yellowTextColor
                                        : AppColor.greenColor)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CardContainer(
                                child: IconItem(
                              title: 'Status',
                              image: 'assets/icons/status_icon.png',
                              value: ajuans['status'] ?? 'Tidak ada status',
                              color: (ajuans['status'] == 'rejected')
                                  ? AppColor.maroonColor
                                  : (ajuans['status'] == 'pending')
                                      ? AppColor.yellowTextColor
                                      : AppColor.greenColor,
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('Verifikasi Hasil Deteksi',
                          style: AppTypograph.heading2.bold.copyWith(
                            color: AppColor.blackColor,
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      CardContainer(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '*Verifikasi Melanoma',
                            style: AppTypograph.label2.bold
                                .copyWith(color: AppColor.blackColor),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<bool>(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Melanoma',
                                    style: AppTypograph.label3.regular,
                                  ),
                                  value: true,
                                  groupValue: _selectedRadioButton,
                                  fillColor: const WidgetStatePropertyAll(
                                      AppColor.primaryColor),
                                  onChanged: (value) {
                                    if (ajuans['diagnosis'] == null ||
                                        ajuans['diagnosis'] ==
                                            'Belum dapat dipastikan') {
                                      setState(() {
                                        _selectedRadioButton = value!;
                                      });
                                    }
                                  },
                                  dense: true,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<bool>(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    'Bukan Melanoma',
                                    style: AppTypograph.label3.regular,
                                  ),
                                  fillColor: const WidgetStatePropertyAll(
                                      AppColor.primaryColor),
                                  value: false,
                                  groupValue: _selectedRadioButton,
                                  onChanged: (value) {
                                    if (ajuans['diagnosis'] == null ||
                                        ajuans['diagnosis'] ==
                                            'Belum dapat dipastikan') {
                                      setState(() {
                                        _selectedRadioButton = value!;
                                      });
                                    }
                                  },
                                  dense: true,
                                ),
                              ),
                            ],
                          ),
                          AppTextField(
                            title: 'Catatan:',
                            isReadOnly: ajuans['doctorNote'] != null,
                            onChanged: (value) {
                              setState(() {});
                              return null;
                            },
                            controller: _catatanController,
                            minLines: 5,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (ajuans['doctorNote'] == null)
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                  colorButton: (_catatanController.text.isEmpty)
                                      ? AppColor.greyTextColor
                                      : AppColor.primaryColor,
                                  child: Text('Ajukan Verifikasi',
                                      style: AppTypograph.label2.bold.copyWith(
                                          color: AppColor.whiteColor)),
                                  onPressed: () async {
                                    if (ajuans['diagnosis'] == null ||
                                        ajuans['diagnosis'] ==
                                            'Belum dapat dipastikan') {
                                      if (_catatanController.text.isNotEmpty) {
                                        await _ajukanVerifikasi();
                                      }
                                    }
                                  }),
                            )
                        ],
                      )),
                      SizedBox(
                        height: context.as.padding,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
