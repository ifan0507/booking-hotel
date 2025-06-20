import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/room_service.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
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

      for (Room room in roomList) {
        print('Room ID: ${room.id}');
        print('Room Type: ${room.roomType}');
        print('Room Price: ${room.roomPrice}');
        print('Is Booked: ${room.isBoked}');
        print('Has Photo: ${room.photo?.isNotEmpty ?? false}');
      }
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
