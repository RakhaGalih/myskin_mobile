// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class AppDatePicker extends StatefulWidget {
  final ValueChanged<DateTime?>
      onDateTimeSelected; // Callback for combined DateTime
  final String title;

  const AppDatePicker({
    super.key,
    required this.onDateTimeSelected,
    required this.title,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      _updateDateTime();
    }
  }

  void _updateDateTime() {
    if (_selectedDate != null) {
      final DateTime combinedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
      );
      widget.onDateTimeSelected(combinedDateTime); // Call the DateTime callback
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
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.whiteColor,
                alignLabelWithHint: true,
                labelStyle: AppTypograph.body1.regular
                    .copyWith(color: AppColor.greyTextColor),
                focusedBorder: appOutlineInputBorder(AppColor.primaryColor),
                enabledBorder: appOutlineInputBorder(AppColor.greyTextColor),
                errorBorder: appOutlineInputBorder(AppColor.redTextColor),
                focusedErrorBorder:
                    appOutlineInputBorder(AppColor.redTextColor),
                border: appOutlineInputBorder(AppColor.greyTextColor),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  splashRadius: 30,
                  onPressed: () => _selectDate(context),
                )),
            child: Text(
              _selectedDate == null
                  ? 'DD/MM/YYYY'
                  : DateFormat('dd/MM/yyyy').format(_selectedDate!),
              style: AppTypograph.body1.regular
                  .copyWith(color: AppColor.greyTextColor),
            ),
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
