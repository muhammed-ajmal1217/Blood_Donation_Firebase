import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String todoref = "Doners";

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<DataModel> donorsRef;
  Reference main = FirebaseStorage.instance.ref();
  
  DatabaseService() {
    donorsRef = firestore.collection(todoref).withConverter<DataModel>(
          fromFirestore: (snapshot, _) => DataModel.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
  }
}
