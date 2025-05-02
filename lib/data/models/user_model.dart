import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String accountType;
  final bool verified;
  final bool isGuest;
  final List<dynamic> listingIds;
  final List<dynamic> savedEstateIds;

  String get fullName => isGuest ? 'Guest' : '$firstName $lastName'.trim();

  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.accountType,
    required this.verified,
    required this.listingIds,
    required this.savedEstateIds,
    this.isGuest = false,
  });

  factory UserModel.guest() {
    return UserModel(
      userId: 'guest',
      firstName: 'Guest',
      lastName: '',
      email: '',
      phone: '',
      accountType: 'guest',
      listingIds: [''],
      verified: false,
      isGuest: true,
        savedEstateIds: []
    );
  }

  factory UserModel.fromMap(String userId, Map<String, dynamic> data) {
    return UserModel(
      userId: userId,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      listingIds: data['listingIds'] ?? [''],
      accountType: data['accountType'] ?? 'standard',
      verified: data['verified'] ?? false,
        savedEstateIds: data['userSavings'] ?? ['']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'accountType': accountType,
      'listingIds':listingIds,
      'userId': userId,
      'verified': verified,
      'userSavings' : savedEstateIds,
    };
  }
}

