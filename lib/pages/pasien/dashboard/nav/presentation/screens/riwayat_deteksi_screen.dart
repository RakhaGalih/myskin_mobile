import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/detail_deteksi_patient_screen.dart';

class RiwayatDeteksiScreen extends StatefulWidget {
  static const route = '/riwayatDeteksiPasien';
  const RiwayatDeteksiScreen({super.key});

  @override
  State<RiwayatDeteksiScreen> createState() => _RiwayatDeteksiScreenState();
}

class _RiwayatDeteksiScreenState extends State<RiwayatDeteksiScreen> {
  final TextEditingController _searchController = TextEditingController();
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
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: context.as.padding),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CardContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerifikasiItem(
                        title: 'Tanggal Pengajuan',
                        value: Text('22/06/2024',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Diagnosis AI',
                        value: Text('0.09% Melanoma',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label2.bold.copyWith(
                              color: AppColor.greenColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                          title: 'Gambar',
                          value: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
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
                            'Saya pertama kali menyadari adanya perubahan pada tahi lalat di punggung saya sekitar enam bulan yang lalu',
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Pengajuan',
                        value: Text('Sudah',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label2.bold.copyWith(
                              color: AppColor.greenColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Status',
                        value: Text('Unverified',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label2.bold.copyWith(
                              color: AppColor.redTextColor,
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
                                    Navigator.pushNamed(context,
                                        DetailDeteksiPatientScreen.route);
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
                                  colorButton: AppColor.redButtonColor,
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
                                  colorButton: AppColor.yellowColor,
                                  onPressed: () {},
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
