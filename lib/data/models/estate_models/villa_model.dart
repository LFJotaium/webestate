import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_estate_model.dart';

class Villa extends Estate {
  final int totalRooms;
  final int totalBathrooms;
  final int totalKitchens;
  final bool hasBalcony;
  final bool hasParking;
  final bool hasElevator;
  final bool hasStorage;
  final bool hasAirConditioning;
  final bool isFurnished;
  final bool utilitiesIncluded;
  final double distanceFromCenter;
  final bool publicTransportAccess;
  final List<String> amenities;

  Villa({
    required super.estateId,
    required super.type,
    required super.listingType,
    required super.title,
    required super.description,
    required super.ownerId, 
    required super.ownerName,
    required super.ownerPhoneNumber,
    required super.price,
    required super.currency,
    required super.locationDescription,
    required super.city,
    required super.country,
    required super.latitude,
    required super.longitude,
    required super.available,
    required super.images,
    required super.videoTourUrl,
    required super.isPromoted,
    required super.promotionReference,
    required super.listedAt,
    required super.updatedAt,
    required super.views,
    required super.savedCount,
    required super.listingStatus,
    required super.ratingAverage,
    required super.reviewCount,
    required super.area,

    required this.totalRooms,
    required this.totalBathrooms,
    required this.totalKitchens,
    required this.hasBalcony,
    required this.hasParking,
    required this.hasElevator,
    required this.hasStorage,
    required this.hasAirConditioning,
    required this.isFurnished,
    required this.utilitiesIncluded,
    required this.distanceFromCenter,
    required this.publicTransportAccess,
    required this.amenities,
  });

  /// Converts Villa object to a Firestore-friendly map
  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'totalRooms': totalRooms,
      'totalBathrooms': totalBathrooms,
      'totalKitchens': totalKitchens,
      'hasBalcony': hasBalcony,
      'hasParking': hasParking,
      'hasElevator': hasElevator,
      'hasStorage': hasStorage,
      'hasAirConditioning': hasAirConditioning,
      'isFurnished': isFurnished,
      'utilitiesIncluded': utilitiesIncluded,
      'distanceFromCenter': distanceFromCenter,
      'publicTransportAccess': publicTransportAccess,
      'amenities': amenities,
    };
  }

  /// Factory constructor to create a Villa object from Firestore
  factory Villa.fromMap(Map<String, dynamic> map) {
    return Villa(
      estateId: map['estateId'] ?? '',
      area: map['area'] ?? 0,
      type: map['type'] ?? '',
      listingType: map['listingType'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ownerId: map['ownerId'] ?? '',
      ownerName: map['ownerName'] ?? '',
      ownerPhoneNumber: map['ownerPhoneNumber'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      currency: map['currency'] ?? '',
      locationDescription: map['locationDescription'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      available: map['available'] ?? false,
      images: List<String>.from(map['images'] ?? []),
      videoTourUrl: map['videoTourUrl'] ?? '',
      isPromoted: map['isPromoted'] ?? false,
      promotionReference: map['promotionReference'] ?? '',
      listedAt: (map['listedAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      views: map['views'] ?? 0,
      savedCount: map['savedCount'] ?? 0,
      listingStatus: map['listingStatus'] ?? '',
      ratingAverage: (map['ratingAverage'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      totalRooms: map['totalRooms'] ?? 0,
      totalBathrooms: map['totalBathrooms'] ?? 0,
      totalKitchens: map['totalKitchens'] ?? 0,
      hasBalcony: map['hasBalcony'] ?? false,
      hasParking: map['hasParking'] ?? false,
      hasElevator: map['hasElevator'] ?? false,
      hasStorage: map['hasStorage'] ?? false,
      hasAirConditioning: map['hasAirConditioning'] ?? false,
      isFurnished: map['isFurnished'] ?? false,
      utilitiesIncluded: map['utilitiesIncluded'] ?? false,
      distanceFromCenter: (map['distanceFromCenter'] ?? 0).toDouble(),
      publicTransportAccess: map['publicTransportAccess'] ?? false,
      amenities: List<String>.from(map['amenities'] ?? []),
    );
  }
}
