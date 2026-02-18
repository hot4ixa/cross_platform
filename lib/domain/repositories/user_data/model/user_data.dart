import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String userId;
  final String name;
  final String email;
  final String description;
  final Timestamp timestamp;
  final List<String> favorites;

  UserData({
    required this.userId,
    required this.name,
    required this.email,
    required this.description,
    required this.timestamp,
    this.favorites = const [],
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      description: json['description'] ?? '',
      timestamp: json['timestamp'] is Timestamp 
          ? json['timestamp'] as Timestamp 
          : Timestamp.now(),
      favorites: List<String>.from(json['favorites'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'description': description,
      'timestamp': timestamp,
      'favorites': favorites,
    };
  }
}