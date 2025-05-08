import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';

class DaftarPasienScreen extends StatefulWidget {
  static const route = '/daftarPasien';
  const DaftarPasienScreen({super.key});

  @override
  State<DaftarPasienScreen> createState() => _DaftarPasienScreenState();
}

class _DaftarPasienScreenState extends State<DaftarPasienScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSpinnerPatient = false;
  String error = "";
  List<Map<String, dynamic>> listPatients = [];

  @override
  void initState() {
    super.initState();
    getPatient();
  }

  Future<void> getPatient() async {
    error = "";
    setState(() {
      _showSpinnerPatient = true;
    });
    try {
      String? token = await getToken();
      var response = await getDataToken('/v1/doctor/patients', token!);
      List<Map<String, dynamic>> parsedData = (response['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(response);
      setState(() {
        listPatients = parsedData;
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    }
    setState(() {
      _showSpinnerPatient = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(
            title: 'Daftar Pasien',
            isBack: true,
          ),
          SearchTextField(controller: _searchController),
          (_showSpinnerPatient)
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColor.primaryColor),
                )
              : Expanded(
                  child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.as.padding),
                      itemCount: listPatients.length,
                      itemBuilder: (context, index) {
                        return CardContainer(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VerifikasiItem(
                              title: 'Nama',
                              value: Text(
                                  listPatients[index]['name'] ?? 'Tidak ada',
                                  style: AppTypograph.label2.regular.copyWith(
                                    color: AppColor.blackColor,
                                  )),
                            ),
                            const SizedBox(height: 12),
                            VerifikasiItem(
                              title: 'Nomor Telepon',
                              value: Text(
                                  listPatients[index]['phone'] ?? 'Tidak ada',
                                  style: AppTypograph.label2.regular.copyWith(
                                    color: AppColor.blackColor,
                                  )),
                            ),
                            const SizedBox(height: 12),
                            VerifikasiItem(
                              title: 'Jumlah Ajuan',
                              value: Text(
                                  listPatients[index]['submissionCount']
                                          .toString() ??
                                      'Tidak ada',
                                  style: AppTypograph.label2.regular.copyWith(
                                    color: AppColor.blackColor,
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
