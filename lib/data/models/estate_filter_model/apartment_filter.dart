class ApartmentFilter {
  double? minPrice;
  double? maxPrice;
  int? minRooms;
  int? maxRooms;
  int? minBathrooms;
  int? maxBathrooms;
  int? minKitchens;
  int? maxKitchens;
  int? minFloor;
  int? maxFloor;
  bool? hasBalcony;
  bool? hasParking;
  bool? hasElevator;
  bool? hasStorage;
  bool? hasAirConditioning;
  bool? hasWifi;
  bool? hasPool;
  bool? gymNearby;
  bool? isFurnished;
  bool? utilitiesIncluded;
  String? city;
  String? country;
  String? listingType;

  ApartmentFilter({
    this.minPrice,
    this.maxPrice,
    this.minRooms,
    this.maxRooms,
    this.minBathrooms,
    this.maxBathrooms,
    this.minKitchens,
    this.maxKitchens,
    this.minFloor,
    this.maxFloor,
    this.hasBalcony,
    this.hasParking,
    this.hasElevator,
    this.hasStorage,
    this.hasAirConditioning,
    this.hasWifi,
    this.hasPool,
    this.gymNearby,
    this.isFurnished,
    this.utilitiesIncluded,
    this.city,
    this.country,
    this.listingType,
  });
}


extension ApartmentFilterCopyWith on ApartmentFilter {
  ApartmentFilter copyWith({
    double? minPrice,
    double? maxPrice,
    int? minRooms,
    int? maxRooms,
    int? minBathrooms,
    int? maxBathrooms,
    int? minKitchens,
    int? maxKitchens,
    int? minFloor,
    int? maxFloor,
    bool? hasBalcony,
    bool? hasParking,
    bool? hasElevator,
    bool? hasStorage,
    bool? hasAirConditioning,
    bool? hasWifi,
    bool? hasPool,
    bool? gymNearby,
    bool? isFurnished,
    bool? utilitiesIncluded,
    String? city,
    String? country,
    String? listingType,
  }) {
    return ApartmentFilter(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRooms: minRooms ?? this.minRooms,
      maxRooms: maxRooms ?? this.maxRooms,
      minBathrooms: minBathrooms ?? this.minBathrooms,
      maxBathrooms: maxBathrooms ?? this.maxBathrooms,
      minKitchens: minKitchens ?? this.minKitchens,
      maxKitchens: maxKitchens ?? this.maxKitchens,
      minFloor: minFloor ?? this.minFloor,
      maxFloor: maxFloor ?? this.maxFloor,
      hasBalcony: hasBalcony ?? this.hasBalcony,
      hasParking: hasParking ?? this.hasParking,
      hasElevator: hasElevator ?? this.hasElevator,
      hasStorage: hasStorage ?? this.hasStorage,
      hasAirConditioning: hasAirConditioning ?? this.hasAirConditioning,
      hasWifi: hasWifi ?? this.hasWifi,
      hasPool: hasPool ?? this.hasPool,
      gymNearby: gymNearby ?? this.gymNearby,
      isFurnished: isFurnished ?? this.isFurnished,
      utilitiesIncluded: utilitiesIncluded ?? this.utilitiesIncluded,
      city: city ?? this.city,
      country: country ?? this.country,
      listingType: listingType ?? this.listingType,
    );
  }
}