import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Api {
<<<<<<< HEAD
  String baseUrl = "http://192.168.1.7:8080";
=======
  String baseUrl = "http://192.168.1.2:8080";
>>>>>>> ab055d166d94330cd2db274c1b487bf1f76c0245

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
