import 'package:fe/data/models/room.dart';
import 'package:fe/data/services/login_service.dart';
import 'package:fe/data/services/room_service.dart';
import 'package:get/state_manager.dart';

class DashboardController extends GetxController {
  final RoomService _roomService = RoomService();
  final LoginService _loginService = LoginService();
  var rooms = <Room>[].obs;
  var userDisplayText = "Loading...".obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadRooms();
    loadUserDisplayText();
  }

  Future<void> loadUserDisplayText() async {
    try {
      final displayText = await _loginService.getUserDisplayText();
      userDisplayText.value = '$displayText 👋';
    } catch (e) {
      userDisplayText.value = 'Halo Guest 👋';
    }
  }

  // Method untuk refresh user data
  Future<void> refreshUserData() async {
    await loadUserDisplayText();
  }

  Future<void> loadRooms() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      List<Room> roomList = await _roomService.getAllRoom();
      rooms.value = roomList;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load rooms: $e';
    }
  }

  Future<void> refreshRooms() async {
    await loadRooms();
  }
}
