import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora_match/data/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      final docRef = _firestore.collection('users').doc(user.uid);
      final doc = await docRef.get();
      if (!doc.exists) {
        await docRef.set(user.toDocument());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromDocument(doc);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateUserRole(String uid, String role) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'roles': FieldValue.arrayUnion([role]),
        // If it's the first time setting a role, we might mark profile as partially complete
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
