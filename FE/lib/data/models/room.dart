import 'dart:io';

class Room {
  final int? id;
  final String? roomCode;
  final String? roomType;
  final String? roomName;
  final String? roomDescription;
  final double? roomPrice;
  final bool? isBoked;
  final String? photo;
  final File? photoFile;

  Room({
    this.id,
    this.roomCode,
    this.roomName,
    this.roomDescription,
    this.roomPrice,
    this.roomType,
    this.isBoked,
    this.photo,
    this.photoFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomCode': roomCode,
      'roomName': roomCode,
      'roomDescription': roomDescription,
      'isBoked': isBoked,
      'roomPrice': roomPrice,
      'roomType': roomType,
      'photo': photo
    };
  }

  factory Room.fromJson(Map<String, dynamic> jsonData) {
    return Room(
      id: jsonData['id'] ?? 0,
      roomCode: jsonData['roomCode'] ?? "",
      roomName: jsonData['roomName'] ?? "",
      roomDescription: jsonData['rommDescription'] ?? "",
      roomPrice: (jsonData['roomPrice'] ?? 0).toDouble(),
      roomType: jsonData['roomType'] ?? "",
      isBoked: jsonData['isBoked'] ?? false,
      photo: jsonData['photo'] ?? "",
    );
  }
}
