import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/data_model.dart';

const String todoref = "Doners";

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<DataModel> donorsRef;

  DatabaseService() {
    donorsRef = firestore.collection(todoref).withConverter<DataModel>(
          fromFirestore: (snapshot, snapshotOptions) => DataModel.fromJson(snapshot.data()!),
          toFirestore: (data, setOptions) => data.toJson(),
        );
  }
}
