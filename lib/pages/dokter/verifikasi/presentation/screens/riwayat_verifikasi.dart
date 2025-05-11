import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/utils/format_util.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/detail_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';

class RiwayatVerifikasiScreen extends StatefulWidget {
  const RiwayatVerifikasiScreen({super.key});

  @override
  State<RiwayatVerifikasiScreen> createState() =>
      _RiwayatVerifikasiScreenState();
}

class _RiwayatVerifikasiScreenState extends State<RiwayatVerifikasiScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _showSpinner = false;
  String error = "";
  List<Map<String, dynamic>> ajuans = [];
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
          await getDataToken('/v1/doctor/submissions/history?limit=5', token!);
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
          const DevAppbar(title: 'Riwayat Verifikasi'),
          SearchTextField(controller: _searchController),
          (_showSpinner)
              ? const Center(
                  child: CircularProgressIndicator(),
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
                                      getFormattedDate(DateTime.parse(
                                          ajuans[index]['submittedAt'])),
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                const SizedBox(height: 12),
                                VerifikasiItem(
                                  title: 'Pasien',
                                  value: Text(
                                      ajuans[index]['patientName'] ??
                                          'Tidak ada data',
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                const SizedBox(height: 12),
                                VerifikasiItem(
                                  title: 'Diagnosis AI',
                                  value: Text(
                                      ajuans[index]['diagnosisAi'] ??
                                          'Tidak ada data',
                                      style: AppTypograph.label2.bold.copyWith(
                                        color: AppColor.greenColor,
                                      )),
                                ),
                                const SizedBox(height: 12),
                                VerifikasiItem(
                                  title: 'Verifikasi Dokter',
                                  value: Text(
                                      ajuans[index]['diagnosis'] ??
                                          'Tidak ada data',
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                const SizedBox(height: 12),
                                VerifikasiItem(
                                  title: 'Catatan',
                                  value: Text(
                                      ajuans[index]['doctorNote'] ??
                                          'Tidak ada data',
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                const SizedBox(height: 12),
                                VerifikasiItem(
                                  title: 'Detail',
                                  value: AppButton(
                                      padding: 8,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPengajuanScreen(
                                                        id: ajuans[index]['id']
                                                            .toString())));
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.remove_red_eye_outlined,
                                                size: 16,
                                                color: AppColor.whiteColor,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  'Detail Pengajuan',
                                                  textAlign: TextAlign.center,
                                                  style: AppTypograph
                                                      .label3.bold
                                                      .copyWith(
                                                          color: AppColor
                                                              .whiteColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ));
                          }),
                    ),
        ],
      ),
    );
  }
}
