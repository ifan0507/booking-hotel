import 'package:fe/presentation/pages/booking/booking_page.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_page.dart';
import 'package:fe/presentation/pages/room/add/add_room.dart';
import 'package:fe/presentation/pages/room/add/add_room_controller.dart';
import 'package:fe/presentation/pages/room/room_controller.dart';
import 'package:fe/presentation/pages/room/room_page.dart';
import 'package:fe/presentation/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final RoomController _roomController = Get.put(RoomController());
  final AddRoomController _addRoomController = Get.put(AddRoomController());

  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(),
      RoomPage(),
      BookingPage(),
      SettingPage(),
    ];
  }

  void _showAddRoomModal() {
    _addRoomController.roomCodeController.text =
        _roomController.generateRoomCode();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddRoom(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _pages[_selectedIndex],
      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              if (index == 2) {
                // Index 2 is the add button
                _showAddRoomModal();
              } else {
                // Adjust index for other pages since add button is not a page
                int pageIndex = index > 2 ? index - 1 : index;
                setState(() {
                  _selectedIndex = pageIndex;
                });
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF1a237e),
            unselectedItemColor: Colors.grey[400],
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel_outlined),
                activeIcon: Icon(Icons.hotel),
                label: 'Room',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF1a237e),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                label: 'Add Room',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                activeIcon: Icon(Icons.people),
                label: 'Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
