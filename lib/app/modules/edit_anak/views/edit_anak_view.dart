import 'package:absensi_project_app/app/widgets/save_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:absensi_project_app/theme.dart';
import '../controllers/edit_anak_controller.dart';

class EditAnakView extends GetView<EditAnakController> {
  EditAnakView({Key? key}) : super(key: key);
  final Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nama_anak.text = data['nama_anak'] ?? '';
    controller.tempat_lahir.text = data['tempat_lahir'] ?? '';
    controller.tanggal_lahir.text = data['tanggal_lahir'] ?? '';
    controller.selectedPekerjaan.value = data['pekerjaan'] ?? '';
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Edit Data Anak'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            autocorrect: false,
            controller: controller.nama_anak,
            decoration: InputDecoration(
              label: Text("Nama Anak"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            autocorrect: false,
            controller: controller.tempat_lahir,
            decoration: InputDecoration(
              label: Text("Tempat Lahir"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            readOnly: true,
            controller: controller.tanggal_lahir,
            decoration: InputDecoration(
              label: Text("Tanggal Lahir"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                // controller.tanggal_lahir.text = date.toString();
                // print d/m/y
                controller.tanggal_lahir.text =
                    "${date.day}/${date.month}/${date.year}";
              } else {
                // print('tidak ada tanggal yang dipilih');
              }
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            hint: Text("Pilih Pekerjaan Anak"),
            value: controller.selectedPekerjaan.value,
            items: controller.pekerjaan
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != 'Pilih Pekerjaan Anak') {
                controller.selectedPekerjaan.value = value.toString();
              } else {
                // print('Pekerjaan Istri belum dipilih');
              }
            },
          ),
          const SizedBox(height: 20),
          SaveButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.updateAnak(data['id']);
              }
            },
            child: Obx(
              () => controller.isLoading.isTrue
                  ? const CircularProgressIndicator()
                  : const Text("Simpan"),
            ),
          )
        ],
      ),
    );
  }
}
