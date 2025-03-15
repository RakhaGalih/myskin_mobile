import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class DaftarPengajuanScreen extends StatelessWidget {
  const DaftarPengajuanScreen({super.key});

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
                  'Daftar Pengajuan Umum',
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
                  return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: context.as.loginPadding,
                        vertical: 8,
                      ),
                      padding: EdgeInsets.all(context.as.padding),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.greyTextColor.withOpacity(0.1),
                            blurRadius: 12.0,
                          ),
                        ],
                      ),
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
                              onPressed: () {},
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
