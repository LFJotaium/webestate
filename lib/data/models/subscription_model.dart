class SubscriptionModel {
  final String subscriptionId;
  final String userId;
  final String plan;
  final double price;
  final String currency;
  final String status;
  final int expiresAt;
  final int createdAt;

  SubscriptionModel({
    required this.subscriptionId,
    required this.userId,
    required this.plan,
    required this.price,
    required this.currency,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
  });

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      subscriptionId: map['subscriptionId'],
      userId: map['userId'],
      plan: map['plan'],
      price: map['price'].toDouble(),
      currency: map['currency'],
      status: map['status'],
      expiresAt: map['expiresAt'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subscriptionId': subscriptionId,
      'userId': userId,
      'plan': plan,
      'price': price,
      'currency': currency,
      'status': status,
      'expiresAt': expiresAt,
      'createdAt': createdAt,
    };
  }
}
