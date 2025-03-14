import 'package:flutter/material.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/home/models/provider_model.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/home/presentation/screens/home_doctor_screen.dart';
import 'package:provider/provider.dart';

class NavbarDoctorScreen extends StatelessWidget {
  static const route = '/navbarDokter';
  const NavbarDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderModel>(
        create: (context) => ProviderModel(),
        child: Consumer<ProviderModel>(builder: (context, data, child) {
          List<Widget> widgetOptions = <Widget>[
            const HomeDoctorScreen(),
            const HomeDoctorScreen(),
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
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
              ],
              currentIndex: data.selectedNavBar,
              selectedItemColor: Colors.amber[800],
              onTap: data.onNavBarTapped,
            ),
          );
        }));
  }
}
