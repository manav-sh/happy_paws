import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseService firebase = FirebaseService();

class FirebaseService {
  // final firestore = FirebaseFirestore.instance;
  final dogCollection = FirebaseFirestore.instance.collection('dogs');
  final ngoCollection = FirebaseFirestore.instance.collection('ngos');

  Future<void> addDog({required Map<String, dynamic> dog}) async {
    try {
      await dogCollection.add(dog).then((value) async => {
            await dogCollection.doc(value.id).set({'id': value.id})
          });
    } catch (e) {
      // print(t);
    }
  }
}
