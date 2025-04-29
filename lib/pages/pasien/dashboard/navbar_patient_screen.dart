import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/pages/auth/presentation/screens/login_screen.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/models/provider_model.dart';
import 'package:myskin_mobile/pages/pasien/FAQ/presentation/screens/faq_screen.dart';
import 'package:myskin_mobile/pages/pasien/dashboard/home/presentation/screens/home_patient_screen.dart';
import 'package:provider/provider.dart';

class NavbarPatientScreen extends StatefulWidget {
  static const route = '/navbarPasien';
  const NavbarPatientScreen({super.key});

  @override
  State<NavbarPatientScreen> createState() => _NavbarPatientScreenState();
}

class _NavbarPatientScreenState extends State<NavbarPatientScreen> {
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
            const HomePatientScreen(),
            const FaqScreen(),
          ];
          return Scaffold(
            body: ModalProgressHUD(
                inAsyncCall: _showSpinner,
                child: widgetOptions[data.selectedNavBar]),
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
                  BottomNavigationBarItem(
                    icon: Icon(Icons.logout),
                    label: 'Logout',
                  ),
                ],
                currentIndex: data.selectedNavBar,
                selectedItemColor: AppColor.primaryColor,
                unselectedItemColor: AppColor.greyTextColor,
                onTap: (index) {
                  if (index == 2) {
                    _logout();
                  } else {
                    data.onNavBarTapped(index);
                  }
                }),
          );
        }));
  }
}
