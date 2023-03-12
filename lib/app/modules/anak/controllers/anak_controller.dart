import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnakController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> StreamAllAnak() async* {
    String uid = auth.currentUser!.uid;

    yield* await FirebaseFirestore.instance
        .collection('personil')
        .doc(uid)
        .collection('anak')
        .snapshots();
  }

  Future<void> deleteAnak(String? id) async {
    String uid = auth.currentUser!.uid;

    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Apakah anda yakin ingin menghapus data anak?",
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
            .collection('anak')
            .doc(id)
            .delete();
        Get.back();
        Get.snackbar("Success", "Data Anak Berhasil Dihapus");
      },
      onCancel: () {},
    );
  }
}
