import 'package:intl/intl.dart';

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
