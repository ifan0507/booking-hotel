import 'dart:io';

import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/room_service.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:fe/presentation/pages/room/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoomController extends GetxController {
  final RoomService _roomService = RoomService();
  final RoomController _roomController = Get.put(RoomController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  final roomCodeController = TextEditingController();
  final roomTypeController = TextEditingController();
  final roomNameController = TextEditingController();
  final roomDescriptionController = TextEditingController();
  final roomPriceController = TextEditingController();
  final totalGuestController = TextEditingController();

  final isFullScreen = false.obs;
  final isLoading = false.obs;
  var isFormValid = false.obs;

  final ac = false.obs;
  final tv = false.obs;
  final miniBar = false.obs;
  final jacuzzi = false.obs;
  final balcony = false.obs;
  final kitchen = false.obs;
  File? photoFile;

  bool isRoomTypeValid() => roomTypeController.text.trim().isNotEmpty;
  bool isRoomNameValid() => roomNameController.text.trim().isNotEmpty;
  bool isRoomDescriptionValid() =>
      roomDescriptionController.text.trim().isNotEmpty;
  bool isRoomPriceValid() => roomPriceController.text.trim().isNotEmpty;
  bool isTotalGuestValid() => totalGuestController.text.trim().isNotEmpty;

  @override
  void onInit() {
    roomTypeController.addListener(validateForm);
    roomNameController.addListener(validateForm);
    roomDescriptionController.addListener(validateForm);
    roomPriceController.addListener(validateForm);
    totalGuestController.addListener(validateForm);
    super.onInit();
  }

  void validateForm() {
    isFormValid.value = isRoomTypeValid() &&
        isRoomNameValid() &&
        isRoomDescriptionValid() &&
        isRoomPriceValid() &&
        isTotalGuestValid();
  }

  @override
  void dispose() {
    roomCodeController.dispose();
    roomTypeController.dispose();
    roomNameController.dispose();
    roomDescriptionController.dispose();
    roomPriceController.dispose();
    totalGuestController.dispose();
    super.dispose();
  }

  void saveRoom(BuildContext context) async {
    final room = Room(
        roomCode: roomCodeController.text.trim(),
        roomType: roomTypeController.text.trim(),
        roomName: roomNameController.text.trim(),
        roomDescription: roomDescriptionController.text.trim(),
        roomPrice: double.tryParse(roomPriceController.text) ?? 0.0,
        total_guest: int.tryParse(totalGuestController.text) ?? 0,
        booked: false,
        photoFile: photoFile,
        ac: ac.value,
        tv: tv.value,
        miniBar: miniBar.value,
        jacuzzi: jacuzzi.value,
        balcony: balcony.value,
        kitchen: kitchen.value);
    isLoading.value = true;
    final request = await _roomService.createRoom(room);
    if (request == null) {
      isLoading.value = false;
      resetForm();
      Navigator.of(context).pop();
      Get.snackbar("Success", "Add new room successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      await _roomController.loadRooms();
      await _dashboardController.loadRooms();
    } else {
      isLoading.value = false;
      Get.snackbar("Error", ' ${request}',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void resetForm() {
    roomCodeController.clear();
    roomTypeController.clear();
    roomNameController.clear();
    roomDescriptionController.clear();
    roomPriceController.clear();
    totalGuestController.clear();

    photoFile = null;

    ac.value = false;
    tv.value = false;
    miniBar.value = false;
    jacuzzi.value = false;
    balcony.value = false;
    kitchen.value = false;

    update();
  }
}
