import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatPendidikanController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> StreamAllRwPendidikan() async* {
    String uid = auth.currentUser!.uid;

    yield* await FirebaseFirestore.instance
        .collection('personil')
        .doc(uid)
        .collection('riwayat_pendidikan')
        .snapshots();
  }

  Future<void> deleteRwPendidikan(String? id) async {
    String uid = auth.currentUser!.uid;

    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Apakah anda yakin ingin menghapus data pendidikan?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.red,
      cancelTextColor: Colors.blue,
      buttonColor: Colors.white,
      onConfirm: () async {
        Get.back();
        Get.dialog(
          Center(
            child: CircularProgressIndicator(),
          ),
        );
        await firestore
            .collection('personil')
            .doc(uid)
            .collection('riwayat_pendidikan')
            .doc(id)
            .delete();
        Get.back();
        Get.snackbar("Success", "Data Pendidikan Berhasil Dihapus");
      },
      onCancel: () {},
    );
  }
}
