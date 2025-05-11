import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_theme.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_dokter_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/daftar_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/login_screen.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/onboarding_screen.dart';
import 'package:myskin_mobile/pages/dokter/dashboard/home/presentation/screens/daftar_pasien_screen.dart';
import 'package:myskin_mobile/pages/dokter/navbar_doctor_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/deteksi_kulit_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/riwayat_deteksi_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/nav/presentation/screens/riwayat_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/navbar_patient_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {

  

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late String? role = "";
  bool _showSpinner = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      _showSpinner = true;
    });
    role = await getRole();
    print(role);
    String? token = await getToken();
    print(token);
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: (role == 'patient')
            ? const NavbarPatientScreen()
            : (role == 'doctor')
                ? const NavbarDoctorScreen()
                : const OnboardingScreen(),
      ),
      routes: {
        OnboardingScreen.route: (context) => const OnboardingScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        DaftarScreen.route: (context) => const DaftarScreen(),
        DaftarDokterScreen.route: (context) => const DaftarDokterScreen(),
        NavbarDoctorScreen.route: (context) => const NavbarDoctorScreen(),
        NavbarPatientScreen.route: (context) => const NavbarPatientScreen(),
        DeteksiKulitScreen.route: (context) => const DeteksiKulitScreen(),
        RiwayatDeteksiScreen.route: (context) => const RiwayatDeteksiScreen(),
        RiwayatPengajuanScreen.route: (context) =>
            const RiwayatPengajuanScreen(),
        DaftarPasienScreen.route: (context) => const DaftarPasienScreen(),
      },
    );
  }
}
