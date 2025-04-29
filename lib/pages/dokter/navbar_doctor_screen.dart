import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/login_screen.dart';
import 'package:myskin_mobile/pages/dokter/dashboard/home/presentation/screens/home_doctor_screen.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/models/provider_model.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/daftar_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/dokter/verifikasi/presentation/screens/riwayat_verifikasi.dart';
import 'package:provider/provider.dart';

class NavbarDoctorScreen extends StatefulWidget {
  static const route = '/navbarDokter';
  const NavbarDoctorScreen({super.key});

  @override
  State<NavbarDoctorScreen> createState() => _NavbarDoctorScreenState();
}

class _NavbarDoctorScreenState extends State<NavbarDoctorScreen> {
  bool _showSpinner = false;
  String error = "";
  void _logout() async {
    error = "";
    String? accessToken = await getToken();
    String? role = await getRole();
    print(accessToken);

    print(role);
    setState(() {
      _showSpinner = true;
    });
    Map<String, dynamic> response = {};
    try {
      String? token = await getToken();
      response = await logout(token!);
      await removeToken();
      if (mounted) {
        Navigator.pushNamed(context, LoginScreen.route);
      }
      print('berhasil logout!');
      String? accessToken = await getToken();
      String? role = await getRole();
      print(accessToken);
      print(role);
    } catch (e) {
      setState(() {
        _showSpinner = false;
        error = "Email atau Password salah";
      });
      error = "${response['message']}";
      print('Login error: $e');
      print(response);
    }
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderModel>(
        create: (context) => ProviderModel(),
        child: Consumer<ProviderModel>(builder: (context, data, child) {
          List<Widget> widgetOptions = <Widget>[
            HomeDoctorScreen(
              onTapPengajuan: () {
                data.onNavBarTapped(1);
              },
              onTapVerifikasi: () {
                data.onNavBarTapped(2);
              },
            ),
            const DaftarPengajuanScreen(),
            const RiwayatVerifikasiScreen()
          ];
          return ModalProgressHUD(
            inAsyncCall: _showSpinner,
            child: Scaffold(
              body: widgetOptions[data.selectedNavBar],
              bottomNavigationBar: BottomNavigationBar(
                  showUnselectedLabels: true,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assignment),
                      label: 'Pengajuan',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.check_box),
                      label: 'Verfikasi',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.logout),
                      label: 'Logout',
                    ),
                  ],
                  currentIndex: data.selectedNavBar,
                  unselectedItemColor: AppColor.greyTextColor,
                  selectedItemColor: AppColor.primaryColor,
                  onTap: (index) {
                    if (index == 3) {
                      _logout();
                    } else {
                      data.onNavBarTapped(index);
                    }
                  }),
            ),
          );
        }));
  }
}
