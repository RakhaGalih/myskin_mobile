// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class NavCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  const NavCard({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(
            width: 62,
            child: CardContainer(
                child: Center(
              child: Icon(
                icon,
                size: 30,
              ),
            )),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTypograph.label3.medium,
          )
        ],
      ),
    ));
  }
}
