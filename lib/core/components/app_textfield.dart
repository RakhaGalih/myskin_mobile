import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  final int? minLines;
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isPassword;

  const AppTextField({
    super.key,
    this.minLines,
    required this.title,
    required this.controller,
    this.validator,
    this.onChanged,
    this.isPassword = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypograph.label2.bold.copyWith(color: AppColor.blackColor),
        ),
        const SizedBox(height: 8),
        TextFormField(
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
              hintText: 'Masukkan ${widget.title} kamu',
              filled: true,
              fillColor: AppColor.whiteColor,
              alignLabelWithHint: true,
              labelStyle: AppTypograph.body1.regular
                  .copyWith(color: AppColor.greyTextColor),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AppColor.primaryColor, width: 2),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AppColor.primaryColor, width: 2),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AppColor.redTextColor, width: 2),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AppColor.redTextColor, width: 2),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide:
                    BorderSide(color: AppColor.primaryColor, width: 2),
              ),
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
