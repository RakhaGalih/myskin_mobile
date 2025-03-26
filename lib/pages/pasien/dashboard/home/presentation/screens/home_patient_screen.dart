import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/components/nav_card.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/riwayat_deteksi_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/riwayat_pengajuan_screen.dart';

class HomePatientScreen extends StatelessWidget {
  const HomePatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: context.as.appTopSafeArea + 130,
              child: Stack(
                children: [
                  Image.asset('assets/images/loginImage.jpeg',
                      width: double.infinity, fit: BoxFit.fitWidth),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            AppColor.whiteColor.withOpacity(0),
                            AppColor.whiteColor
                          ])),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.as.padding, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(context.as.padding),
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Hi, ',
                                          style: AppTypograph.label1.regular
                                              .copyWith(
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          'Shodiq',
                                          style: AppTypograph.label1.bold
                                              .copyWith(
                                                  color: AppColor.primaryColor),
                                        )
                                      ],
                                    ),
                                    Text(
                                      'Pasien',
                                      style: AppTypograph.label3.regular
                                          .copyWith(
                                              color: AppColor.primaryColor),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Stack(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: AppColor.primaryColor,
                                        )),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        margin:
                                            EdgeInsets.all(context.as.padding),
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                            color: AppColor.primaryColor,
                                            shape: BoxShape.circle),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text('Minggu, 6 Oktober 2024',
                              style: AppTypograph.label1.regular)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.as.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      NavCard(
                        onPressed: () {},
                        title: 'Deteksi Kulit',
                        icon: Icons.document_scanner,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      NavCard(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RiwayatDeteksiScreen.route);
                        },
                        title: 'Riwayat Deteksi',
                        icon: Icons.history,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      NavCard(
                          onPressed: () {
                            Navigator.pushNamed(
                              context, RiwayatPengajuanScreen.route);
                          },
                          title: 'Riwayat Pengajuan',
                          icon: Icons.file_present),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Ajuan Verifikasi',
                      style: AppTypograph.label1.bold.copyWith(
                        color: AppColor.blackColor,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  CardContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Tanggal',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Gambar',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Diagniosis AI',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Status',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                          ]),
                      for (int i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text('22/06/2024',
                                    textAlign: TextAlign.center,
                                    style: AppTypograph.label2.regular.copyWith(
                                      color: AppColor.blackColor,
                                    )),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/melanoma.jpeg',
                                        width: 32,
                                        height: 32,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Text('0.09% Melanoma',
                                    textAlign: TextAlign.center,
                                    style: AppTypograph.label2.bold.copyWith(
                                      color: AppColor.greenColor,
                                    )),
                              ),
                              Expanded(
                                child: Text('Verified',
                                    textAlign: TextAlign.center,
                                    style: AppTypograph.label2.bold.copyWith(
                                      color: AppColor.greenColor,
                                    )),
                              )
                            ],
                          ),
                        ),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
