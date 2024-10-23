import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final FirebaseFirestore _db;

  FirebaseRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  Stream<Map<String, dynamic>> getLocStream() {
    return _db.collection('EspData').doc('neo6m').snapshots().map((snapshot) {
      return snapshot.data() ?? {};
    }).handleError((error) {
      print('Error fetching data: $error');
      return {};
    });
  }
}
