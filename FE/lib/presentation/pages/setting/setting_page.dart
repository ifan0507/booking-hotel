import 'package:fe/data/services/login_service.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  // const SettingPage({super.key});
  final LoginService _loginController = LoginService();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            _loginController.logout();
          },
          child: Text("Logout")),
    );
  }
}
