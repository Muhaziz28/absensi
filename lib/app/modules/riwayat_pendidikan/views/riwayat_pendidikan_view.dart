import 'package:absensi_project_app/app/routes/app_pages.dart';
import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:absensi_project_app/app/widgets/empty_state.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_pendidikan_controller.dart';

class RiwayatPendidikanView extends GetView<RiwayatPendidikanController> {
  const RiwayatPendidikanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Riwayat Pendidikan'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_RIWAYAT_PENDIDIKAN);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder(
            stream: controller.StreamAllRwPendidikan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (snapshot.data?.docs.length == 0 || snapshot.data == null)
                return EmptyState();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        data['nama_pendidikan'],
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text("Tahun masuk : ${data['tahun_masuk']}"),
                          Text("Tahub lulus : ${data['tahun_lulus']}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              print(snapshot.data?.docs[index].reference.id);
                              controller.deleteRwPendidikan(
                                  snapshot.data?.docs[index].reference.id);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
