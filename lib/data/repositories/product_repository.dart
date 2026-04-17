import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flora_match/data/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<ProductModel>> getProducts() {
    return _firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    await _firestore.collection('products').add(productData);
  }
}
