// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  final int? minLines;
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isPassword;
  final bool isReadOnly;
  final bool isNumber;
  final String? hintext;

  const AppTextField({
    super.key,
    this.minLines,
    required this.title,
    required this.controller,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.isReadOnly = false,
    this.isNumber = false,
    this.hintext,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypograph.label2.bold.copyWith(color: AppColor.blackColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
            readOnly: widget.isReadOnly,
            minLines: (widget.minLines == null) ? 1 : widget.minLines,
            maxLines: (widget.minLines == null) ? 1 : widget.minLines,
            keyboardType: (widget.isNumber) ? TextInputType.number : null,
            inputFormatters: (widget.isNumber)
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                : null,
            textAlign: TextAlign.start,
            controller: widget.controller,
            obscureText: (widget.isPassword) ? _isObscured : false,
            validator: (widget.validator == null)
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong masukkan ${widget.title}';
                    }
                    return null;
                  }
                : widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onChanged,
            style: AppTypograph.body1.regular,
            decoration: InputDecoration(
              hintText: widget.hintext ?? 'Masukkan ${widget.title} kamu',
              filled: true,
              fillColor: AppColor.whiteColor,
              alignLabelWithHint: true,
              labelStyle: AppTypograph.body1.regular
                  .copyWith(color: AppColor.greyTextColor),
              focusedBorder: appOutlineInputBorder(AppColor.primaryColor),
              enabledBorder: appOutlineInputBorder(AppColor.greyTextColor),
              errorBorder: appOutlineInputBorder(AppColor.redTextColor),
              focusedErrorBorder: appOutlineInputBorder(AppColor.redTextColor),
              border: appOutlineInputBorder(AppColor.greyTextColor),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      splashRadius: 30,
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: _isObscured
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    )
                  : null,
            )),
      ],
    );
  }
}

OutlineInputBorder appOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: color, width: 1),
  );
}
