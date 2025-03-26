// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class IconItem extends StatelessWidget {
  final String title;
  final String image;
  final String value;
  final Color color;
  const IconItem({
    super.key,
    required this.title,
    required this.image,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypograph.label1.bold,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppTypograph.label3.regular.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
