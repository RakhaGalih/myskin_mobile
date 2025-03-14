import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_theme.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_dokter_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/login_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/onboarding_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_doctor_screen.dart';

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
      },
    );
  }
}
