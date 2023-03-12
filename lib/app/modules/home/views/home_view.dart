import 'package:absensi_project_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:absensi_project_app/theme.dart';
import '../../../controllers/page_index_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final pageController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.stremUser(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                String role = snap.data!.data()!['role'];
                if (role == 'Operator') {
                  // operator
                  return IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.ADD_PERSONIL);
                    },
                    icon: const Icon(Icons.person_add),
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
      body: StreamBuilder(
          stream: controller.stremUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<String, dynamic> data = snap.data!.data()!;

            if (snap.hasData) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              data["foto_profile"] == null
                                  ? 'https://ui-avatars.com/api/?name=${data["nama_user"]}'
                                  : data["foto_profile"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['nama_user'] != null
                                  ? '${data['nama_user']}'
                                  : '',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              data['nrp'] != null
                                  ? 'NRP: ${data['nrp']}'
                                  : 'NRP: -',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: StreamBuilder(
                      stream: controller.stremPresenceToday(),
                      builder: (context, snapPresenceToday) {
                        if (snapPresenceToday.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        Map<String, dynamic>? dataToday =
                            snapPresenceToday.data?.data();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '${dataToday?["check_in"] == null ? '-' : DateFormat('HH:mm').format(DateTime.parse(dataToday?['check_in']?['date']))}',
                                ),
                              ],
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Keluar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                    '${dataToday?["check_out"] == null ? '-' : DateFormat('HH:mm').format(DateTime.parse(dataToday?['check_out']?['date']))}'),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Menu",
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            menu(
                              icon: Icons.woman_2_rounded,
                              data: data,
                              judul: 'Data \nIstri',
                              onTap: () => Get.toNamed(
                                Routes.UPDATE_ISTRI,
                                arguments: data,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            menu(
                              icon: Icons.child_care_outlined,
                              data: data,
                              judul: 'Data \nAnak',
                              onTap: () => Get.toNamed(
                                Routes.ANAK,
                                arguments: data,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            menu(
                              icon: Icons.book_online,
                              data: data,
                              judul: 'Data \nPendidikan',
                              onTap: () => Get.toNamed(
                                Routes.RIWAYAT_PENDIDIKAN,
                                arguments: data,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            menu(
                              icon: Icons.policy_outlined,
                              data: data,
                              judul: 'Data \nKepolisian',
                              onTap: () => Get.toNamed(
                                Routes.DATA_KEPOLISIAN,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            menu(
                                icon: Icons.people,
                                data: data,
                                judul: 'Data \nPersonil',
                                onTap: () => Get.toNamed(
                                      Routes.LIST_PERSONIL,
                                      arguments: data,
                                    )),
                            const SizedBox(
                              width: 10,
                            ),
                            menu(
                              icon: Icons.fact_check_rounded,
                              data: data,
                              judul: 'Data \nAbsensi',
                              onTap: () => Get.toNamed(Routes.ALL_DATA_ABSENSI),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            menu(
                              icon: Icons.wallet_outlined,
                              data: data,
                              judul: 'Tunjangan \nKinerja',
                              onTap: () =>
                                  Get.toNamed(Routes.TUNJANGAN_KINERJA),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            menu(
                              icon: Icons.report,
                              data: data,
                              judul: 'Report \nKinerja',
                              onTap: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Absensi Hari Ini',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.ALL_PRESENSI),
                        child: Text('Lihat Semua'),
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.stremPresence(),
                      builder: (context, snapPresence) {
                        if (snapPresence.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapPresence.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('Belum ada data'),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapPresence.data!.docs.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataPresence =
                                snapPresence.data!.docs[index].data();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.PRESENSI_DETAIL,
                                        arguments: dataPresence);
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Masuk',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Text(dataPresence['check_in']
                                                        ?['date'] ==
                                                    null
                                                ? '-'
                                                : '${DateFormat('dd MMMM yyyy').format(DateTime.parse(dataPresence['check_in']?['date']))}'),
                                          ],
                                        ),
                                        Text(
                                            '${DateFormat('dd MMMM yyyy').format(DateTime.parse(dataPresence['date']))}'),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Keluar',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text(dataPresence['check_out']
                                                    ?['date'] ==
                                                null
                                            ? '-'
                                            : '${DateFormat('dd MMMM yyyy').format(DateTime.parse(dataPresence['check_in']?['date']))}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      })
                ],
              );
            } else {
              return const Center(
                child: Text('Gagal memuat data'),
              );
            }
          }),
      bottomNavigationBar: ConvexAppBar(
        // style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(
            icon: Icons.fingerprint,
            title: 'Absen',
          ),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageController.currentIndex.value,
        onTap: (int i) => pageController.changePage(i),
      ),
    );
  }
}

class menu extends StatelessWidget {
  final String judul;
  final IconData icon;
  final Function()? onTap;

  menu({
    super.key,
    required this.data,
    required this.onTap,
    required this.icon,
    required this.judul,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        width: 70,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: blackColor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              judul,
              style: blackTextStyle.copyWith(
                fontSize: 10,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
