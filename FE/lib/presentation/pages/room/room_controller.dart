import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/room_service.dart';
import 'package:fe/data/services/booking_service.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  final RoomService _roomService = RoomService();
  final BookingService _bookingService = BookingService();
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  var rooms = <Room>[].obs;

  var isLoading = false.obs;
  var roomType = ''.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(roomType, (_) => loadRooms());
    roomType.value = 'All';
  }

  Future<void> loadRooms() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      List<Room> roomList = [];
      if (roomType.value == 'All') {
        roomList = await _roomService.getAllRoom();
      } else {
        roomList = await _roomService.getRoomByType(roomType.value);
      }
      rooms.value = roomList;
    } catch (e) {
      errorMessage.value = 'Failed to load rooms: $e';
      print('Error loading rooms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String generateRoomCode() {
    int maxNumber = 0;

    for (var room in rooms) {
      final code = room.roomCode;
      final number =
          int.tryParse(code.toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

      if (number > maxNumber) {
        maxNumber = number;
      }
    }

    final nextNumber = maxNumber + 1;
    return 'R${nextNumber.toString().padLeft(3, '0')}';
  }

  Future<void> refreshRooms() async {
    await loadRooms();
  }

  void deleteRoom(int id) async {
    final response = await _roomService.deleteRoom(id);

    if (response == null) {
      Get.snackbar("Success", "Delete room successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      await loadRooms();
      await _dashboardController.loadRooms();
    } else {
      Get.snackbar("Error", ' $response',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
