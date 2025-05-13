import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/utils/dialog_util.dart';
import 'package:myskin_mobile/core/utils/format_util.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/detail_riwayat_pengajuan_patient_screen.dart';

class RiwayatPengajuanScreen extends StatefulWidget {
  static const route = '/riwayatPengajuanPasien';
  const RiwayatPengajuanScreen({super.key});

  @override
  State<RiwayatPengajuanScreen> createState() => _RiwayatPengajuanScreenState();
}

class _RiwayatPengajuanScreenState extends State<RiwayatPengajuanScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> ajuans = [];
  String error = "";
  bool _showSpinner = false;

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
      var response = await getDataToken('/v1/patient/submissions', token!);
      List<Map<String, dynamic>> parsedData = (response['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(response);
      setState(() {
        ajuans = parsedData;
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

  Future<void> deleteAjuan(String id) async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    try {
      String? token = await getToken();
      await deleteDataToken('/v1/patient/submission/$id', token!);
      await getAjuan();
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
      body: Column(
        children: [
          const DevAppbar(
            title: 'Riwayat Pengajuan',
            isBack: true,
          ),
          SearchTextField(controller: _searchController),
          (_showSpinner)
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColor.primaryColor),
                )
              : (error.isNotEmpty)
                  ? Center(
                      child: Text(error),
                    )
                  : (ajuans.isEmpty)
                      ? const Center(
                          child: Text('Tidak ada data'),
                        )
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.as.padding),
                              itemCount: ajuans.length,
                              itemBuilder: (context, index) {
                                return CardContainer(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerifikasiItem(
                                      title: 'Tanggal Pengajuan',
                                      value: Text(
                                          (ajuans[index]['submittedAt'] == null)
                                              ? 'Undefined'
                                              : DateFormat('dd/MM/yyyy').format(
                                                  DateTime.parse(ajuans[index]
                                                      ['submittedAt'])),
                                          textAlign: TextAlign.center,
                                          style: AppTypograph.label2.regular
                                              .copyWith(
                                            color: AppColor.blackColor,
                                          )),
                                    ),
                                    const SizedBox(height: 12),
                                    VerifikasiItem(
                                      title: 'Diagnosis AI',
                                      value: Text(
                                          '${ajuans[index]['diagnosisAi'] ?? '0.00% Melanoma'}',
                                          textAlign: TextAlign.center,
                                          style: AppTypograph.label2.bold
                                              .copyWith(
                                                  color: getMelanomaColor(
                                                      ajuans[index]
                                                              ['diagnosisAi'] ??
                                                          '0% Melanoma'))),
                                    ),
                                    const SizedBox(height: 12),
                                    VerifikasiItem(
                                        title: 'Gambar',
                                        value: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              'assets/images/melanoma.jpeg',
                                              width: double.infinity,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                    const SizedBox(height: 12),
                                    VerifikasiItem(
                                      title: 'Keluhan',
                                      value: Text(
                                          ajuans[index]['complaint'] ??
                                              'Tidak ada keluhan',
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTypograph.label2.regular
                                              .copyWith(
                                            color: AppColor.blackColor,
                                          )),
                                    ),
                                    const SizedBox(height: 12),
                                    VerifikasiItem(
                                      title: 'Status',
                                      value: Text(
                                          ajuans[index]['status'] ??
                                              'Undefined',
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTypograph.label2.bold.copyWith(
                                            color: (ajuans[index]['status'] ==
                                                    'rejected')
                                                ? AppColor.maroonColor
                                                : (ajuans[index]['status'] ==
                                                        'pending')
                                                    ? AppColor.yellowTextColor
                                                    : AppColor.greenColor,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    VerifikasiItem(
                                      title: 'Tanggal Verifikasi',
                                      value: Text(
                                          (ajuans[index]['verifiedAt'] == null)
                                              ? 'Undefined'
                                              : DateFormat('dd/MM/yyyy').format(
                                                  DateTime.parse(ajuans[index]
                                                      ['verifiedAt'])),
                                          textAlign: TextAlign.center,
                                          style: AppTypograph.label2.regular
                                              .copyWith(
                                            color: AppColor.blackColor,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    VerifikasiItem(
                                      title: 'Verified By',
                                      value: Text(
                                          ajuans[index]['verifiedBy'] ??
                                              'Belum Diverifikasi',
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTypograph.label2.bold.copyWith(
                                            color: AppColor.blackColor,
                                          )),
                                    ),
                                    const SizedBox(height: 12),
                                    VerifikasiItem(
                                      title: 'Melanoma',
                                      value: Text(
                                          '${ajuans[index]['diagnosis'] ?? 'Tidak ada data'}',
                                          textAlign: TextAlign.center,
                                          style: AppTypograph.label2.regular
                                              .copyWith(
                                            color: AppColor.blackColor,
                                          )),
                                    ),
                                    const SizedBox(height: 12),
                                    VerifikasiItem(
                                      title: 'Catatan Dokter',
                                      value: Text(
                                          ajuans[index]['doctorNote'] ??
                                              'Tidak ada catatan',
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              AppTypograph.label2.bold.copyWith(
                                            color: AppColor.blackColor,
                                          )),
                                    ),
                                    const SizedBox(height: 12),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: AppButton(
                                                padding: 12,
                                                colorButton: AppColor.blueColor,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                      return DetailRiwayatPengajuanPatientScreen(
                                                        id: ajuans[index]['id']
                                                            .toString(),
                                                      );
                                                    }),
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.info,
                                                  color: AppColor.whiteColor,
                                                )),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: AppButton(
                                                padding: 12,
                                                colorButton:
                                                    AppColor.redButtonColor,
                                                onPressed: () {
                                                  hapusDialog(
                                                    context,
                                                    () async {
                                                      Navigator.pop(context);
                                                      await deleteAjuan(
                                                          ajuans[index]['id']
                                                              .toString());
                                                    },
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: AppColor.whiteColor,
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                              }),
                        ),
        ],
      ),
    );
  }
}
