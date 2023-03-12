import 'package:absensi_project_app/app/routes/app_pages.dart';
import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:absensi_project_app/app/widgets/empty_state.dart';
import 'package:get/get.dart';

import '../controllers/list_personil_controller.dart';

class ListPersonilView extends GetView<ListPersonilController> {
  ListPersonilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Data Personil'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder(
            stream: controller.StreamAllPersonil(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (snapshot.data?.docs.length == 0 || snapshot.data == null)
                return EmptyState();
              print(snapshot.data?.docs.length);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () =>
                        Get.toNamed(Routes.DETAIL_PERSONIL, arguments: data),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: ClipOval(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  data["foto_profile"] == null
                                      ? 'https://ui-avatars.com/api/?name=${data["nama_user"]}'
                                      : data["foto_profile"],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(data['nama_user']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['role']),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Get.toNamed(Routes.ADD_PERSONIL),
          child: const Text('Tambah Personil'),
        ),
      ),
    );
  }
}
