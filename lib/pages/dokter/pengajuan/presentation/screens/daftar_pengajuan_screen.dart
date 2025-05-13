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

class DaftarPengajuanScreen extends StatefulWidget {
  const DaftarPengajuanScreen({super.key});

  @override
  State<DaftarPengajuanScreen> createState() => _DaftarPengajuanScreenState();
}

class _DaftarPengajuanScreenState extends State<DaftarPengajuanScreen> {
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
          await getDataToken('/v1/doctor/submissions/pending?limit=5', token!);
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
          const DevAppbar(title: 'Daftar Pengajuan'),
          SearchTextField(controller: _searchController),
          (_showSpinner)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (ajuans.isEmpty)
                  ? const Center(
                      child: Text('Tidak ada pengajuan'),
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    'assets/images/melanoma.jpeg',
                                    width: double.infinity,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    ajuans[index]['patientName'] ??
                                        'Tidak ada data',
                                    style: AppTypograph.label1.bold.copyWith(
                                      color: AppColor.blackColor,
                                    )),
                                const SizedBox(height: 4),
                                Text(
                                    getFormattedDate(DateTime.parse(
                                        ajuans[index]['submittedAt'])),
                                    style: AppTypograph.label2.regular.copyWith(
                                      color: AppColor.greyTextColor,
                                    )),
                                const SizedBox(height: 12),
                                Row(children: [
                                  Text('Melanoma: ',
                                      style: AppTypograph.label2.bold.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                  Text(
                                      ajuans[index]['diagnosisAi'].toString() ??
                                          'Tidak ada data',
                                      style: AppTypograph.label2.bold.copyWith(
                                          color:
                                              ajuans[index]['diagnosisAi'] >= 50
                                                  ? AppColor.redTextColor
                                                  : AppColor.greenColor)),
                                ]),
                                const SizedBox(height: 8),
                                AppButton(
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
                                        child: Text(
                                          'Detail Pengajuan',
                                          style: AppTypograph.label2.bold
                                              .copyWith(
                                                  color: AppColor.whiteColor),
                                        ),
                                      ),
                                    )),
                              ],
                            ));
                          }),
                    ),
        ],
      ),
    );
  }
}
