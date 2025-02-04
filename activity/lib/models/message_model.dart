class MessageModel {
  final String text;
  final bool isAdmin;
  final DateTime createdAt;

  MessageModel({
    required this.text,
    required this.isAdmin,
    required this.createdAt,
  });

  // JSON'dan nesne oluşturma
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      isAdmin: json['isAdmin'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Nesneyi JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isAdmin': isAdmin,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
