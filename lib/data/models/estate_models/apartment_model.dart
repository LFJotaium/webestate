import 'package:cloud_firestore/cloud_firestore.dart';

import 'abstract_estate_model.dart';

class Apartment extends Estate {
  final int totalRooms;
  final int totalBathrooms;
  final int totalKitchens;
  final bool hasBalcony;
  final bool hasParking;
  final bool hasElevator;
  final bool hasStorage;
  final bool hasAirConditioning;
  final bool hasWifi;
  final bool hasPool;
  final bool gymNearby;
  final bool isFurnished;
  final bool utilitiesIncluded;
  final int floor;
  final int totalFloors;

  Apartment({

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
    required this.hasWifi,
    required this.hasPool,
    required this.gymNearby,
    required this.isFurnished,
    required this.utilitiesIncluded,
    required this.floor,
    required this.totalFloors,
  });

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
      'hasWifi': hasWifi,
      'hasPool': hasPool,
      'gymNearby': gymNearby,
      'isFurnished': isFurnished,
      'utilitiesIncluded': utilitiesIncluded,
      'floor': floor,
      'totalFloors': totalFloors,
    };
  }

  factory Apartment.fromMap(Map<String, dynamic> map) {
    return Apartment(
      estateId: map['estateId'] ?? '',
      type: map['type'] ?? '',
      area: map['area'] ?? 0,
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
      hasWifi: map['hasWifi'] ?? false,
      hasPool: map['hasPool'] ?? false,
      gymNearby: map['gymNearby'] ?? false,
      isFurnished: map['isFurnished'] ?? false,
      utilitiesIncluded: map['utilitiesIncluded'] ?? false,
      floor: map['floor'] ?? 0,
      totalFloors: map['totalFloors'] ?? 0,
    );
  }
}