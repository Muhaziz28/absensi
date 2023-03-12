import 'package:absensi_project_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:absensi_project_app/app/widgets/empty_state.dart';
import 'package:get/get.dart';
import 'package:absensi_project_app/theme.dart';
import '../controllers/anak_controller.dart';

class AnakView extends GetView<AnakController> {
  const AnakView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Data Anak'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_ANAK);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder(
            stream: controller.StreamAllAnak(),
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () =>
                            Get.toNamed(Routes.EDIT_ANAK, arguments: data),
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
                                  data['nama_anak'][0],
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              data['nama_anak'],
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
                                    controller.deleteAnak(snapshot
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
