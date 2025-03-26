import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/FAQ/models/faq_model.dart';
import 'package:myskin_mobile/pages/pasien/FAQ/presentation/components/FAQ_card.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const DevAppbar(
        title: 'Frequently Asked Question',
      ),
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: context.as.padding, vertical: context.as.padding),
          child: Column(
            children: [
              Text('Terkait Melanoma',
                  style: AppTypograph.label2.regular
                      .copyWith(color: AppColor.primaryColor)),
              Column(
                  children: List.generate(melanomaFAQs.length, (index) {
                return FaqCard(
                    question: melanomaFAQs[index].question,
                    answer: melanomaFAQs[index].answer);
              })),
              const SizedBox(height: 16),
              Text('Terkait MySkin',
                  style: AppTypograph.label2.regular
                      .copyWith(color: AppColor.primaryColor)),
              Column(
                  children: List.generate(mySkinFAQs.length, (index) {
                return FaqCard(
                    question: mySkinFAQs[index].question,
                    answer: mySkinFAQs[index].answer);
              })),
            ],
          ),
        ),
      )
    ]));
  }
}
