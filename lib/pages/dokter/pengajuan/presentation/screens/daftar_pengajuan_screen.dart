import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/detail_pengajuan_screen.dart';

class DaftarPengajuanScreen extends StatelessWidget {
  const DaftarPengajuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(title: 'Daftar Pengajuan'),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: context.as.padding),
                itemCount: 4,
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
                      Text('Muhammad Nur Shodiq',
                          style: AppTypograph.label1.bold.copyWith(
                            color: AppColor.blackColor,
                          )),
                      const SizedBox(height: 4),
                      Text('7 Oktober 2024',
                          style: AppTypograph.label2.regular.copyWith(
                            color: AppColor.greyTextColor,
                          )),
                      const SizedBox(height: 12),
                      Row(children: [
                        Text('Melanoma: ',
                            style: AppTypograph.label2.bold.copyWith(
                              color: AppColor.blackColor,
                            )),
                        Text('99%',
                            style: AppTypograph.label2.bold
                                .copyWith(color: AppColor.redTextColor)),
                      ]),
                      const SizedBox(height: 8),
                      AppButton(
                          padding: 8,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, DetailPengajuanScreen.route);
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Detail Pengajuan',
                                style: AppTypograph.label2.bold
                                    .copyWith(color: AppColor.whiteColor),
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
