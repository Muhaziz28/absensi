import 'package:absensi_project_app/app/widgets/save_button.dart';
import 'package:absensi_project_app/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_riwayat_pendidikan_controller.dart';

class AddRiwayatPendidikanView extends GetView<AddRiwayatPendidikanController> {
  const AddRiwayatPendidikanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tambah Riwayat Pendidikan'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            autocorrect: false,
            controller: controller.nama_pendidikan,
            decoration: InputDecoration(
              label: Text("Nama Jenjang Pendidikan"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            autocorrect: false,
            controller: controller.tahun_masuk,
            decoration: InputDecoration(
              label: Text("Tahun Masuk"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            autocorrect: false,
            controller: controller.tahun_lulus,
            decoration: InputDecoration(
              label: Text("Tahun Lulus"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            hint: Text("Pilih Jenjang Pendidikan"),
            value: controller.selectedJenjangPendidikan.value,
            items: controller.jenjang_pendidikan
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != 'Pilih Pekerjaan Istri') {
                controller.selectedJenjangPendidikan.value = value.toString();
                // print(controller.selectedPekerjaan.value);
              } else {
                // print('Pekerjaan Istri belum dipilih');
              }
            },
          ),
          const SizedBox(height: 20),
          SaveButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.store();
              }
            },
            child: Obx(
              () => controller.isLoading.isTrue
                  ? const CircularProgressIndicator()
                  : const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}
