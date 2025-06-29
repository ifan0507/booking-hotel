import 'package:fe/presentation/pages/booking/booking_page.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:fe/presentation/pages/dashboard/dashboard_page.dart';
import 'package:fe/presentation/pages/home/home_controller.dart';
import 'package:fe/presentation/pages/room/add/add_room.dart';
import 'package:fe/presentation/pages/room/add/add_room_controller.dart';
import 'package:fe/presentation/pages/room/room_controller.dart';
import 'package:fe/presentation/pages/room/room_page.dart';
import 'package:fe/presentation/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final RoomController _roomController = Get.put(RoomController());
  final AddRoomController _addRoomController = Get.put(AddRoomController());
  final HomeController _homeController = Get.put(HomeController());

  int _selectedPageIndex = 0;
  int _navBarIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPage(),
      RoomPage(),
      BookingPage(),
      ProfilePage(),
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
      body: _pages[_selectedPageIndex],

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
          child: Obx(() {
            List<BottomNavigationBarItem> navItems = [
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
            ];

            if (_homeController.isLoggedIn.value &&
                _homeController.isAdmin.value) {
              navItems.add(
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
              );
            }

            navItems.addAll([
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                activeIcon: Icon(Icons.people),
                label: 'Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ]);

            return BottomNavigationBar(
              currentIndex: _navBarIndex,
              onTap: (index) {
                int addRoomIndex = (_homeController.isLoggedIn.value &&
                        _homeController.isAdmin.value)
                    ? 2
                    : -1;

                if (index == addRoomIndex) {
                  _showAddRoomModal();
                } else {
                  int pageIndex = index;
                  if (addRoomIndex != -1 && index > addRoomIndex) pageIndex--;
                  setState(() {
                    _navBarIndex = index;
                    _selectedPageIndex = pageIndex;
                  });
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFF1a237e),
              unselectedItemColor: Colors.grey[400],
              elevation: 0,
              items: navItems,
            );
          }),
        ),
      ),
    );
  }
}
