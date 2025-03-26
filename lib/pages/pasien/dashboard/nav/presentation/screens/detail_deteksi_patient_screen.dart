import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';

class DetailDeteksiPatientScreen extends StatelessWidget {
  static const route = '/detailDeteksiPasien';
  const DetailDeteksiPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(
            title: 'Detail Hasil Deteksi',
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
                      'ID Deteksi: 16',
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
                    const Row(
                      children: [
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Melanoma',
                                  image: 'assets/icons/melanoma_icon.png',
                                  value: 'iya',
                                  color: AppColor.blackColor)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Keakuratan',
                                  image: 'assets/icons/spedometer_icon.png',
                                  value: '99% Melanoma (Tidak aman)',
                                  color: AppColor.maroonColor)),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Pengajuan Verifikasi',
                                  image: 'assets/icons/clock_icon.png',
                                  value: 'Pending',
                                  color: AppColor.yellowTextColor)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Status',
                                  image: 'assets/icons/status_icon.png',
                                  value: 'Unverified',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
