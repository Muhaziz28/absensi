import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailPersonilController extends GetxController {
  String? uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference personil =
      FirebaseFirestore.instance.collection('personil');

// StreamAllRwPendidikan memerlukan uid yang dikirimkan dari view
// sehingga perlu diubah menjadi StreamAllRwPendidikan(String uid) async* {}
  Stream<QuerySnapshot<Map<String, dynamic>>> StreamAllRwPendidikan(
      uid) async* {
    yield* await FirebaseFirestore.instance
        .collection('personil')
        .doc(uid)
        .collection('riwayat_pendidikan')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> StreamAllAnak() async* {
    yield* await FirebaseFirestore.instance
        .collection('personil')
        .doc(uid)
        .collection('anak')
        .snapshots();
  }
}
