import 'package:fe/data/models/booking.dart';
import 'package:fe/data/services/booking_service.dart';
import 'package:fe/data/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final BookingService _bookingService = BookingService();
  final LoginService _loginService = LoginService();

  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookingHistory();
  }

  Future<void> loadBookingHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get user email from storage
      final email = await _loginService.getEmail();
      userEmail.value = email;

      if (email.isEmpty) {
        errorMessage.value = 'User email not found. Please login again.';
        isLoading.value = false;
        return;
      }

      // Get booking history from API
      List<Booking>? bookingList =
          await _bookingService.getBookingHistory(email);

      if (bookingList != null) {
        bookings.value = bookingList;
        print('Loaded ${bookings.length} bookings');
      } else {
        errorMessage.value = 'Failed to load booking history';
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Error loading booking history: $e';
      print('Error in loadBookingHistory: $e');
    }
  }

  void cancelBooking(int bookingId) async {
    final response = await _bookingService.cancelBooking(bookingId);

    if (response == null) {
      Get.snackbar("Success", "cancel room successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      await loadBookingHistory();
    } else {
      Get.snackbar("Error", ' $response',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> refreshBookings() async {
    await loadBookingHistory();
  }
}
