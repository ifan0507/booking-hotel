import 'package:fe/data/models/room.dart';

class Booking {
  final int? id;
  final String? checkInDate;
  final String? checkOutDate;
  final String? guest_fullName;
  final String? guest_email;
  final String? confirmation_Code;
  final Room? room;

  Booking(
      {this.id,
      this.checkInDate,
      this.checkOutDate,
      this.guest_email,
      this.guest_fullName,
      this.confirmation_Code,
      this.room});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'guest_email': guest_email,
      'guest_fullName': guest_fullName,
      'confirmation_Code': confirmation_Code,
      'room': room
    };
  }

  factory Booking.fromJson(Map<String, dynamic> jsonData) {
    return Booking(
        id: jsonData['id'] ?? "",
        checkInDate: jsonData['checkInDate'] ?? "",
        checkOutDate: jsonData['checkOutDate'] ?? "",
        guest_email: jsonData['guest_email'] ?? "",
        guest_fullName: jsonData['guest_fullName'] ?? "",
        confirmation_Code: jsonData['confirmation_Code'] ?? "",
        room:
            jsonData['room'] != null ? Room.fromJson(jsonData['room']) : null);
  }
}
