import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_theme.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_dokter_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/login_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/onboarding_screen.dart';
import 'package:myskin_mobile/pages/dokter/dashboard/home/presentation/screens/daftar_pasien_screen.dart';
import 'package:myskin_mobile/pages/dokter/navbar_doctor_screen.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/detail_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/detail_deteksi_patient_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/detail_riwayat_pengajuan_patient_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/deteksi_kulit_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/riwayat_deteksi_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/riwayat_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_patient_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
      initialRoute: OnboardingScreen.route,
      routes: {
        OnboardingScreen.route: (context) => const OnboardingScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        DaftarScreen.route: (context) => const DaftarScreen(),
        DaftarDokterScreen.route: (context) => const DaftarDokterScreen(),
        NavbarDoctorScreen.route: (context) => const NavbarDoctorScreen(),
        DetailPengajuanScreen.route: (context) => const DetailPengajuanScreen(),
        NavbarPatientScreen.route: (context) => const NavbarPatientScreen(),
        DeteksiKulitScreen.route: (context) => const DeteksiKulitScreen(),
        RiwayatDeteksiScreen.route: (context) => const RiwayatDeteksiScreen(),
        RiwayatPengajuanScreen.route: (context) =>
            const RiwayatPengajuanScreen(),
        DetailRiwayatPengajuanPatientScreen.route: (context) =>
            const DetailRiwayatPengajuanPatientScreen(),
        DetailDeteksiPatientScreen.route: (context) =>
            const DetailDeteksiPatientScreen(),
        DaftarPasienScreen.route: (context) => const DaftarPasienScreen(),
        
      },
    );
  }
}
