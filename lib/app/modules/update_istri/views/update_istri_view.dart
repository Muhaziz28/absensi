import 'package:absensi_project_app/app/routes/app_pages.dart';
import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../controllers/update_istri_controller.dart';

class UpdateIstriView extends GetView<UpdateIstriController> {
  UpdateIstriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(data);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Data Istri'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_ISTRI);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder(
            stream: controller.streamAllIstri(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (snapshot.data?.docs.length == 0 || snapshot.data == null)
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Lottie.network(
                          'https://assets4.lottiefiles.com/packages/lf20_hl5n0bwb.json',
                          height: 200),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'Data Kosong',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Silahkan tambahkan data istri anda',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              print(snapshot.data?.docs.length);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () =>
                            Get.toNamed(Routes.EDIT_ISTRI, arguments: data),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.grey),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  data['nama_istri'][0],
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              data['nama_istri'],
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  "Tempat Lahir : ${data['tempat_lahir'] ?? '-'}",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: light,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Tanggal Lahir : ${data['tanggal_lahir'] ?? '-'}",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: light,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Pekerjaan : ${data['pekerjaan'] ?? '-'}",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: light,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),

                            // icon edit dan delete
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print(snapshot
                                        .data?.docs[index].reference.id);
                                    controller.deleteIstri(snapshot
                                        .data?.docs[index].reference.id);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
