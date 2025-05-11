// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isPadding;
  final void Function(String?)? validator;
  final void Function(String?)? onChanged;

  const SearchTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.isPadding = true,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: isPadding ? context.as.padding : 0,
          right: isPadding ? context.as.padding : 0,
          top: isPadding ? context.as.padding : 0),
      child: TextFormField(
          textAlign: TextAlign.start,
          controller: controller,
          onChanged: onChanged,
          style: AppTypograph.body1.regular,
          decoration: InputDecoration(
            hintText: hintText ?? 'Cari di sini',
            filled: true,
            fillColor: AppColor.whiteColor,
            alignLabelWithHint: true,
            prefixIcon: const Icon(
              Icons.search,
              color: AppColor.greyTextColor,
            ),
            labelStyle: AppTypograph.body1.regular
                .copyWith(color: AppColor.greyTextColor),
            focusedBorder: appOutlineInputBorder(AppColor.primaryColor),
            enabledBorder: appOutlineInputBorder(AppColor.greyTextColor),
            errorBorder: appOutlineInputBorder(AppColor.redTextColor),
            focusedErrorBorder: appOutlineInputBorder(AppColor.redTextColor),
            border: appOutlineInputBorder(AppColor.greyTextColor),
          )),
    );
  }
}

OutlineInputBorder appOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: color, width: 1),
  );
}
