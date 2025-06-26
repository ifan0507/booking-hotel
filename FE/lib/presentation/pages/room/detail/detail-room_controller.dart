import 'package:fe/data/services/room_service.dart';
import 'package:fe/data/models/room.dart';
import 'package:get/get.dart';

class DetailRoomController extends GetxController {
  final RoomService _roomService = RoomService();

  var rooms = <Room>[].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadRooms();
  }

  Future<void> loadRooms() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<Room> roomList = await _roomService.getAllRoom();
      rooms.value = roomList;
    } catch (e) {
      errorMessage.value = 'Failed to load rooms: $e';
      print('Error loading rooms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshRooms() async {
    await loadRooms();
  }
}
