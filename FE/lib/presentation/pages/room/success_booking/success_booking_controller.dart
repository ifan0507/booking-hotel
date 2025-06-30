import 'package:get/get.dart';

class SuccessBookingController extends GetxController {
  late final Map<String, dynamic> bookingData;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('booking')) {
      bookingData = args['booking'];
    } else if (args is Map<String, dynamic>) {
      bookingData = args;
    } else {
      bookingData = {};
    }
    print("BOOOOOOOOOOOOOOOOOOOOOOOO $bookingData");
  }

  Map<String, dynamic> get room => bookingData['room'] ?? {};
}
