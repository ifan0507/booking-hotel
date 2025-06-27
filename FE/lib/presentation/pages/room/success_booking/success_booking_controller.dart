import 'package:get/get.dart';

class SuccessBookingController extends GetxController {
  late final Map<String, dynamic> bookingData;

  @override
  void onInit() {
    super.onInit();
    bookingData = Get.arguments as Map<String, dynamic>;
  }

  Map<String, dynamic> get room => bookingData['room'] ?? {};
}
