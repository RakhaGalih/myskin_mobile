import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

void updateDialog(
  BuildContext context,
  VoidCallback onConfirm,
  final TextEditingController controller,
  String? keluhan,
) {
  final formKey = GlobalKey<FormState>();
  controller.text = keluhan ?? '';
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.yellowColor,
                    ),
                    child: const Icon(
                      Icons.edit_document,
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Perbarui Keluhan',
                    style: AppTypograph.label1.bold.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.greyColor,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColor.blackColor,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Divider(
                color: AppColor.greyColor,
                thickness: 1,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong masukkan keluhan';
                    }
                    return null;
                  },
                  maxLines: 5,
                  minLines: 3,
                  style: AppTypograph.label3.regular.copyWith(
                    color: AppColor.blackColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Masukkan keluhan',
                    hintStyle: AppTypograph.label3.regular.copyWith(
                      color: AppColor.greyTextColor,
                    ),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    alignLabelWithHint: true,
                    labelStyle: AppTypograph.body1.regular
                        .copyWith(color: AppColor.greyTextColor),
                    focusedBorder: appOutlineInputBorder(AppColor.primaryColor),
                    enabledBorder:
                        appOutlineInputBorder(AppColor.greyTextColor),
                    errorBorder: appOutlineInputBorder(AppColor.redTextColor),
                    focusedErrorBorder:
                        appOutlineInputBorder(AppColor.redTextColor),
                    border: appOutlineInputBorder(AppColor.greyTextColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppButton(
                        colorButton: AppColor.whiteColor,
                        child: Text(
                          'Kembali',
                          style: AppTypograph.label1.regular.copyWith(
                            color: AppColor.blackColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: AppButton(
                        colorButton: AppColor.yellowColor,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            onConfirm();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.edit_document,
                              color: AppColor.whiteColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Perbarui',
                              style: AppTypograph.label1.bold.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      });
}

void hapusDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.redButtonColor,
                    ),
                    child: const Icon(
                      Icons.delete_outline,
                      color: AppColor.whiteColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Hapus Keluhan',
                    style: AppTypograph.label1.bold.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.greyColor,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColor.blackColor,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Divider(
                color: AppColor.greyColor,
                thickness: 1,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apakah kamu yakin ingin menghapus ajuan ini?',
                style: AppTypograph.label3.regular.copyWith(
                  color: AppColor.blackColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppButton(
                        colorButton: AppColor.whiteColor,
                        child: Text(
                          'Kembali',
                          style: AppTypograph.label1.regular.copyWith(
                            color: AppColor.blackColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: AppButton(
                        colorButton: AppColor.redButtonColor,
                        onPressed: onConfirm,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: AppColor.whiteColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Hapus',
                              style: AppTypograph.label1.bold.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
