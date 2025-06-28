import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  final Color primaryColor = const Color(0xFF1a237e);
  final Color whiteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: const Text(
          'History Booking',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Booking List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildBookingCard(
                  hotelName: 'Grand Hyatt Jakarta',
                  roomType: 'Deluxe King Room',
                  status: 'Selesai',
                  originalPrice: 'Rp2.500.000',
                  finalPrice: 'Rp2.000.000',
                  totalPrice: 'Rp2.200.000',
                  nights: 2,
                  imageUrl:
                      'https://via.placeholder.com/80x80/4285F4/FFFFFF?text=Hotel',
                  earnedPoints: 50,
                ),
                const SizedBox(height: 12),
                _buildBookingCard(
                  hotelName: 'Hotel Santika Premiere',
                  roomType: 'Superior Twin Bed',
                  status: 'Selesai',
                  originalPrice: 'Rp1.200.000',
                  finalPrice: 'Rp890.000',
                  totalPrice: 'Rp980.000',
                  nights: 1,
                  imageUrl:
                      'https://via.placeholder.com/80x80/34A853/FFFFFF?text=Hotel',
                  earnedPoints: 25,
                ),
                const SizedBox(height: 12),
                _buildBookingCard(
                  hotelName: 'Mercure Jakarta Sabang',
                  roomType: 'Standard Double Room',
                  status: 'Selesai',
                  originalPrice: 'Rp800.000',
                  finalPrice: 'Rp650.000',
                  totalPrice: 'Rp715.000',
                  nights: 1,
                  imageUrl:
                      'https://via.placeholder.com/80x80/EA4335/FFFFFF?text=Hotel',
                  earnedPoints: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard({
    required String hotelName,
    required String roomType,
    required String status,
    required String originalPrice,
    required String finalPrice,
    required String totalPrice,
    required int nights,
    required String imageUrl,
    required int earnedPoints,
  }) {
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
          // Header with hotel badge and status
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
                  child: const Text(
                    'Type',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  hotelName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // Hotel info and pricing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel image placeholder
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.hotel,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),

                // Hotel details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roomType,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$nights malam',
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
                      finalPrice,
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

          // Total and points
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total 1 kamar: $totalPrice',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Detail',
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
}
