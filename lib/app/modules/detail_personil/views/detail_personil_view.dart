import 'package:flutter/material.dart';
import 'package:absensi_project_app/app/widgets/empty_state.dart';
import 'package:get/get.dart';

import '../controllers/detail_personil_controller.dart';

// ignore: must_be_immutable
class DetailPersonilView extends GetView<DetailPersonilController> {
  DetailPersonilView({Key? key}) : super(key: key);

  Map<String, dynamic> data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // print("UID => ${data['uid']}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Personil'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              Text(
                data['nama_user'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: controller.StreamAllRwPendidikan(data['uid']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data?.docs.length == 0) {
                return EmptyState();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  print('Data => $data');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Riwayat Pendidikan'),
                      Text(data['nama_pendidikan']),
                      Text(data['jenjang_pendidikan']),
                      Text(data['tahun_masuk']),
                      Text(data['tahun_lulus']),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
