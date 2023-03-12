import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddIstriController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAdd = false.obs;
  TextEditingController nama_istri = TextEditingController();
  TextEditingController tempat_lahir = TextEditingController();
  TextEditingController tanggal_lahir = TextEditingController();

  List<String> pekerjaan = [
    'Pilih Pekerjaan Istri',
    'Ibu Rumah Tangga',
    'Pegawai Negeri',
    'Pegawai Swasta',
    'Wiraswasta',
    'Lainnya',
  ];
  RxString selectedPekerjaan = 'Pilih Pekerjaan Istri'.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> store() async {
    isLoadingAdd.value = true;

    try {
      if (nama_istri.text.isEmpty ||
          tempat_lahir.text.isEmpty ||
          selectedPekerjaan.value == 'Pilih Pekerjaan Istri') {
        isLoadingAdd.value = false;
        Get.snackbar("Error", "Data Tidak Boleh Kosong");
        return;
      }
      String uid = await auth.currentUser!.uid;
      CollectionReference<Map<String, dynamic>> collectionReference =
          await firestore.collection('personil').doc(uid).collection('istri');

      QuerySnapshot<Map<String, dynamic>> snapIstri =
          await collectionReference.get();

      int id = snapIstri.docs.length + 1;

      List<String> tanggal = tanggal_lahir.text.split('/');
      String tanggalLahir = tanggal[0] + '/' + tanggal[1] + '/' + tanggal[2];

      await collectionReference.doc(id.toString()).set({
        'id': id.toString(),
        'nama_istri': nama_istri.text,
        'tempat_lahir': tempat_lahir.text,
        'pekerjaan': selectedPekerjaan.value,
        'tanggal_lahir': tanggalLahir,
      });

      Get.back();
      Get.snackbar("Success", "Data Istri Berhasil Ditambahkan");

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
