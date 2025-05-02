class NotificationModel {
  final String alertId;
  final String userId;
  final String message;
  final bool read;
  final int timestamp;

  NotificationModel({
    required this.alertId,
    required this.userId,
    required this.message,
    required this.read,
    required this.timestamp,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      alertId: map['alertId'],
      userId: map['userId'],
      message: map['message'],
      read: map['read'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'alertId': alertId,
      'userId': userId,
      'message': message,
      'read': read,
      'timestamp': timestamp,
    };
  }
}
