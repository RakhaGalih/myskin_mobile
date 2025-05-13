// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/components/app_button.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/components/dev_appbar.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/utils/format_util.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/components/icon_item.dart';

class DetailDeteksiPatientScreen extends StatefulWidget {
  final Map<String, dynamic> deteksi;
  const DetailDeteksiPatientScreen({
    super.key,
    required this.deteksi,
  });

  @override
  State<DetailDeteksiPatientScreen> createState() =>
      _DetailDeteksiPatientScreenState();
}

class _DetailDeteksiPatientScreenState
    extends State<DetailDeteksiPatientScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DevAppbar(
            title: 'Detail Hasil Deteksi',
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
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
                      'ID Deteksi: ${widget.deteksi['id']}',
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
                    Row(
                      children: [
                         Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Melanoma',
                                  image: 'assets/icons/melanoma_icon.png',
                                  value: isMelanoma(widget.deteksi['diagnosisAi']??
                                            '0% Melanoma')
                                        ? 'Iya'
                                        : 'Tidak',
                                  color: AppColor.blackColor)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CardContainer(
                              child: IconItem(
                                  title: 'Keakuratan',
                                  image: 'assets/icons/spedometer_icon.png',
                                  value:
                                      '${widget.deteksi['diagnosisAi'] ?? '0% Melanoma'} (Tidak aman)',
                                  color: AppColor.maroonColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '*Hasil deteksi belum dipastikan benar karena web hanya memberikan indikasi awal, silahkan ajukan hasil verifikasi ke dokter.',
                      style: AppTypograph.label3.regular
                          .copyWith(color: AppColor.greyTextColor),
                    )
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
