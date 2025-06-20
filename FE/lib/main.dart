import 'package:fe/core/route/app_routes.dart';
import 'package:fe/core/route/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    GetStorage.init(),
  ]);

  final box = GetStorage();
  final token = box.read("token");

  runApp(MyApp(initialRoute: token == null ? Routes.STARTED : Routes.HOME));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
    );
  }
}
