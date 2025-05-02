import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_estate_model.dart';

class CommercialProperty extends Estate {
  final String businessType; // e.g., bakery, salon, office, clinic
  final bool hasCustomerParking;
  final bool hasLoadingZone;
  final bool hasSecuritySystem;
  final bool hasRestroom;
  final int totalRooms;
  final double ceilingHeight;

  CommercialProperty({
    required super.estateId,
    required super.type,
    required super.area,
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
    required this.businessType,
    required this.hasCustomerParking,
    required this.hasLoadingZone,
    required this.hasSecuritySystem,
    required this.hasRestroom,

    required this.totalRooms,
    required this.ceilingHeight,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'businessType': businessType,
      'hasCustomerParking': hasCustomerParking,
      'hasLoadingZone': hasLoadingZone,
      'hasSecuritySystem': hasSecuritySystem,
      'hasRestroom': hasRestroom,
      'totalRooms': totalRooms,
      'ceilingHeight': ceilingHeight,
    };
  }

  factory CommercialProperty.fromMap(Map<String, dynamic> map) {
    return CommercialProperty(
      estateId: map['estateId'] ?? '',
      type: map['type'] ?? '',
      area: (map['area'] ?? 0).toDouble(),
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
      businessType: map['businessType'] ?? '',
      hasCustomerParking: map['hasCustomerParking'] ?? false,
      hasLoadingZone: map['hasLoadingZone'] ?? false,
      hasSecuritySystem: map['hasSecuritySystem'] ?? false,
      hasRestroom: map['hasRestroom'] ?? false,
      totalRooms: map['totalRooms'] ?? 0,
      ceilingHeight: (map['ceilingHeight'] ?? 0.0).toDouble(),
    );
  }
}
