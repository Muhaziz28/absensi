import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListPersonilController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> StreamAllPersonil() async* {
    yield* await FirebaseFirestore.instance.collection('personil').snapshots();
  }
}
