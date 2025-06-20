import 'package:fe/core/route/app_routes.dart';
import 'package:fe/data/models/user.dart';
import 'package:fe/data/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RegisterService _registerService = RegisterService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isFirstNameValid() => firstNameController.text.trim().isNotEmpty;
  bool isLastNameValid() => lastNameController.text.trim().isNotEmpty;
  bool isEmailValid() => emailController.text.trim().contains('@');
  bool isPasswordValid() => passwordController.text.length >= 6;

  String get lastName => lastNameController.text.trim();
  String get firstName => firstNameController.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text;

  var isFormValid = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    firstNameController.addListener(validateForm);
    lastNameController.addListener(validateForm);
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
    super.onInit();
  }

  void clearAll() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void validateForm() {
    isFormValid.value = isFirstNameValid() &&
        isLastNameValid() &&
        isEmailValid() &&
        isPasswordValid();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void register() async {
    final user = User(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    isLoading.value = true;
    final success = await _registerService.register(user);
    if (success == null) {
      isLoading.value = false;
      Get.snackbar("Success", "Register successfully");
      Get.offAllNamed(Routes.LOGIN);
    } else {
      isLoading.value = false;
      Get.snackbar("Error", ' ${success}',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
