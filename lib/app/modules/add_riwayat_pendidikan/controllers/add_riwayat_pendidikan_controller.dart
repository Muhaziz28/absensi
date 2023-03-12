import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRiwayatPendidikanController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAdd = false.obs;
  TextEditingController nama_pendidikan = TextEditingController();
  TextEditingController tahun_masuk = TextEditingController();
  TextEditingController tahun_lulus = TextEditingController();

  List<String> jenjang_pendidikan = [
    'Pilih Jenjang Pendidikan',
    'SD',
    'SMP/MTS',
    'SMA/SMK/MA',
    'DI',
    'DII',
    'DIII',
    'DIV',
    'S1',
    'S2',
    'S3',
  ];
  RxString selectedJenjangPendidikan = 'Pilih Jenjang Pendidikan'.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> store() async {
    isLoadingAdd.value = true;

    try {
      String uid = await auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> collectionReference =
          await firestore
              .collection('personil')
              .doc(uid)
              .collection('riwayat_pendidikan');

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await collectionReference.get();

      int id = snapshot.docs.length + 1;

      await collectionReference.doc(id.toString()).set({
        'nama_pendidikan': nama_pendidikan.text,
        'tahun_masuk': tahun_masuk.text,
        'tahun_lulus': tahun_lulus.text,
        'jenjang_pendidikan': selectedJenjangPendidikan.value,
      });

      Get.back();
      Get.snackbar("Success", "Data Pendidikan Berhasil Ditambahkan");

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
