import 'package:fe/core/route/app_routes.dart';
import 'package:fe/presentation/pages/home/home_controller.dart';
import 'package:fe/presentation/pages/room/booking/booking_room_controller.dart';
import 'package:fe/presentation/pages/room/detail/detail_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:fe/data/models/room.dart';
import 'package:fe/presentation/pages/room/booking/booking_room.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class DetailRoomScreen extends StatefulWidget {
  const DetailRoomScreen({Key? key}) : super(key: key);

  @override
  State<DetailRoomScreen> createState() => _DetailRoomState();
}

class _DetailRoomState extends State<DetailRoomScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final DetailRoomController _detailRoomController =
      Get.put(DetailRoomController());
  final BookingRoomController _bookingRoomController =
      Get.put(BookingRoomController());

  void _showBookingModal(Room room) {
    _bookingRoomController.fullNameController.text =
        _bookingRoomController.userName.value;
    _bookingRoomController.emailController.text =
        _bookingRoomController.userEmail.value;
    final controller = Get.put(BookingRoomController());
    controller.initControllers(room);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookingModal(),
    );
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final description = _detailRoomController.room.roomDescription ?? '';
    final wordCount = description.trim().split(RegExp(r'\s+')).length;

    // Tampilkan deskripsi sebagian jika belum expanded
    final shortDescription = _isExpanded || wordCount <= 20
        ? description
        : description.trim().split(' ').take(20).join(' ') + '...';

    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final priceFormatted =
        formatCurrency.format(_detailRoomController.room.roomPrice ?? 0);

    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE3F2FD),
                  Color(0xFFF5F5F5),
                ],
              ),
            ),
            child: SingleChildScrollView(
              // Add bottom padding to prevent content being hidden behind fixed bottom
              padding: EdgeInsets.only(
                bottom: 80 + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                children: [
                  // Main Card Container - Responsive
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 800 : double.infinity,
                    ),
                    margin: isTablet
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(isTablet ? 16 : 0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Image with Heart Icon - Responsive Height
                        Stack(
                          children: [
                            Container(
                              height: isLandscape
                                  ? screenHeight * 0.5
                                  : (isTablet ? 400 : screenHeight * 0.4),
                              width: double.infinity,
                              child: _detailRoomController.room.photo != null &&
                                      _detailRoomController
                                          .room.photo!.isNotEmpty
                                  ? Image.memory(
                                      base64Decode(
                                          _detailRoomController.room.photo!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Center(
                                              child:
                                                  Text('Gagal memuat gambar')),
                                    )
                                  : Center(child: Text("Tidak ada foto")),
                            ),
                          ],
                        ),

                        // Content Padding - Responsive
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            isTablet ? 32.0 : 20.0,
                            isTablet ? 32.0 : 20.0,
                            isTablet ? 32.0 : 20.0,
                            0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Show Map - Responsive layout
                              isLandscape && !isTablet
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _detailRoomController.room.roomName ??
                                              'Detail Kamar',
                                          style: TextStyle(
                                            fontSize: isTablet ? 32 : 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            _detailRoomController
                                                    .room.roomType ??
                                                '',
                                            style: TextStyle(
                                              fontSize: isTablet ? 18 : 16,
                                              color: const Color(0xFF1a237e),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _detailRoomController
                                                    .room.roomName ??
                                                'Detail Kamar',
                                            style: TextStyle(
                                              fontSize: isTablet
                                                  ? 32
                                                  : (screenWidth < 350
                                                      ? 24
                                                      : 28),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                              SizedBox(height: isTablet ? 12 : 8),

                              // Rating - Responsive
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Colors.grey,
                                    size: isTablet ? 24 : 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _detailRoomController.room.total_guest
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: isTablet ? 18 : 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: isTablet ? 20 : 16),

                              // Description - Responsive
                              Text(
                                shortDescription,
                                style: TextStyle(
                                  fontSize: isTablet
                                      ? 18
                                      : (screenWidth < 350 ? 14 : 16),
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: isTablet ? 12 : 8),
                              if (wordCount > 100)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isExpanded = !_isExpanded;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _isExpanded ? 'Show less' : 'Read more',
                                        style: TextStyle(
                                          fontSize: isTablet ? 18 : 16,
                                          color: const Color(0xFF1a237e),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Icon(
                                        _isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: const Color(0xFF1a237e),
                                        size: isTablet ? 24 : 20,
                                      ),
                                    ],
                                  ),
                                ),

                              SizedBox(height: isTablet ? 32 : 24),

                              // Facilities Section - Responsive
                              Text(
                                'Facilities',
                                style: TextStyle(
                                  fontSize: isTablet ? 24 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),

                              SizedBox(height: isTablet ? 20 : 16),

                              // Facilities Icons - Responsive Grid
                              _buildResponsiveFacilities(context, isTablet,
                                  screenWidth, _detailRoomController.room),

                              SizedBox(height: isTablet ? 48 : 60),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + (isTablet ? 24 : 16),
            left: isTablet ? 24 : 16,
            child: Material(
              color: Colors.transparent,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: isTablet ? 48 : 40,
                  height: isTablet ? 48 : 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black87,
                    size: isTablet ? 24 : 20,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + (isTablet ? 24 : 20),
            right: isTablet ? 24 : 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF1a237e),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _detailRoomController.room.roomType ?? 'Uknown Type',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Fixed Bottom Section for Price and Book Now
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ), // Hanya border radius di atas
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                isTablet ? 32.0 : 20.0,
                isTablet ? 20.0 : 16.0,
                isTablet ? 32.0 : 20.0,
                MediaQuery.of(context).padding.bottom + (isTablet ? 20 : 16),
              ),
              child: isLandscape && screenWidth < 600
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Price section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Price per night',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              priceFormatted,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Book button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _homeController.isLoggedIn.value
                                  ? _showBookingModal(
                                      _detailRoomController.room)
                                  : Get.offAllNamed(Routes.LOGIN);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1a237e),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Book Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Price per night',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 16 : 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              priceFormatted,
                              style: TextStyle(
                                fontSize: isTablet
                                    ? 36
                                    : (screenWidth < 350 ? 28 : 24),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1a237e),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: isTablet ? 32 : 24),
                            child: ElevatedButton(
                              onPressed: () {
                                _homeController.isLoggedIn.value
                                    ? _showBookingModal(
                                        _detailRoomController.room)
                                    : Get.offAllNamed(Routes.LOGIN);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1a237e),
                                foregroundColor: Colors.white,
                                minimumSize:
                                    Size(double.infinity, isTablet ? 60 : 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Book Now',
                                    style: TextStyle(
                                      fontSize: isTablet ? 20 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: isTablet ? 24 : 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveFacilities(
      BuildContext context, bool isTablet, double screenWidth, Room room) {
    // Map boolean properti ke fasilitas
    final List<Map<String, dynamic>> facilities = [];

    if (room.ac == true) {
      facilities.add({'icon': Icons.ac_unit, 'label': 'AC'});
    }
    if (room.tv == true) {
      facilities.add({'icon': Icons.tv, 'label': 'TV'});
    }
    if (room.miniBar == true) {
      facilities.add({'icon': Icons.local_bar, 'label': 'Mini Bar'});
    }
    if (room.jacuzzi == true) {
      facilities.add({'icon': Icons.hot_tub, 'label': 'Jacuzzi'});
    }
    if (room.balcony == true) {
      facilities.add({'icon': Icons.balcony, 'label': 'Balcony'});
    }
    if (room.kitchen == true) {
      facilities.add({'icon': Icons.kitchen, 'label': 'Kitchen'});
    }

    // Jika tidak ada fasilitas, tampilkan teks
    if (facilities.isEmpty) {
      return const Text("No facilities available");
    }

    // Untuk layar kecil (grid)
    if (screenWidth < 350) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: facilities.length,
        itemBuilder: (context, index) {
          return _buildFacilityItem(
            facilities[index]['icon'] as IconData,
            facilities[index]['label'] as String,
            isTablet,
          );
        },
      );
    }

    // Untuk layar sedang hingga besar (wrap)
    return Wrap(
      spacing: isTablet ? 16 : 12,
      runSpacing: 12,
      children: facilities.map((facility) {
        return SizedBox(
          width: (screenWidth - (isTablet ? 96 : 64)) / 4,
          child: _buildFacilityItem(
            facility['icon'] as IconData,
            facility['label'] as String,
            isTablet,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFacilityItem(IconData icon, String label, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isTablet ? 28 : 24,
            color: Colors.grey[700],
          ),
          SizedBox(height: isTablet ? 8 : 4),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 14 : 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
