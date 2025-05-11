import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';

extension StringExtensions on String {
  String toCamelCase() {
    if (isEmpty) {
      return this;
    }

    final words = split(RegExp(r'\s+'));
    final camelCasedWords = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return camelCasedWords;
  }

  String getInitials() {
    if (isEmpty) {
      return '';
    }

    final words = split(RegExp(r'\s+'));
    final initials = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase();
    }).join('');

    return initials;
  }

  String toFormattedDate() {
    DateTime parsedDate = DateTime.parse(this);

    return DateFormat('dd MMM yyyy').format(parsedDate);
  }
}

extension RupiahFormatter on num {
  String toRupiah() {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}

String getFormattedDate(DateTime date) {
  // Format: Hari, Tanggal Bulan Tahun
  String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(date);

  return formattedDate;
}

int getAge(String dateString) {
  DateTime birthDate = DateTime.parse(dateString);
  DateTime today = DateTime.now();
  int age = today.year - birthDate.year;

  // Cek apakah sudah ulang tahun tahun ini atau belum
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}

double doublePercentageToString(String input) {

// Ekstrak angka dengan regex
  final regex = RegExp(r'[\d.]+'); // mencocokkan angka termasuk titik desimal
  final match = regex.firstMatch(input);

  if (match != null) {
    double result = double.parse(match.group(0)!);
    return result; // Output: 50.62
  }
  return 0.0;
}

bool isMelanoma(String input) {
  // Mengubah input menjadi persentase
  double percentage = doublePercentageToString(input);
  // Misalkan kita anggap melanoma jika persentase lebih dari 50%
  return percentage > 50.0;
}

Color getMelanomaColor(String input) {
  if (isMelanoma(input)) {
    return AppColor.redTextColor; // Merah
  } else {
    return AppColor.greenColor; // Hijau
  }
}