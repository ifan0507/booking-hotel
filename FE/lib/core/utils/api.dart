import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Api {
  String baseUrl = "http://192.168.1.2:8080";

  Map<String, String> getToken() {
    final box = GetStorage();
    String? token = box.read("token");

    if (token != null && !JwtDecoder.isExpired(token)) {
      return {
        "Authorization": "Bearer $token",
      };
    }

    return {
      "Authorization": "Bearer BadToken",
    };
  }
}
