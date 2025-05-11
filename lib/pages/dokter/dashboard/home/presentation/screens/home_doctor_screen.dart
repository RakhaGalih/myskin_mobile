// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myskin_mobile/core/components/card_container.dart';
import 'package:myskin_mobile/core/services/http_service.dart';
import 'package:myskin_mobile/core/theme/app_colors.dart';
import 'package:myskin_mobile/core/theme/app_sizes.dart';
import 'package:myskin_mobile/core/theme/app_typography.dart';
import 'package:myskin_mobile/core/utils/format_util.dart';
import 'package:myskin_mobile/pages/dokter/dashboard/home/presentation/components/info_card.dart';
import 'package:myskin_mobile/pages/dokter/pengajuan/presentation/screens/detail_pengajuan_screen.dart';

class HomeDoctorScreen extends StatefulWidget {
  final VoidCallback onTapPengajuan;
  final VoidCallback onTapVerifikasi;
  const HomeDoctorScreen({
    super.key,
    required this.onTapPengajuan,
    required this.onTapVerifikasi,
  });

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  bool _showSpinner = false;
  bool _showSpinnerPatient = false;
  bool _showSpinnerStatistik = false;
  String error = "";
  List<Map<String, dynamic>> ajuans = [];
  List<Map<String, dynamic>> listPatients = [];
  int pasien = 0;
  int menungguVerifikasi = 0;
  int terverifikasi = 0;
  String nama = "Loading...";

  @override
  void initState() {
    super.initState();
    _getStatistik();
    _getAjuan();
    _getPatient();
  }

