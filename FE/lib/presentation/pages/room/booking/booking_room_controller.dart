import 'package:fe/core/route/app_routes.dart';
import 'package:fe/data/models/booking.dart';
import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/booking_service.dart';
import 'package:fe/data/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    DateTime dateNow = DateTime.now();
    String bookingDate = DateFormat('yyyy-MM-dd').format(dateNow);

    DateTime checkIn =
        DateFormat('yyyy-MM-dd').parse(checkInController.text.trim());
    DateTime checkOut =
        DateFormat('yyyy-MM-dd').parse(checkOutController.text.trim());

    int jumlahHari = checkOut.difference(checkIn).inDays;

    if (jumlahHari <= 0) {
      Get.snackbar('Invalid Date', 'Check-out must be after check-in',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (roomPrice == null) {
      Get.snackbar('Error', 'Room rates are not yet available');
      return;
    }
    double totalHarga = jumlahHari * roomPrice!;

    final roomId = idRoom ?? 0;
    final booking = Booking(
        bookingDate: bookingDate,
        checkInDate: checkInController.text.trim(),
        checkOutDate: checkOutController.text.trim(),
        guestEmail: emailController.text.trim(),
        guestFullName: fullNameController.text.trim(),
        phone_number: phoneController.text.trim(),
        total_price: totalHarga);

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
