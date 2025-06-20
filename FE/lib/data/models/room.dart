import 'dart:io';

class Room {
  final int? id;
  final String? roomType;
  final double? roomPrice;
  final bool? isBoked;
  final String? photo;
  final File? photoFile;

  Room({
    this.id,
    this.roomPrice,
    this.roomType,
    this.isBoked,
    this.photo,
    this.photoFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomPrice': roomPrice,
      'roomType': roomType,
      'photo': photo
    };
  }

  factory Room.fromJson(Map<String, dynamic> jsonData) {
    return Room(
      id: jsonData['id'] ?? 0,
      roomPrice: (jsonData['roomPrice'] ?? 0).toDouble(),
      roomType: jsonData['roomType'] ?? "",
      isBoked: jsonData['isBoked'] ?? false,
      photo: jsonData['photo'] ?? "",
    );
  }
}
