import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAnakController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAdd = false.obs;
  TextEditingController nama_anak = TextEditingController();
  TextEditingController tempat_lahir = TextEditingController();
  TextEditingController tanggal_lahir = TextEditingController();

  List<String> pekerjaan = [
    'Pilih Pekerjaan Anak',
    'Pelajar',
    'Mahasiswa',
    'Belum Bekerja',
    'Lainnya',
  ];
  RxString selectedPekerjaan = 'Pilih Pekerjaan Anak'.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateAnak(String? id) async {
    isLoadingAdd.value = true;

    try {
      if (nama_anak.text.isEmpty ||
          tempat_lahir.text.isEmpty ||
          selectedPekerjaan.value == 'Pilih Pekerjaan Anak') {
        isLoadingAdd.value = false;
        Get.snackbar("Error", "Data Tidak Boleh Kosong");
        return;
      }
      String uid = await auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> collectionReference =
          await firestore.collection('personil').doc(uid).collection('anak');

      List<String> tanggal = tanggal_lahir.text.split('/');
      String tanggalLahir = tanggal[0] + '/' + tanggal[1] + '/' + tanggal[2];

      await collectionReference.doc(id).update({
        'nama_anak': nama_anak.text,
        'tempat_lahir': tempat_lahir.text,
        'pekerjaan': selectedPekerjaan.value,
        'tanggal_lahir': tanggalLahir,
      });

      Get.back();
      Get.snackbar("Success", "Data Anak Berhasil Diubah");

      isLoadingAdd.value = false;
    } on FirebaseAuthException catch (e) {
      isLoadingAdd.value = false;
      Get.snackbar("Error", e.message.toString());
    }
  }
}
