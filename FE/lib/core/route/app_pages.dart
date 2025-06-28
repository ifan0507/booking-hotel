import 'package:fe/presentation/pages/home/home_page.dart';
import 'package:fe/presentation/pages/register/register_page.dart';
import 'package:fe/presentation/pages/room/room_page.dart';
import 'package:fe/presentation/pages/room/detail/detail_room.dart';
import 'package:get/get.dart';
import '../../presentation/pages/login/login_page.dart';
import '../../presentation/pages/started/get_started.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: '/started',
        page: () => GetStartedScreen(),
        transition: Transition.leftToRight),
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
        transition: Transition.leftToRight),
    GetPage(
        name: '/rooms',
        page: () => RoomPage(),
        transition: Transition.leftToRight),
    GetPage(
      name: '/detail-rooms',
      page: () => DetailRoomScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}
