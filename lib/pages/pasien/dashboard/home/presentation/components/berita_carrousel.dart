import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/home/models/berita_model.dart';

class BeritaCarrousel extends StatefulWidget {
  const BeritaCarrousel({super.key});

  @override
  State<BeritaCarrousel> createState() => _BeritaCarrouselState();
}

class _BeritaCarrouselState extends State<BeritaCarrousel> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<BeritaModel> _onboardingData = [
    BeritaModel(
      title: 'Apa itu Melanoma?',
      description:
          'Melanoma adalah jenis kanker kulit yang paling serius. Melanoma terjadi ketika sel-sel pigmentasi kulit yang disebut melanosit berubah menjadi sel-sel kanker. Melanoma dapat terjadi di kulit mana pun, tetapi melanoma yang terjadi di bagian tubuh yang tidak terpapar sinar matahari seringkali lebih serius.',
      image: 'assets/images/berita1.png',
    ),
    BeritaModel(
      title: 'Bagaimana pengobatan untuk melanoma?',
      description:
          'Pengobatan melanoma tergantung pada stadium dan lokasi kanker. Metode pengobatan yang umum termasuk pembedahan untuk mengangkat kanker, terapi radiasi, imunoterapi, dan terapi target. Pada kasus yang lebih lanjut, kombinasi dari beberapa metode pengobatan mungkin diperlukan, segera hubungi dokter.',
      image: 'assets/images/berita2.png',
    ),
    BeritaModel(
      title: 'Apa saja gejala melanoma?',
      description:
          'Gejala melanoma dapat meliputi munculnya tahi lalat baru atau perubahan pada tahi lalat yang sudah ada. Ciri-ciri tahi lalat yang mencurigakan termasuk bentuk yang tidak simetris, tepi yang tidak rata, warna yang tidak seragam, diameter lebih besar dari 6 mm, dan perubahan bentuk, ukuran, atau warna.',
      image: 'assets/images/berita3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(children: [
          PageView.builder(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.asset(
                      _onboardingData[index].image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: context.as.appHeight,
                      width: context.as.appWidth,
                      color: Colors.black.withOpacity(0.48),
                    ),
                    Padding(
                      padding: EdgeInsets.all(context.as.padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _onboardingData[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypograph.label1.bold.copyWith(
                              color: AppColor.whiteColor,
                            ),
                          ),
                          Text(
                            _onboardingData[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypograph.label3.regular.copyWith(
                              color: AppColor.whiteColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(context.as.padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 6,
                    width: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? AppColor.primaryColor
                          : AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
