import 'dart:io';

import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/room_service.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:fe/presentation/pages/room/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRoomControlller extends GetxController {
  final RoomService _roomService = RoomService();
  final RoomController _roomController = Get.put(RoomController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  late TextEditingController roomCodeController;
  late TextEditingController roomTypeController;
  late TextEditingController roomNameController;
  late TextEditingController roomDescriptionController;
  late TextEditingController roomPriceController;
  late TextEditingController totalGuestController;

  final isFullScreen = false.obs;
  final isLoading = false.obs;
  int? roomId;

  final ac = false.obs;
  final tv = false.obs;
  final miniBar = false.obs;
  final jacuzzi = false.obs;
  final balcony = false.obs;
  final kitchen = false.obs;
  File? photoFile;

  void initControllers(Room room) {
    roomCodeController = TextEditingController(text: room.roomCode);
    roomTypeController = TextEditingController(text: room.roomType);
    roomNameController = TextEditingController(text: room.roomName);
    roomDescriptionController =
        TextEditingController(text: room.roomDescription);
    roomPriceController =
        TextEditingController(text: room.roomPrice.toString());
    totalGuestController =
        TextEditingController(text: room.total_guest.toString());
    photoFile = room.photoFile;
    roomId = room.id;
    ac.value = room.ac ?? false;
    tv.value = room.tv ?? false;
    miniBar.value = room.miniBar ?? false;
    jacuzzi.value = room.jacuzzi ?? false;
    balcony.value = room.balcony ?? false;
    kitchen.value = room.kitchen ?? false;
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

  void saveRoom(BuildContext context) async {
    final room = Room(
        id: roomId,
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
    final request = await _roomService.updateRoom(room);
    if (request == null) {
      isLoading.value = false;
      resetForm();
      Navigator.of(context).pop();
      Get.snackbar("Success", "Update room successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      await _roomController.loadRooms();
      await _dashboardController.loadRooms();
    } else {
      isLoading.value = false;
      Get.snackbar("Error", ' ${request}',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
