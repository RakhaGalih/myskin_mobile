import 'package:flutter/material.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/models/provider_model.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/daftar_pengajuan_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/home/presentation/screens/home_patient_screen.dart';
import 'package:provider/provider.dart';

class NavbarPatientScreen extends StatelessWidget {
  static const route = '/navbarPasien';
  const NavbarPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderModel>(
        create: (context) => ProviderModel(),
        child: Consumer<ProviderModel>(builder: (context, data, child) {
          List<Widget> widgetOptions = <Widget>[
            const HomePatientScreen(),
            const DaftarPengajuanScreen(),
          ];
          return Scaffold(
            body: widgetOptions[data.selectedNavBar],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'FAQ',
                ),
              ],
              currentIndex: data.selectedNavBar,
              selectedItemColor: AppColor.primaryColor,
              onTap: data.onNavBarTapped,
            ),
          );
        }));
  }
}
