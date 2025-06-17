import 'dart:convert';

import 'package:fe/core/utils/api.dart';
import 'package:fe/data/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterService {
  final _storage = const FlutterSecureStorage();
  Future<String?> register(User user) async {
    final url = Uri.parse('${Api.baseUrl}/auth/register-user');

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(user.toJson()));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _storage.write(key: 'token', value: token);
        return null;
      } else {
        return jsonDecode(response.body)['message'] ?? 'Login gagal';
      }
    } catch (e) {
      return 'gagal terhubung keserver';
    }
  }
}