  Future<void> _getAjuan() async {
    error = "";
    setState(() {
      _showSpinner = true;
    });
    try {
      String? token = await getToken();
      var response =
          await getDataToken('/v1/doctor/dashboard/pending?limit=5', token!);
      List<Map<String, dynamic>> parsedData = (response['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(response);
      setState(() {
        ajuans = parsedData;
      });
      var responseWelcome = await getDataToken('/v1/welcome', token);
      print(response);
      setState(() {
        nama = responseWelcome['firstName'];
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    } finally {
      setState(() {
        _showSpinner = false;
      });
    }
  }

  Future<void> _getPatient() async {
    error = "";
    setState(() {
      _showSpinnerPatient = true;
    });
    try {
      String? token = await getToken();
      var response = await getDataToken('/v1/doctor/patients?limit=5', token!);
      List<Map<String, dynamic>> parsedData = (response['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print(response);
      setState(() {
        listPatients = parsedData;
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    }
    setState(() {
      _showSpinnerPatient = false;
    });
  }

  Future<void> _getStatistik() async {
    error = "";
    setState(() {
      _showSpinnerStatistik = true;
    });
    try {
      String? token = await getToken();
      var response = await getDataToken('/v1/doctor/dashboard/stats', token!);
      Map<String, dynamic> parsedData = response['data'];
      print(response);
      setState(() {
        pasien = parsedData['totalPatients'];
        menungguVerifikasi = parsedData['pending'];
        terverifikasi = parsedData['verified'];
      });
    } catch (e) {
      print(e);
      setState(() {
        error = "Error: $e";
      });
    }
    setState(() {
      _showSpinnerStatistik = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: context.as.appTopSafeArea + 130,
              child: Stack(
                children: [
                  Image.asset('assets/images/loginImage.jpeg',
                      width: double.infinity, fit: BoxFit.fitWidth),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            AppColor.whiteColor.withOpacity(0),
                            AppColor.whiteColor
                          ])),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.as.padding, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(context.as.padding),
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Hi, ',
                                          style: AppTypograph.label1.regular
                                              .copyWith(
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          nama,
                                          style: AppTypograph.label1.bold
                                              .copyWith(
                                                  color: AppColor.primaryColor),
                                        )
                                      ],
                                    ),
                                    Text(
                                      'Dokter',
                                      style: AppTypograph.label3.regular
                                          .copyWith(
                                              color: AppColor.primaryColor),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Stack(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: AppColor.primaryColor,
                                        )),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        margin:
                                            EdgeInsets.all(context.as.padding),
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                            color: AppColor.primaryColor,
                                            shape: BoxShape.circle),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(getFormattedDate(DateTime.now()),
                              style: AppTypograph.label1.regular)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.as.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InfoCard(
                          title:
                              (_showSpinnerStatistik) ? 'Loading...' : 'Pasien',
                          value: pasien.toString(),
                          icon: Icons.person_2_outlined,
                          onPressed: () {
                            Navigator.pushNamed(context, '/daftarPasien');
                          }),
                      const SizedBox(
                        width: 12,
                      ),
                      InfoCard(
                          title: (_showSpinnerStatistik)
                              ? 'Loading...'
                              : 'Menunggu Verifikasi',
                          value: menungguVerifikasi.toString(),
                          icon: Icons.timer_outlined,
                          onPressed: widget.onTapPengajuan),
                      const SizedBox(
                        width: 12,
                      ),
                      InfoCard(
                          onPressed: widget.onTapVerifikasi,
                          title: (_showSpinnerStatistik)
                              ? 'Loading...'
                              : 'Terverifikasi',
                          value: terverifikasi.toString(),
                          icon: Icons.check_circle_outline),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Ajuan Verifikasi',
                          style: AppTypograph.label1.bold.copyWith(
                            color: AppColor.blackColor,
                          )),
                      const Spacer(),
                      GestureDetector(
                        onTap: widget.onTapPengajuan,
                        child: Text('See more',
                            style: AppTypograph.label3.bold.copyWith(
                              color: AppColor.primaryColor,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CardContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Tanggal',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Pasien',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Diagniosis AI',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Verifikasi',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                          ]),
                      (_showSpinner)
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            )
                          : (ajuans.isEmpty)
                              ? const Center(
                                  child: Text('Tidak ada data'),
                                )
                              : const SizedBox(),
                      if (ajuans.isNotEmpty)
                        for (int i = 0; i < ajuans.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      (ajuans[i]['submittedAt'] == null)
                                          ? 'Undefined'
                                          : DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(
                                                  ajuans[i]['submittedAt'])),
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                Expanded(
                                  child: Text(
                                      ajuans[i]['patientName'] ??
                                          'Tidak ada data',
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                Expanded(
                                  child: Text(
                                      '${ajuans[i]['diagnosisAi'] ?? '0.00% Melanoma'}',
                                      textAlign: TextAlign.center,
                                      style: AppTypograph.label2.bold.copyWith(
                                        color: AppColor.greenColor,
                                      )),
                                ),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, DetailPengajuanScreen.route);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.assignment,
                                            color: AppColor.whiteColor),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text('Verifikasi',
                                              style: AppTypograph.label3.medium
                                                  .copyWith(
                                                color: AppColor.whiteColor,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                    ],
                  )),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Pasien',
                          style: AppTypograph.label1.bold.copyWith(
                            color: AppColor.blackColor,
                          )),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/daftarPasien');
                        },
                        child: Text('See more',
                            style: AppTypograph.label3.bold.copyWith(
                              color: AppColor.primaryColor,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  CardContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Nama',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'No Telp',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Jumlah Ajuan',
                                textAlign: TextAlign.center,
                                style: AppTypograph.label1.bold,
                              ),
                            ),
                          ]),
                      (_showSpinnerPatient)
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            )
                          : const SizedBox(),
                      if (listPatients.isNotEmpty)
                        for (int i = 0; i < listPatients.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(listPatients[i]['name'],
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                Expanded(
                                  child: Text(listPatients[i]['phone'],
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                                Expanded(
                                  child: Text(
                                      '${listPatients[i]['submissionCount']}',
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTypograph.label2.regular.copyWith(
                                        color: AppColor.blackColor,
                                      )),
                                ),
                              ],
                            ),
                          ),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
