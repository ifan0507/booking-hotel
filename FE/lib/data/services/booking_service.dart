import 'dart:convert';

import 'package:fe/core/utils/api.dart';
import 'package:fe/data/models/booking.dart';
import 'package:http/http.dart' as http;

class BookingService extends Api {
  Future<Map<String, dynamic>?> bookingRoom(Booking booking, int roomId) async {
    print('Booking data to be sent:');
    // print('Room ID: $roomId');
    // print('Check-in: ${booking.checkInDate}');
    // print('Check-out: ${booking.checkOutDate}');
    // print('Guest name: ${booking.guest_fullName}');
    // print('Guest email: ${booking.guest_email}');

    final url = Uri.parse('$baseUrl/bookings/room/$roomId/booking');

    // Gabungkan headers
    final headers = {
      ...getToken(),
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(booking.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Booking success response: $data');
        return data;
      } else {
        print('Failed response: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  Future<String?> checkOutBooking(int roomId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/bookings/check-out/$roomId'),
        headers: {
          'Content-Type': 'application/json',
          ...getToken(), // Untuk authentikasi admin
        },
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        throw Exception(
            'Failed to checkout room. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('[EXCEPTION] Error checkout room: $e');
      throw Exception('Failed to checkout room: $e');
    }
  }

  Future<List<Booking>?> getBookingHistory(String userEmail) async {
    final url = Uri.parse('$baseUrl/bookings/user/$userEmail/bookings');

    final headers = {
      ...getToken(),
      "Content-Type": "application/json",
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Booking> bookings =
            data.map((json) => Booking.fromJson(json)).toList();
        print('History bookings loaded: ${bookings.length}');
        return bookings;
      } else {
        print('Failed to load booking history: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred while loading history: $e');
      return null;
    }
  }

  Future<String?> cancelBooking(int bookingId) async {
    print(bookingId);
    final headers = {
      ...getToken(),
      "Content-Type": "application/json",
    };

    try {
      final request = await http.put(
          Uri.parse('$baseUrl/bookings/booking/$bookingId/cancel'),
          headers: headers);

      if (request.statusCode == 200 ||
          request.statusCode == 201 ||
          request.statusCode == 204) {
        return null;
      } else {
        print('[ERROR] Response: ${request.body}');
        return '${request.body}';
      }
    } catch (e) {
      print('[EXCEPTION] Error Cancel Booking: $e');
      return '$e';
    }
  }

  Future<List<Booking>?> getAllBookingHistory() async {
    final url = Uri.parse('$baseUrl/bookings/all-bookings');

    final headers = {
      ...getToken(),
      "Content-Type": "application/json",
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Booking> bookings =
            data.map((json) => Booking.fromJson(json)).toList();
        print('History bookings loaded: ${bookings.length}');
        return bookings;
      } else {
        print('Failed to load booking history: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred while loading history: $e');
      return null;
    }
  }
}
