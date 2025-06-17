import 'package:fe/data/services/login_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LoginService _loginService = new LoginService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          _loginService.logout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1a237e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ));
  }
}
