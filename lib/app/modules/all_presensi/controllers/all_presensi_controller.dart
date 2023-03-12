import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPresensiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? start;
  DateTime end = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> streamAllPresence() async {
    String uid = auth.currentUser!.uid;

    if (start == null) {
      return await FirebaseFirestore.instance
          .collection('personil')
          .doc(uid)
          .collection('presence')
          .where('date', isLessThan: end.toIso8601String())
          .orderBy('date', descending: true)
          .get();
    } else {
      return await FirebaseFirestore.instance
          .collection('personil')
          .doc(uid)
          .collection('presence')
          .where('date', isGreaterThan: start!.toIso8601String())
          .where('date',
              isLessThan: end.add(Duration(days: 1)).toIso8601String())
          .orderBy('date', descending: true)
          .get();
    }
  }

  void pickDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end = pickEnd;
    update();
    Get.back();
  }
}
