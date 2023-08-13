import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/model/noteModel.dart';

class FirebaseApi {
  static FirebaseApi instance = FirebaseApi();
  Future<List<NodeModel>> getApiData() async {
    try {
      final data = await FirebaseFirestore.instance.collection('notes').get();
      final dataget =
          data.docs.map((e) => NodeModel.fromMap(e.data())).toList();
      return dataget;
    } catch (e) {
      throw Exception('No data');
    }
  }

  Future<List<NodeModel>> PostApi(String title, String subtitle) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('notes');
      DocumentReference documentReference = reference.doc();
      NodeModel nodeModel =
          NodeModel(id: documentReference.id, title: title, subtitle: subtitle);

      await documentReference.set(nodeModel.toMap());
      final data = await FirebaseFirestore.instance.collection('notes').get();
      final dataget =
          data.docs.map((e) => NodeModel.fromMap(e.data())).toList();
      return dataget;
    } catch (e) {
      print('error');
      throw Exception('No data');
    }
  }
}
