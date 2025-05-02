class SavedEstatesModel {
  final String userId;
  final String estateId;
  final int savedAt;

  SavedEstatesModel({
    required this.userId,
    required this.estateId,
    required this.savedAt,
  });

  factory SavedEstatesModel.fromMap(Map<String, dynamic> map) {
    return SavedEstatesModel(
      userId: map['userId'],
      estateId: map['estateId'],
      savedAt: map['savedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'estateId': estateId,
      'savedAt': savedAt,
    };
  }
}
