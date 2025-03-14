// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class AppFilePicker extends StatefulWidget {
  final ValueChanged<DateTime?>
      onDateTimeSelected; // Callback for combined DateTime
  final String title;

  const AppFilePicker({
    super.key,
    required this.onDateTimeSelected,
    required this.title,
  });

  @override
  State<AppFilePicker> createState() => _AppFilePickerState();
}

class _AppFilePickerState extends State<AppFilePicker> {
  String? _filePath;

  // Function to open file picker
  Future<void> _openFilePicker() async {
    // Open file picker and wait for the result
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // If the user selected a file, get the file path
      setState(() {
        _filePath = result.files.single.path;
      });
    } else {
      // User canceled the picker
      setState(() {
        _filePath = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypograph.label2.bold.copyWith(color: AppColor.blackColor),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _openFilePicker(),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
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
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  _filePath != null
                      ? 'Selected File: $_filePath'
                      : 'No file chosen',
                  style: AppTypograph.body1.regular
                      .copyWith(color: AppColor.greyTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.upload_file,
                  color: AppColor.whiteColor,
                ),
              ),
            ]),
          ),
        ),
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
