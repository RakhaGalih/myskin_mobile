import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/components/search_textfield.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';

class DetailPengajuanScreen extends StatefulWidget {
  static const route = '/detailPengajuan';
  const DetailPengajuanScreen({super.key});

  @override
  State<DetailPengajuanScreen> createState() => _DetailPengajuanScreenState();
}

class _DetailPengajuanScreenState extends State<DetailPengajuanScreen> {
  bool? _selectedRadioButton;
  final TextEditingController _catatanController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(
            title: 'Detail Pengajuan',
            isBack: true,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.as.padding),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                         vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/melanoma.jpeg',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'ID Deteksi: 16',
                      style: AppTypograph.label1.bold,
                    ),
                    const SizedBox(height: 8),
                    AppButton(
                        padding: 8,
                        onPressed: () {},
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Unduh Gambar',
                              style: AppTypograph.label2.bold
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ),
                        )),
                    CardContainer(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Detail Pasien',
                            style: AppTypograph.heading2.bold.copyWith(
                              color: AppColor.blackColor,
                            )),
                        const SizedBox(height: 12),
                        Text('Nama: Zaky Pasien',
                            style: AppTypograph.label1.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                        const SizedBox(height: 12),
                        Text('Nomor Telepon: 082246881193',
                            style: AppTypograph.label1.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                        const SizedBox(height: 12),
                        Text('Email: shodiq@pasien.ac.id',
                            style: AppTypograph.label1.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                        const SizedBox(height: 12),
                        Text('Umur: 21',
                            style: AppTypograph.label1.regular.copyWith(
                              color: AppColor.blackColor,
                            )),
                      ],
                    )),
                    CardContainer(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Keluhan',
                              style: AppTypograph.heading2.bold.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text(
                              'Saya pertama kali menyadari adanya perubahan pada tahi lalat di punggung saya sekitar enam bulan yang lalu. Awalnya, tahi lalat tersebut hanya sedikit lebih besar dari biasanya, tetapi seiring waktu, ukurannya bertambah dan warnanya berubah menjadi lebih gelap, hampir hitam. Saya juga mulai merasakan gatal di area tersebut, dan kadang-kadang benjolan itu berdarah tanpa alasan yang jelas',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                        ])),
                    const Row(
                      children: [
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Melanoma',
                                  image: 'assets/icons/melanoma_icon.png',
                                  value: 'iya',
                                  color: AppColor.blackColor)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Keakuratan',
                                  image: 'assets/icons/spedometer_icon.png',
                                  value: '99% Melanoma (Tidak aman)',
                                  color: AppColor.maroonColor)),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Pengajuan Verifikasi',
                                  image: 'assets/icons/clock_icon.png',
                                  value: 'Pending',
                                  color: AppColor.yellowTextColor)),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Status',
                                  image: 'assets/icons/status_icon.png',
                                  value: 'Unverified',
                                  color: AppColor.maroonColor)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text('Verifikasi Hasil Deteksi',
                        style: AppTypograph.heading2.bold.copyWith(
                          color: AppColor.blackColor,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    CardContainer(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '*Verifikasi Melanoma',
                          style: AppTypograph.label2.bold
                              .copyWith(color: AppColor.blackColor),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Melanoma',
                                  style: AppTypograph.label3.regular,
                                ),
                                value: true,
                                groupValue: _selectedRadioButton,
                                fillColor: const WidgetStatePropertyAll(
                                    AppColor.primaryColor),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRadioButton = value!;
                                  });
                                },
                                dense: true,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Bukan Melanoma',
                                  style: AppTypograph.label3.regular,
                                ),
                                fillColor: const WidgetStatePropertyAll(
                                    AppColor.primaryColor),
                                value: false,
                                groupValue: _selectedRadioButton,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRadioButton = value!;
                                  });
                                },
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                        AppTextField(
                          title: 'Catatan:',
                          controller: _catatanController,
                          minLines: 5,
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
