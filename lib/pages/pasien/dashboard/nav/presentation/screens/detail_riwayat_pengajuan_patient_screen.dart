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
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';

class DetailRiwayatPengajuanPatientScreen extends StatefulWidget {
  final String id;
  const DetailRiwayatPengajuanPatientScreen({
    super.key,
    required this.id,
  });

  @override
  State<DetailRiwayatPengajuanPatientScreen> createState() =>
      _DetailRiwayatPengajuanPatientScreenState();
}

class _DetailRiwayatPengajuanPatientScreenState
    extends State<DetailRiwayatPengajuanPatientScreen> {
  final TextEditingController _catatanController = TextEditingController(
    text: 'Tidak ada catatan',
  );
  String error = "";
  bool _showSpinner = false;
  Map<String, dynamic> ajuans = {};
  Map<String, dynamic> patient = {};
  @override
  void initState() {
    super.initState();
    getAjuan();
  }

  Future<void> getAjuan() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    try {
      String? token = await getToken();
      var response =
          await getDataToken('/v1/patient/submission/${widget.id}', token!);
      Map<String, dynamic> parsedData = response['data'];
      print(response);
      setState(() {
        ajuans = parsedData;
        patient = ajuans['patient'];
        _catatanController.text = ajuans['doctorNote'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Column(
          children: [
            const DevAppbar(
              title: 'Detail Riwayat Pengajuan',
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
                      const SizedBox(height: 16),
                      Center(
                        child: Text('Hasil deteksi sudah diverifikasi dokter',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label1.bold.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
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
                            Text('Diverifikasi Oleh',
                                style: AppTypograph.heading2.bold.copyWith(
                                  color: AppColor.blackColor,
                                )),
                            const SizedBox(height: 12),
                            Text(ajuans['verifiedBy'] ?? 'Belum Diverifikasi',
                                style: AppTypograph.label1.regular.copyWith(
                                  color: AppColor.blackColor,
                                )),
                          ])),
                      CardContainer(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Detail Pasien',
                              style: AppTypograph.heading2.bold.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Nama: ${patient['name']}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Nomor Telepon: ${patient['phone']}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Email: ${patient['email']}',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Umur: 21',
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
                            Text(ajuans['complaint'] ?? 'Tidak ada keluhan',
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
                                    value:
                                        '${ajuans['diagnosisAi'] ?? '0% Melanoma'} (Tidak aman)',
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
                      Center(
                        child: Text('Catatan Dokter',
                            textAlign: TextAlign.center,
                            style: AppTypograph.heading2.bold.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      CardContainer(
                          child: AppTextField(
                        title: 'Catatan:',
                        isReadOnly: true,
                        controller: _catatanController,
                        minLines: 5,
                      ))
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
