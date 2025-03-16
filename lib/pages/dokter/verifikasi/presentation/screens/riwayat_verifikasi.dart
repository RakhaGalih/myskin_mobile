import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/card_container.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/detail_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';

class RiwayatVerifikasiScreen extends StatelessWidget {
  const RiwayatVerifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.as.loginPadding),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColor.greyTextColor.withOpacity(0.1),
                  offset: const Offset(0.0, 3.0),
                  blurRadius: 12.0,
                ),
              ],
            ),
            child: SafeArea(
              child: Center(
                child: Text(
                  'Riwayat Verifikasi',
                  style: AppTypograph.heading2.bold.copyWith(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CardContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerifikasiItem(
                        title: 'Tanggal Pengajuan',
                        value: Text('22/06/2024',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Pasien',
                        value: Text('Muhammad Nur Shodiq',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Diagnosis AI',
                        value: Text('0.09% Melanoma',
                            style: AppTypograph.label2.bold.copyWith(
                              color: AppColor.greenColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Verifikasi Dokter',
                        value: Text('Bukan Melanoma',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Catatan',
                        value: Text('Pasien tersebut tidak menderita melanoma',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Detail',
                        value: AppButton(
                            padding: 8,
                            onPressed: () {
                              Navigator.pushNamed(context, DetailPengajuanScreen.route);
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 16,
                                      color: AppColor.whiteColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Detail Pengajuan',
                                      style: AppTypograph.label3.bold
                                          .copyWith(color: AppColor.whiteColor),
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
