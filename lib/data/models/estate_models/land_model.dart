import 'package:cloud_firestore/cloud_firestore.dart';
import 'abstract_estate_model.dart';

class Land extends Estate {
  final bool roadAccess;
  final String landUse;

  Land({
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
    required this.roadAccess,
    required this.landUse,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'roadAccess': roadAccess,
      'landUse': landUse,
    };
  }

  factory Land.fromMap(Map<String, dynamic> map) {
    return Land(
      estateId: map['estateId'] ?? '',
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
      area: (map['area'] ?? 0).toDouble(),
      roadAccess: map['roadAccess'] ?? false,
      landUse: map['landUse'] ?? '',
    );
  }

}
String getLandUseInArabic(String landUse) {
  switch (landUse.toLowerCase()) {
    case 'agriculture':
      return 'زراعية';
    case 'residential':
      return 'بناء';
    case 'industrial':
      return 'صناعية';
    default:
      return 'غير محدد';
  }
}