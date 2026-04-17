import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String phoneNumber;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final List<String> roles; // ['buyer', 'seller']
  final DateTime createdAt;
  final bool isProfileComplete;

  const UserModel({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
    this.email,
    this.photoURL,
    this.roles = const ['buyer'],
    required this.createdAt,
    this.isProfileComplete = false,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    print("Reading User from Document: ${doc.id}");
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      phoneNumber: data['phoneNumber'] ?? '',
      displayName: data['displayName'],
      email: data['email'],
      photoURL: data['photoURL'],
      roles: List<String>.from(data['roles'] ?? ['buyer']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isProfileComplete: data['isProfileComplete'] ?? false,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'roles': roles,
      'createdAt': Timestamp.fromDate(createdAt),
      'isProfileComplete': isProfileComplete,
    };
  }
  
  UserModel copyWith({
    String? uid,
    String? phoneNumber,
    String? displayName,
    String? email,
    String? photoURL,
    List<String>? roles,
    DateTime? createdAt,
    bool? isProfileComplete,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  @override
  List<Object?> get props => [uid, phoneNumber, displayName, email, photoURL, roles, createdAt, isProfileComplete];
}
