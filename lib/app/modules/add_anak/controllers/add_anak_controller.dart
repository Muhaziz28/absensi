import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAnakController extends GetxController {
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

  Future<void> store() async {
    isLoadingAdd.value = true;

    try {
      String uid = await auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> collectionReference =
          await firestore.collection('personil').doc(uid).collection('anak');

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await collectionReference.get();

      int id = snapshot.docs.length + 1;

      List<String> tanggal = tanggal_lahir.text.split('/');
      String tanggalLahir = tanggal[0] + '/' + tanggal[1] + '/' + tanggal[2];

      await collectionReference.doc(id.toString()).set({
        'id': id.toString(),
        'nama_anak': nama_anak.text,
        'tempat_lahir': tempat_lahir.text,
        'pekerjaan': selectedPekerjaan.value,
        'tanggal_lahir': tanggalLahir,
      });

      Get.back();
      Get.snackbar("Success", "Data Anak Berhasil Ditambahkan");

      isLoadingAdd.value = false;
    } on FirebaseAuthException catch (e) {
      isLoadingAdd.value = false;
      Get.snackbar("Error", e.toString());
    } catch (e) {
      isLoadingAdd.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
