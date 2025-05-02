class PromotionModel {
  final String promotionId;
  final String estateId;
  final String userId;
  final double price;
  final String duration;
  final String status;
  final int endsAt;
  final int createdAt;

  PromotionModel({
    required this.promotionId,
    required this.estateId,
    required this.userId,
    required this.price,
    required this.duration,
    required this.status,
    required this.endsAt,
    required this.createdAt,
  });

  factory PromotionModel.fromMap(Map<String, dynamic> map) {
    return PromotionModel(
      promotionId: map['promotionId'],
      estateId: map['estateId'],
      userId: map['userId'],
      price: map['price'].toDouble(),
      duration: map['duration'],
      status: map['status'],
      endsAt: map['endsAt'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'promotionId': promotionId,
      'estateId': estateId,
      'userId': userId,
      'price': price,
      'duration': duration,
      'status': status,
      'endsAt': endsAt,
      'createdAt': createdAt,
    };
  }
}
