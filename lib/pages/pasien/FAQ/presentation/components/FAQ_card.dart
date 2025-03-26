// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class FaqCard extends StatelessWidget {
  final String question;
  final String answer;
  const FaqCard({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.whiteColor,
                  border: Border.all(color: AppColor.greyColor)),
              child: const Icon(
                Icons.chat_rounded,
                size: 20,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                question,
                style: AppTypograph.heading3.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          answer,
          textAlign: TextAlign.justify,
          style: AppTypograph.label2.regular,
        )
      ],
    ));
  }
}
