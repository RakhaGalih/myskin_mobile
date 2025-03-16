import 'package:flutter/material.dart';

class DetailPengajuanScreen extends StatelessWidget {
  static const route = '/detailPengajuan';
  const DetailPengajuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Detail Pengajuan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
