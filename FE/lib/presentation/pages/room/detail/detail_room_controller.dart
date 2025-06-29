import 'package:fe/data/models/room.dart';
import 'package:get/get.dart';

class DetailRoomController extends GetxController {
  late Room room;

  @override
  void onInit() {
    super.onInit();
    room = Get.arguments as Room;
  }
}
