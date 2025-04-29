import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/components/verifikasi_item.dart';

class DaftarPasienScreen extends StatefulWidget {
  static const route = '/daftarPasien';
  const DaftarPasienScreen({super.key});

  @override
  State<DaftarPasienScreen> createState() => _DaftarPasienScreenState();
}

class _DaftarPasienScreenState extends State<DaftarPasienScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(title: 'Riwayat Verifikasi', isBack: true,),
          SearchTextField(controller: _searchController),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: context.as.padding),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CardContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerifikasiItem(
                        title: 'Nama',
                        value: Text('Muhammad Nur Shodiq',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Nnomor Telepon',
                        value: Text('08123456789',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                      const SizedBox(height: 12),
                      VerifikasiItem(
                        title: 'Jumlah Ajuan',
                        value: Text('1',
                            style: AppTypograph.label2.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ),
                    ],
                  ));
                }),
          ),
        ],
      ),
    );
  }
}
