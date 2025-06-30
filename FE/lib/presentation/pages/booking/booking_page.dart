import 'package:fe/presentation/pages/booking/booking_controller.dart';
import 'package:fe/core/route/app_routes.dart';
import 'package:fe/presentation/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fe/data/models/booking.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final BookingController _bookingController = Get.put(BookingController());
  final HomeController _homeController = Get.put(HomeController());

  final Color primaryColor = const Color(0xFF1a237e);
  final Color whiteColor = Colors.white;

  String _selectedTab = 'Currently Booked';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF1a237e),
        elevation: 0,
        title: const Text(
          'History Booking',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTab(
                    'Currently Booked', _selectedTab == 'Currently Booked'),
                _buildTab('Cancelled', _selectedTab == 'Cancelled'),
                _buildTab('Completed', _selectedTab == 'Completed'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Booking List
          Expanded(
            child: Obx(() {
              if (_bookingController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (_bookingController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Please Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          _bookingController.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _bookingController.refreshBookings(),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              if (_bookingController.bookings.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: Color(0xFF1a237e),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Booking History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You haven\'t made any bookings yet',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _bookingController.refreshBookings(),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              // Filter bookings berdasarkan tab yang dipilih
              final filteredBookings = _getFilteredBookings();

              // if (filteredBookings.isEmpty) {
              //   return Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(
              //           Icons.history,
              //           size: 64,
              //           color: Colors.grey[400],
              //         ),
              //         const SizedBox(height: 16),
              //         Text(
              //           'No $_selectedTab',
              //           style: TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.grey[600],
              //           ),
              //         ),
              //         const SizedBox(height: 8),
              //         Text(
              //           _getEmptyStateMessage(),
              //           style: TextStyle(color: Colors.grey[500]),
              //         ),
              //       ],
              //     ),
              //   );
              // }

              return RefreshIndicator(
                onRefresh: () => _bookingController.refreshBookings(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredBookings.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _buildBookingCard(filteredBookings[index]),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? primaryColor : Colors.grey[600],
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with room name and booking status
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    booking.room?.roomType ?? 'Unknown Room',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  booking.bookingConfirmationCode ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 8),
                // Three dots menu button

                if (booking.status_cancel == false)
                  if (_homeController.isLoggedIn.value &&
                      _homeController.isAdmin.value &&
                      booking.status_done == false)
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'checkout',
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 16,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Check Out',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == 'checkout') {
                          _showCheckoutDialog(context, booking);
                        }
                      },
                    ),
              ],
            ),
          ),
          // Hotel info and pricing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room image placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: booking.room != null
                        ? _buildRoomImage(booking)
                        : _buildPlaceholderImage(),
                  ),
                ),
                const SizedBox(width: 12),

                // Room details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.room?.roomName ?? 'Room Name',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${booking.room?.total_guest ?? 0} guest',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Pricing
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      _formatCurrency(booking.total_price ?? 0),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Total summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_formatCurrency(booking.room?.roomPrice ?? 0)} / Night',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Action button
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Ganti bagian button cancel ini:
                // ALTERNATIF: Jika ingin ada spacing tetap, gunakan SizedBox kosong
                _canCancelBooking(booking)
                    ? SizedBox(
                        width: 160,
                        child: OutlinedButton(
                          onPressed: booking.status_cancel ?? false
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          const Text('Confirm Cancel Booking'),
                                      content: const Text(
                                          'Are you sure you want to cancel this booking?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('No'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            if (booking.id != null) {
                                              _bookingController
                                                  .cancelBooking(booking.id!);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          child: const Text('Yes, Cancel',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            booking.status_cancel ?? false
                                ? 'Cancelled'
                                : 'Cancel',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(width: 160),
                const SizedBox(width: 10),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.SUCCESS_BOOKING, arguments: {
                        'booking': booking.jsonSuccessBooking(),
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Lihat Detail',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomImage(Booking booking) {
    // print('=== BOOKING DEBUG ===');
    final photo = booking.room?.photo;
    // print('PHOTO BASE64: $photo');
    // print('Photo length: ${photo?.length}');
    // print('Photo is empty: ${photo?.isEmpty}');

    if (photo != null && photo.isNotEmpty) {
      print('Booking: Photo found, trying to decode');
      try {
        return Image.memory(
          base64Decode(photo),
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Booking: Error decoding - $error');
            return _buildPlaceholderImage();
          },
        );
      } catch (e) {
        print('Booking: Exception - $e');
        return _buildPlaceholderImage();
      }
    }

    print('Booking: No photo, showing placeholder');
    return _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.hotel,
        color: Colors.grey,
        size: 30,
      ),
    );
  }

  String _formatCurrency(num amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  bool _canCancelBooking(Booking booking) {
    if (booking.checkInDate == null) return false;

    final now = DateTime.now();
    final checkinDate = DateTime.parse(booking.checkInDate!);

    // Hanya bisa cancel jika tanggal sekarang masih sebelum check-in
    return now.isBefore(checkinDate);
  }

  void _showCheckoutDialog(BuildContext context, dynamic booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.logout,
                color: primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Check Out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to check out from this booking?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking: ${booking.bookingConfirmationCode ?? ''}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Room: ${booking.room?.roomName ?? ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _bookingController.checkOutBooking(booking.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Check Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Booking> _getFilteredBookings() {
    final allBookings = _bookingController.bookings;

    switch (_selectedTab) {
      case 'Currently Booked':
        return allBookings.where((booking) {
          return booking.status_cancel == false && booking.status_done == false;
        }).toList();
      case 'Cancelled':
        return allBookings.where((booking) {
          return booking.status_cancel == true;
        }).toList();
      case 'Completed':
        return allBookings.where((booking) {
          return booking.status_done == true;
        }).toList();
      default:
        return allBookings;
    }
  }
}
