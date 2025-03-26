import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/dashboard/home/presentation/components/info_card.dart';

class HomeDoctorScreen extends StatelessWidget {
  const HomeDoctorScreen({super.key});

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
                                      'Muhammad',
                                      style: AppTypograph.label1.bold
                                          .copyWith(
                                              color: AppColor.primaryColor),
                                    )
                                  ],
                                ),
                                Text(
                                  'Dokter',
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
              const Row(
                children: [
                  InfoCard(
                      title: 'Pasien',
                      value: '547',
                      icon: Icons.person_2_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  InfoCard(
                      title: 'Menunggu Verifikasi',
                      value: '547',
                      icon: Icons.timer_outlined),
                  SizedBox(
                    width: 12,
                  ),
                  InfoCard(
                      title: 'Terverifikasi',
                      value: '547',
                      icon: Icons.check_circle_outline),
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
                            'Pasien',
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
                            'Verifikasi',
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
                            child: Text('Muhammad Nur Shodiq',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label2.regular.copyWith(
                                  color: AppColor.blackColor,
                                )),
                          ),
                          Expanded(
                            child: Text('0.09% Melanoma',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label2.bold.copyWith(
                                  color: AppColor.greenColor,
                                )),
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const Icon(Icons.assignment,
                                      color: AppColor.whiteColor),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text('Verifikasi',
                                        style: AppTypograph.label3.medium
                                            .copyWith(
                                          color: AppColor.whiteColor,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                ],
              )),
              const SizedBox(
                height: 16,
              ),
              Text('Pasien',
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
                            'Nama',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label1.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'No Telp',
                            textAlign: TextAlign.center,
                            style: AppTypograph.label1.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Jumlah Ajuan',
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
                            child: Text('Muhammad Nur Shodiq',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label2.regular.copyWith(
                                  color: AppColor.blackColor,
                                )),
                          ),
                          Expanded(
                            child: Text('082246881193',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label2.regular.copyWith(
                                  color: AppColor.blackColor,
                                )),
                          ),
                          Expanded(
                            child: Text('1',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label2.regular.copyWith(
                                  color: AppColor.blackColor,
                                )),
                          ),
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
