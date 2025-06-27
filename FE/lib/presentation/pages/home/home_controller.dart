import 'package:fe/data/services/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LoginService _loginService = LoginService();

  final isLoggedIn = false.obs;
  final isAdmin = false.obs;
  final isUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserStatus();
  }

  void loadUserStatus() async {
    isLoggedIn.value = await _loginService.isLoggedIn();
    isAdmin.value = await _loginService.isAdmin();
    isUser.value = await _loginService.isUser();
  }

  Future<bool> checkLoginStatus() async {
    return isLoggedIn.value = await _loginService.isLoggedIn();
  }

  Future<bool> admin() async {
    return isAdmin.value = await _loginService.isAdmin();
  }

  Future<bool> user() async {
    return isUser.value = await _loginService.isUser();
  }
}
