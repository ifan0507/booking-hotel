import 'package:fe/core/route/app_routes.dart';
import 'package:fe/presentation/pages/room/success_booking/success_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuccessBooking extends StatefulWidget {
  @override
  _SuccessBookingState createState() => _SuccessBookingState();
}

class _SuccessBookingState extends State<SuccessBooking>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuccessBookingController());
    final data = controller.bookingData;
    final room = controller.room;

    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final priceFormatted = formatCurrency.format(data['total_price'] ?? 0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // Header dengan gradient
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1a237e),
                        Color(0xFF283593),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Top bar
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       'ASTON HOTEL',
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //         letterSpacing: 1.2,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        SizedBox(height: 24),

                        // Ikon sukses dan judul
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 30,
                                      offset: Offset(0, 15),
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.8),
                                      blurRadius: 10,
                                      offset: Offset(0, -5),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white,
                                        Colors.grey.shade50,
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Color(0xFF1a237e),
                                    size: 50,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),

                              // Modern title
                              Text(
                                'Booking Confirmed!',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                'Hotel Reservation',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.8),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'SUCCESSFULLY',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content area
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // // Detail transaksi
                        // Container(
                        //   width: double.infinity,
                        //   padding: EdgeInsets.all(20),
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey[50],
                        //     borderRadius: BorderRadius.circular(16),
                        //     border: Border.all(
                        //       color: Color(0xFF1a237e).withOpacity(0.1),
                        //       width: 1,
                        //     ),
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       _buildDetailRow(
                        //           'Confirmation Code', 'AST2024HTL001234'),
                        //       _buildDivider(),
                        //       _buildDetailRow(
                        //           'Tanggal Booking', '27 Jun 2025 14:30:25'),
                        //       _buildDivider(),
                        //       _buildDetailRow(
                        //           'Nomor Ref', '20250627143025887423'),
                        //       _buildDivider(),
                        //       _buildDetailRow('Terminal', 'XXXXXXXXX9876'),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(height: 20),

                        // Detail booking hotel
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xFF1a237e).withOpacity(0.03),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xFF1a237e).withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BOOKING: HOTEL RESERVATION',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1a237e),
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildDetailRow('Confirmation Code',
                                  '${data['bookingConfirmationCode']}'),
                              _buildDivider(),
                              _buildDetailRow('Full Name Guest',
                                  '${data['guestFullName']}'),
                              _buildDivider(),
                              _buildDetailRow('Phone Number Guest',
                                  '${data['phone_number']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Room Name', '${room['roomName']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Room Type', '${room['roomType']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Total Guest', '${room['total_guest']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Check In', '${data['checkInDate']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Check Out', '${data['checkOutDate']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Booking Date', '${data['bookingDate']}'),
                              _buildDivider(),
                              _buildDetailRow(
                                  'Hotel Name', 'ASTON HOTEL LUMAJANG'),
                              SizedBox(height: 16),
                              SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1a237e).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'TOTAL PAID: $priceFormatted',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1a237e),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Footer message
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Thank you for using ASTON HOTEL.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Please show this confirmation upon check-in.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Tombol aksi
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          icon: Icon(Icons.home_rounded, size: 20),
                          label: Text(
                            'Back to Home',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF1a237e),
                            side: BorderSide(
                              color: Color(0xFF1a237e),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label + ':',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1a237e),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: Colors.grey[300],
        thickness: 0.5,
        height: 1,
      ),
    );
  }
}
