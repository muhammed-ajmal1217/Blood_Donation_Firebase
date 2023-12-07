import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/data_model.dart';
import 'package:firebase/service/database_service.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier{
  DatabaseService service=DatabaseService();
    Stream<QuerySnapshot<DataModel>> getDoners() {
    return service.donorsRef.snapshots();
  }
  Future<void> addDonator(DataModel data) async {
    await service.donorsRef.add(data);
    notifyListeners();
  }
   Future<void> updateDonator(id, DataModel doners) async {
    service.donorsRef.doc(id).update(doners.toJson());
    notifyListeners();
  }
   Future<void> deleteDonator(id) async {
    service.donorsRef.doc(id).delete();
    notifyListeners();
  }
}