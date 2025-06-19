import 'package:fe/presentation/pages/home/home_page.dart';
import 'package:fe/presentation/pages/register/register_page.dart';
import 'package:fe/presentation/pages/room/room_page.dart';
import 'package:get/get.dart';
import '../../presentation/pages/login/login_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/rooms',
      page: () => RoomPage(),
    ),
  ];
}
