import 'package:fe/core/route/app_routes.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/data/services/register_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController {
  final RegisterService _registerService = RegisterService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void clearAll() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  bool isFirstNameValid() => firstNameController.text.trim().isNotEmpty;
  bool isLastNameValid() => lastNameController.text.trim().isNotEmpty;
  bool isEmailValid() => emailController.text.trim().contains('@');
  bool isPasswordValid() => passwordController.text.length >= 6;

  String get lastName => lastNameController.text.trim();
  String get firstName => firstNameController.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void register() async {
    // isLoading.value = true;

    final user = User(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: '1');

    final success = await _registerService.register(user);
    // isLoading.value = false;

    if (success == null) {
      Get.snackbar("Berhasil", "Akun berhasil dibuat");
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar("Gagal", "Pendaftaran gagal");
    }
  }
}
