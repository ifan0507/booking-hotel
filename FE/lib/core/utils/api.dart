import 'package:get_storage/get_storage.dart';

class Api {
  String baseUrl = "http://192.168.177.244:8080";

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
