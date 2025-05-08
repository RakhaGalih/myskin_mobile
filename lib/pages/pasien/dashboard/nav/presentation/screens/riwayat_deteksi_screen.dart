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
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/detail_deteksi_patient_screen.dart';

class RiwayatDeteksiScreen extends StatefulWidget {
  static const route = '/riwayatDeteksiPasien';
  const RiwayatDeteksiScreen({super.key});

  @override
  State<RiwayatDeteksiScreen> createState() => _RiwayatDeteksiScreenState();
}

class _RiwayatDeteksiScreenState extends State<RiwayatDeteksiScreen> {
  List<Map<String, dynamic>> ajuans = [];
  String error = "";
  bool _showSpinner = false;
  final TextEditingController _searchController = TextEditingController();

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
      var response = await getDataToken('/v1/patient/detections', token!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(
            title: 'Riwayat Deteksi',
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
                                                  color:
                                                      AppColor.redTextColor)),
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
                                      title: 'Pengajuan',
                                      value: Text('Belum',
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTypograph.label2.bold.copyWith(
                                            color: AppColor.redTextColor,
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
                                                ? AppColor.redTextColor
                                                : AppColor.greenColor,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
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
                                                          builder: (context) =>
                                                              DetailDeteksiPatientScreen(
                                                                deteksi: ajuans[
                                                                    index],
                                                              )));
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
                                                onPressed: () {},
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: AppColor.whiteColor,
                                                )),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: AppButton(
                                                padding: 12,
                                                colorButton:
                                                    AppColor.yellowColor,
                                                onPressed: () {
                                                  updateDialog(
                                                    context,
                                                    () {},
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.edit_document,
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
