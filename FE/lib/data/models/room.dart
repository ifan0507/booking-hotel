import 'dart:io';

class Room {
  final int? id;
  final String? roomCode;
  final String? roomType;
  final String? roomName;
  final String? roomDescription;
  final double? roomPrice;
  final bool? isBooked;
  final String? photo;
  final bool? ac;
  final bool? tv;
  final bool? miniBar;
  final bool? jacuzzi;
  final bool? balcony;
  final bool? kitchen;
  final File? photoFile;

  Room({
    this.id,
    this.roomCode,
    this.roomName,
    this.roomDescription,
    this.roomPrice,
    this.roomType,
    this.isBooked,
    this.photo,
    this.ac,
    this.tv,
    this.miniBar,
    this.balcony,
    this.jacuzzi,
    this.kitchen,
    this.photoFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomCode': roomCode,
      'roomName': roomName,
      'roomDescription': roomDescription,
      'isBooked': isBooked,
      'roomPrice': roomPrice,
      'roomType': roomType,
      'ac': ac,
      'tv': tv,
      'miniBar': miniBar,
      'balcony': balcony,
      'jacuzzi': jacuzzi,
      'kitchen': kitchen,
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
      isBooked: jsonData['isBooked'] ?? false,
      ac: jsonData['ac'] ?? false,
      tv: jsonData['tv'] ?? false,
      miniBar: jsonData['miniBar'] ?? false,
      balcony: jsonData['balcony'] ?? false,
      jacuzzi: jsonData['jacuzzi'] ?? false,
      kitchen: jsonData['kitchen'] ?? false,
      photo: jsonData['photo'] ?? "",
    );
  }
}
