import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';

class AppDropDown extends StatefulWidget {
  // List of items for the dropdown
  final List<String> kategoriItems;
  final String title;
  final ValueChanged<String?> onItemSelected;

  const AppDropDown({
    super.key,
    required this.kategoriItems,
    required this.title,
    required this.onItemSelected,
  });

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  String? selectedItem;

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
        DropdownButtonFormField<String>(
          style: AppTypograph.body1.regular
              .copyWith(color: AppColor.greyTextColor),
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.whiteColor,
              alignLabelWithHint: true,
              hintStyle: AppTypograph.body1.regular
                  .copyWith(color: AppColor.greyTextColor),
              focusedBorder: appOutlineInputBorder(AppColor.primaryColor),
              enabledBorder: appOutlineInputBorder(AppColor.greyTextColor),
              errorBorder: appOutlineInputBorder(AppColor.redTextColor),
              focusedErrorBorder:
                  appOutlineInputBorder(AppColor.redTextColor),
              border: appOutlineInputBorder(AppColor.greyTextColor),
              hintText: 'Pilih ${widget.title}...'),
          value: selectedItem,
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          items: widget.kategoriItems.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedItem = newValue;
            });
            widget.onItemSelected(
                newValue); // Call the callback with the new value
          },
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
