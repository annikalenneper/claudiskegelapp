import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtils {
  static Map<String, dynamic> normalizeData(Map<String, dynamic> data, String id) {
    return {
      ...data,
      'id': id,
      if (data['date'] is Timestamp) 'date': (data['date'] as Timestamp).toDate(),
    };
  }
}