
import 'villa_model.dart';

import 'apartment_model.dart';
import 'house_model.dart';
import 'land_model.dart';

abstract class Estate  {
  final String estateId;
  final String type;
  final String listingType;
  final String title;
  final String description;
  final String ownerId;
  final String ownerName;
  final String ownerPhoneNumber;
  final double price;
  final String currency;
  final String locationDescription;
  final String city;
  final String country;
  final double latitude;
  final double longitude;
  final bool available;
  final List<String> images;
  final String videoTourUrl;
  final bool isPromoted;
  final String promotionReference;
  final DateTime listedAt;
  final DateTime updatedAt;
  final int views;
  final int savedCount;
  final String listingStatus;
  final double ratingAverage;
  final int reviewCount;
  final double area;

  Estate({
    required this.estateId,
    required this.type,
    required this.listingType,
    required this.title,
    required this.description,
    required this.ownerId,
    required this.ownerName,
    required this.ownerPhoneNumber,
    required this.price,
    required this.currency,
    required this.locationDescription,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.available,
    required this.images,
    required this.videoTourUrl,
    required this.isPromoted,
    required this.promotionReference,
    required this.listedAt,
    required this.updatedAt,
    required this.views,
    required this.savedCount,
    required this.listingStatus,
    required this.ratingAverage,
    required this.reviewCount,
    required this.area,
  });

  Map<String, dynamic> toMap() {
    return {
      'estateId': estateId,
      'type' : type,
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
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'available': available,
      'images': images,
      'videoTourUrl': videoTourUrl,
      'isPromoted': isPromoted,
      'promotionReference': promotionReference,
      'listedAt': listedAt,
      'updatedAt': updatedAt,
      'views': views,
      'savedCount': savedCount,
      'listingStatus': listingStatus,
      'ratingAverage': ratingAverage,
      'reviewCount': reviewCount,
      'area' : area,
    };

  }
  factory Estate.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'apartment':
        return House.fromMap(json);
      case 'villa':
        return Villa.fromMap(json);
      case 'house':
        return House.fromMap(json);
      case 'land':
        return Land.fromMap(json);
      default:
        throw ArgumentError('Unknown estate type: $type');
    }
  }
}
