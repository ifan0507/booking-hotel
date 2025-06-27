import 'package:fe/core/route/app_routes.dart';
import 'package:fe/data/models/booking.dart';
import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/booking_service.dart';
import 'package:fe/data/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingRoomController extends GetxController {
  final BookingService _bookingService = BookingService();
  final LoginService _loginService = LoginService();
  var userName = ''.obs;
  var userEmail = ''.obs;

  int? idRoom;
  String? roomName;
  double? roomPrice;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
    loadUserEmail();
  }

  void initControllers(Room room) {
    idRoom = room.id;
    roomName = room.roomName;
    roomPrice = room.roomPrice;
  }

  Future<void> loadUserName() async {
    try {
      final displayUserName = await _loginService.getUserName();
      userName.value = displayUserName;
    } catch (e) {
      userName.value = "";
    }
  }

  Future<void> loadUserEmail() async {
    try {
      final displayEmail = await _loginService.getEmail();
      userEmail.value = displayEmail;
    } catch (e) {
      userEmail.value = "";
    }
  }

  void addBooking() async {
    final roomId = idRoom ?? 0;
    final booking = Booking(
      checkInDate: checkInController.text.trim(),
      checkOutDate: checkOutController.text.trim(),
      guest_email: emailController.text.trim(),
      guest_fullName: fullNameController.text.trim(),
    );

    isLoading.value = true;

    final result = await _bookingService.bookingRoom(booking, roomId);

    isLoading.value = false;

    if (result != null) {
      print('Booking Code: ${result["bookingConfirmationCode"]}');
      print('Room: ${result["room"]["name"]}');

      Get.toNamed(Routes.SUCCESS_BOOKING, arguments: result);
    } else {
      Get.snackbar('Gagal', 'Terjadi kesalahan saat booking',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }
}
