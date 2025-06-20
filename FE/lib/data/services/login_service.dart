import 'dart:convert';
import 'package:fe/core/route/app_routes.dart';
import 'package:fe/core/utils/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends Api {
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return null;
      } else {
        return jsonDecode(response.body)['message'] ?? 'Login Gagal';
      }
    } catch (e) {
      return "gagal terhubung keserver";
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }
}
