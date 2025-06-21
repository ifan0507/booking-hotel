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

        String firstName = data['firstName'] ?? '';
        String lastName = data['lastName'] ?? '';
        String fullName = '$firstName $lastName'.trim();

        await prefs.setString('user_name', fullName);
        await prefs.setString('user_email', data['email'] ?? '');
        await prefs.setString('user_id', data['id'].toString());

        if (data['roles'] != null) {
          List<String> roles = List<String>.from(data['roles']);
          await prefs.setStringList('user_roles', roles);
        }

        return null;
      } else {
        return jsonDecode(response.body)['message'] ?? 'Login Gagal';
      }
    } catch (e) {
      print("erorr yang ditangkap ${e}");
      return "gagal terhubung keserver";
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> getUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userName = prefs.getString('user_name');
      return userName ?? 'User';
    } catch (e) {
      return 'User';
    }
  }

  Future<String> getUserDisplayText() async {
    try {
      bool loggedIn = await isLoggedIn();
      if (loggedIn) {
        String userName = await getUserName();
        return "Halo $userName";
      } else {
        return "Halo Guest";
      }
    } catch (e) {
      return "Halo Guest";
    }
  }

  Future<List<String>> getUserRoles() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roles = prefs.getStringList('user_roles');
      return roles ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> isAdmin() async {
    try {
      final roles = await getUserRoles();
      return roles.contains('ROLE_ADMIN');
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(Routes.LOGIN);
  }
}
