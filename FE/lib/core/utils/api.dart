import 'package:get_storage/get_storage.dart';

class Api {
  String baseUrl = "http://192.168.1.3:8080";

  Map<String, String> getToken() {
    final box = GetStorage();
    String? token = box.read("token");
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
      };
    }
    return {
      "Authorization": "Bearer " "BadToken",
    };
  }
}
