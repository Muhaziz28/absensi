import 'package:absensi_project_app/app/widgets/save_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:absensi_project_app/theme.dart';
import '../controllers/add_istri_controller.dart';

class AddIstriView extends GetView<AddIstriController> {
  const AddIstriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Tambah Data Istri'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: controller.nama_istri,
            decoration: InputDecoration(
              label: Text("Nama Istri"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
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
            hint: Text("Pilih Pekerjaan Istri"),
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
              if (value != 'Pilih Pekerjaan Istri') {
                controller.selectedPekerjaan.value = value.toString();
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
          )
        ],
      ),
    );
  }
}
