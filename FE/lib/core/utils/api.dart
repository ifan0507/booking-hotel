import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Api {
<<<<<<< HEAD
  String baseUrl = "http://192.168.201.26:8080";
=======
  String baseUrl = "http://192.168.1.2:8080";
>>>>>>> 79addd6392e7a3c49406e7443248cf7be8e235d1

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
