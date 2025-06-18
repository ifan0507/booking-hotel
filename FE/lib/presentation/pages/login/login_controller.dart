import 'package:fe/core/route/app_routes.dart';
import 'package:fe/data/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginService _loginService = LoginService();
  var isFormValid = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
    super.onInit();
  }

  void clearAll() {
    emailController.clear();
    passwordController.clear();
  }

  void validateForm() {
    isFormValid.value = isEmailValid() && isPasswordValid();
  }

  bool isEmailValid() => emailController.text.trim().contains('@');
  bool isPasswordValid() => passwordController.text.length >= 6;

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    isLoading.value = true;
    try {
      final response = await _loginService.login(email, password);

      if (response == null) {
        isLoading.value = false;
        Get.snackbar("Berhasil", "Login seccessfully");
        Get.offAllNamed(Routes.HOME);
      } else {
        isLoading.value = false;
        Get.snackbar("Gagal", '${response}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Gagal", '${e}',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
