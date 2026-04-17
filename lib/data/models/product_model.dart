import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String shopId;
  final String title;
  final String description;
  final double price;
  final int stock;
  final List<String> images;
  final String categoryId;
  final DateTime createdAt;

  const ProductModel({
    required this.id,
    required this.shopId,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
    required this.categoryId,
    required this.createdAt,
  });

  factory ProductModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      shopId: data['shopId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
      images: List<String>.from(data['images'] ?? []),
      categoryId: data['categoryId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'shopId': shopId,
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'images': images,
      'categoryId': categoryId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  @override
  List<Object?> get props => [id, shopId, title, price, images];
}
