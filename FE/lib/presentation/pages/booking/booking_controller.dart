import 'package:fe/data/models/booking.dart';
import 'package:fe/data/services/booking_service.dart';
import 'package:fe/data/services/login_service.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:fe/presentation/pages/room/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final BookingService _bookingService = BookingService();
  final LoginService _loginService = LoginService();
  final RoomController _roomController = Get.put(RoomController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  var bookings = <Booking>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookingHistory();
  }

  Future<void> loadBookingHistory() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final email = await _loginService.getEmail();
      final isAdmin = await _loginService.isAdmin();

      if (email.isEmpty) {
        errorMessage.value = 'User email not found. Please login again.';
        isLoading.value = false;
        return;
      }

      List<Booking>? bookingList = [];

      if (isAdmin) {
        bookingList = await _bookingService.getAllBookingHistory();
      } else {
        bookingList = await _bookingService.getBookingHistory(email);
      }

      if (bookingList != null) {
        bookings.value = bookingList;
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

  Future<void> checkOutBooking(int bookingId) async {
    try {
      isLoading.value = true;

      final response = await _bookingService.checkOutBooking(bookingId);

      if (response == null) {
        await _roomController.loadRooms();
        await _dashboardController.loadRooms();
        Get.snackbar(
          'Success',
          'Room checkout successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to checkout room: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshBookings() async {
    await loadBookingHistory();
  }
}
