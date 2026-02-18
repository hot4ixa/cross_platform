import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/model.dart';
import 'user_data_service_interface.dart';

class UserDataService extends UserDataServiceInterface {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<UserData> getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final snapshot = await users.doc(user.uid).get();

      if (!snapshot.exists) {
        throw Exception('User data not found. Please create user profile first.');
      }

      final data = snapshot.data();
      if (data == null) {
        throw Exception('User data is null');
      }

      return UserData.fromJson(data as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
        'email': email,
        'description': '',
        'favorites': [],
        'timestamp': Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> updateUserData({
    required String name,
    required String description,
  }) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'name': name,
        'description': description,
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> deleteUserData() async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).delete();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> addToFavorites(String itemId) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'favorites': FieldValue.arrayUnion([itemId]),
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> removeFromFavorites(String itemId) async {
    try {
      await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'favorites': FieldValue.arrayRemove([itemId]),
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<bool> isFavorite(String itemId) async {
    try {
      final snapshot = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (!snapshot.exists) return false;

      final data = snapshot.data() as Map<String, dynamic>?;
      final favorites = List<String>.from(data?['favorites'] ?? []);
      return favorites.contains(itemId);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }
}
