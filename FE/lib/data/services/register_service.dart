import 'dart:convert';

import 'package:fe/core/utils/api.dart';
import 'package:fe/data/models/user.dart';
import 'package:http/http.dart' as http;

class RegisterService extends Api {
  Future<String?> register(User user) async {
    final url = Uri.parse('$baseUrl/auth/register-user');

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()));
      if (response.statusCode == 200) {
        return null;
      } else {
        return jsonDecode(response.body)['message'] ?? 'Register gagal';
      }
    } catch (e) {
      return 'gagal terhubung keserver $e';
    }
  }
}
