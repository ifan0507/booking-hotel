import 'package:fe/data/services/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LoginService _loginService = LoginService();

  var isLoggedIn = false.obs;
  var isAdmin = false.obs;
  var isUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserStatus();
  }

  void loadUserStatus() async {
    bool logged = await _loginService.isLoggedIn();
    isLoggedIn.value = logged;

    if (logged) {
      bool adminStatus = await _loginService.isAdmin();
      bool userStatus = await _loginService.isUser();

      print("Admin Status: $adminStatus");
      print("User Status: $userStatus");

      isAdmin.value = adminStatus;
      isUser.value = userStatus;
    } else {
      isAdmin.value = false;
      isUser.value = false;
    }
  }
}
