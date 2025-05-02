import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../core/auth_service/fiirebase_auth_service.dart';
import '../../core/firebase_instances.dart';
import '../../core/firebase_service/firebase_service.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addApartment({
  String type = "apartment",
  required String listingType,
  required String title,
  required String description,
  required String ownerId,
  required String ownerName,
  required String ownerPhoneNumber,
  required double price,
  required String currency,
  required String locationDescription,
  required String city,
  required double latitude,
  required double longitude,
  required List<XFile> images,
  String? videoTourUrl,
  bool isPromoted = false,
  required double area,
  required int totalRooms,
  required int totalBathrooms,
  required int totalKitchens,
  required bool hasBalcony,
  required bool hasParking,
  required bool hasElevator,
  required bool hasStorage,
  required bool hasAirConditioning,
  required bool hasWifi,
  required bool hasPool,
  required bool gymNearby,
  required bool isFurnished,
  required bool utilitiesIncluded,
  int? floor,
  int? totalFloors,
}) async {
  try {
    final estateRefPrimary = FirebaseInstances.primary
        .collection('estates')
        .doc('listings')
        .collection(type)
        .doc();

    final estateRefSecondary = FirebaseInstances.secondary
        .collection('estates')
        .doc('listings')
        .collection(type)
        .doc(estateRefPrimary.id); // Mirror the ID

    List<String> imageUrls = await FirebaseService().uploadImages(images, estateRefPrimary.id);

    final estateData = {
      'estateId': estateRefPrimary.id,
      'type': type,
      'listingType': listingType,
      'title': title,
      'description': description,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerPhoneNumber': ownerPhoneNumber,
      'price': price,
      'currency': currency,
      'locationDescription': locationDescription,
      'city': city,
      'country': 'Israel',
      'latitude': latitude,
      'longitude': longitude,
      'available': true,
      'images': imageUrls,
      'videoTourUrl': videoTourUrl ?? '',
      'isPromoted': isPromoted,
      'promotionReference': '',
      'listedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'views': 0,
      'savedCount': 0,
      'listingStatus': 'active',
      'ratingAverage': 0.0,
      'reviewCount': 0,
      'area': area,
      'totalRooms': totalRooms,
      'totalBathrooms': totalBathrooms,
      'totalKitchens': totalKitchens,
      'hasBalcony': hasBalcony,
      'hasParking': hasParking,
      'hasElevator': hasElevator,
      'hasStorage': hasStorage,
      'hasAirConditioning': hasAirConditioning,
      'hasWifi': hasWifi,
      'hasPool': hasPool,
      'gymNearby': gymNearby,
      'isFurnished': isFurnished,
      'utilitiesIncluded': utilitiesIncluded,
      'floor': floor ?? 0,
      'totalFloors': totalFloors ?? 0,
    };

// Add to user listing (only needs once)
    FirebaseService().addEstateToUserListings(userId: FirebaseAuthService().getCurrentUser()!.uid, estateId: estateRefPrimary.id);

// Write to both Firestores
    await Future.wait([
      estateRefPrimary.set(estateData),
      estateRefSecondary.set(estateData),
    ]);

  } catch (e) {
    throw Exception('Error adding estate: $e');
  }
}