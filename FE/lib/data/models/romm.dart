class Romm {
  final int? id;
  final String? roomType;
  final double? rommPrice;
  final bool? isBoked;
  final String? photo;

  Romm({
    this.id,
    this.rommPrice,
    this.roomType,
    this.isBoked,
    this.photo,
  });

  factory Romm.fromJson(Map<String, dynamic> jsonData) {
    return Romm(
        id: jsonData['id'] ?? "",
        rommPrice: jsonData['rommPrice'] ?? "",
        roomType: jsonData['roomType'] ?? "",
        photo: jsonData['photo'] ?? "");
  }
}
