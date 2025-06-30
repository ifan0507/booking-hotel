import 'dart:convert';
import 'package:fe/core/route/app_routes.dart';
import 'package:fe/core/utils/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
        print("[DEBUG] Token login: $token");

        final box = GetStorage();
        box.write('token', token);

        String firstName = data['firstName'] ?? '';
        String lastName = data['lastName'] ?? '';
        String fullName = '$firstName $lastName'.trim();

        box.write('user_name', fullName);
        box.write('user_email', data['email'] ?? '');
        box.write('user_id', data['id'].toString());

        if (data['roles'] != null) {
          List<String> roles = List<String>.from(data['roles']);
          box.write('user_roles', roles);
        }

        return null; // login sukses
      } else {
        return jsonDecode(response.body)['message'] ?? 'Login Gagal';
      }
    } catch (e) {
      print("[ERROR] Terjadi kesalahan saat login: $e");
      return "Gagal terhubung ke server";
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final box = GetStorage();
      final token = box.read("token");

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
      final box = GetStorage();
      final userName = box.read("user_name");
      return userName ?? 'User';
    } catch (e) {
      return 'User';
    }
  }

  Future<String> getEmail() async {
    try {
      final box = GetStorage();
      final userEmail = box.read("user_email");
      return userEmail ?? '';
    } catch (e) {
      return '';
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

  // Future<List<String>> getUserRoles() async {
  //   try {
  //     final box = GetStorage();
  //     final roles = box.read("user_roles");
  //     return roles ?? [];
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<List<String>> getUserRoles() async {
    try {
      final box = GetStorage();
      final roles = box.read("user_roles");
      if (roles is List) {
        return List<String>.from(roles);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> isAdmin() async {
    try {
      final roles = await getUserRoles();
      print("Debug Roles: ${roles.toString()}");
      print("Debug Roles Type: ${roles.runtimeType}");
      return roles.contains('ROLE_ADMIN') || roles.contains('admin');
    } catch (e) {
      print("Error in isAdmin: $e");
      return false;
    }
  }

  Future<bool> isUser() async {
    try {
      bool loggedIn = await isLoggedIn();
      if (loggedIn) {
        final roles = await getUserRoles();
        return roles.contains('ROLE_USER');
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final box = GetStorage();
    box.erase();
    Get.offAllNamed(Routes.STARTED);
  }
}
