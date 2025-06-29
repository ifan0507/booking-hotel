import 'package:fe/data/models/room.dart';

class Booking {
  final int? id;
  final String? bookingDate;
  final String? checkInDate;
  final String? checkOutDate;
  final String? guestFullName;
  final String? guestEmail;
  final String? phone_number;
  final String? bookingConfirmationCode;
  final double? total_price;
  final Room? room;

  Booking(
      {this.id,
      this.bookingDate,
      this.checkInDate,
      this.checkOutDate,
      this.guestEmail,
      this.guestFullName,
      this.phone_number,
      this.bookingConfirmationCode,
      this.total_price,
      this.room});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingDate': bookingDate,
      'checkInDate': checkInDate,
      'checkOutDate': checkOutDate,
      'guestEmail': guestEmail,
      'guestFullName': guestFullName,
      'phone_number': phone_number,
      'bookingConfirmationCode': bookingConfirmationCode,
      'total_price': total_price,
      'room': room
    };
  }

  factory Booking.fromJson(Map<String, dynamic> jsonData) {
    return Booking(
        id: jsonData['id'] ?? "",
        bookingDate: jsonData['bookingDate'] ?? "",
        checkInDate: jsonData['checkInDate'] ?? "",
        checkOutDate: jsonData['checkOutDate'] ?? "",
        guestEmail: jsonData['guestEmail'] ?? "",
        guestFullName: jsonData['guestFullName'] ?? "",
        phone_number: jsonData['phone_number']?.toString(),
        bookingConfirmationCode: jsonData['bookingConfirmationCode'] ?? "",
        total_price: jsonData['total_price'] ?? 0.0,
        room:
            jsonData['room'] != null ? Room.fromJson(jsonData['room']) : null);
  }
}
