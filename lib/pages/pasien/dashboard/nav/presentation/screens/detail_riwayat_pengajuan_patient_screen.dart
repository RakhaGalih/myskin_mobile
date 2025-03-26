import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/app_textfield.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';

class DetailRiwayatPengajuanPatientScreen extends StatefulWidget {
  static const route = '/detailRiwayatPengajuanPasien';
  const DetailRiwayatPengajuanPatientScreen({super.key});

  @override
  State<DetailRiwayatPengajuanPatientScreen> createState() =>
      _DetailRiwayatPengajuanPatientScreenState();
}

class _DetailRiwayatPengajuanPatientScreenState
    extends State<DetailRiwayatPengajuanPatientScreen> {
  final TextEditingController _catatanController = TextEditingController(
    text: 'Jangan lupa minum obat',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(
            title: 'Detail Riwayat Pengajuan',
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
                    const SizedBox(height: 16),
                    Center(
                      child: Text('Hasil deteksi sudah diverifikasi dokter',
                          textAlign: TextAlign.center,
                          style: AppTypograph.label1.bold.copyWith(
                            color: AppColor.blackColor,
                          )),
                    ),
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
                          Text('Diverifikasi Oleh',
                              style: AppTypograph.heading2.bold.copyWith(
                                color: AppColor.blackColor,
                              )),
                          const SizedBox(height: 12),
                          Text('Muhammad Nur Shodiq',
                              style: AppTypograph.label1.regular.copyWith(
                                color: AppColor.blackColor,
                              )),
                        ])),
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
                    Center(
                      child: Text('Catatan Dokter',
                          textAlign: TextAlign.center,
                          style: AppTypograph.heading2.bold.copyWith(
                            color: AppColor.blackColor,
                          )),
                    ),
                    CardContainer(
                        child: AppTextField(
                      title: 'Catatan:',
                      isReadOnly: true,
                      controller: _catatanController,
                      minLines: 5,
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
