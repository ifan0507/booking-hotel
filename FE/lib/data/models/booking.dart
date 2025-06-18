import 'package:fe/data/models/room.dart';

class Booking {
  final int? id;
  final String? check_in;
  final String? check_out;
  final String? guest_fullName;
  final String? guest_email;
  final int? adults;
  final int? children;
  final int? total_guest;
  final String? confirmation_Code;
  final Room? room;

  Booking(
      {this.id,
      this.check_in,
      this.check_out,
      this.guest_email,
      this.guest_fullName,
      this.adults,
      this.children,
      this.confirmation_Code,
      this.total_guest,
      this.room});

  factory Booking.fromJson(Map<String, dynamic> jsonData) {
    return Booking(
        id: jsonData['id'] ?? "",
        check_in: jsonData['check_in'] ?? "",
        check_out: jsonData['check_out'] ?? "",
        guest_email: jsonData['guest_email'] ?? "",
        guest_fullName: jsonData['guest_fullName'] ?? "",
        adults: jsonData['adults'] ?? "",
        children: jsonData['children'] ?? "",
        confirmation_Code: jsonData['confirmation_Code'] ?? "",
        total_guest: jsonData['total_guest'] ?? "",
        room:
            jsonData['room'] != null ? Room.fromJson(jsonData['room']) : null);
  }
}
