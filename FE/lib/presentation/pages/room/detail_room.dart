import 'package:flutter/material.dart';
import 'package:fe/presentation/pages/room/room_controller.dart';

class DetailRoomScreen extends StatelessWidget {
  const DetailRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
                              decoration: BoxDecoration(
                                borderRadius: isTablet
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      )
                                    : null,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Heart Icon - Responsive sizing
                            Positioned(
                              bottom: isTablet ? 24 : 16,
                              right: isTablet ? 24 : 16,
                              child: Container(
                                width: isTablet ? 48 : 40,
                                height: isTablet ? 48 : 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(isTablet ? 24 : 20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: isTablet ? 28 : 24,
                                ),
                              ),
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
                                          'Coeurdes Alpes',
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
                                            'Show map',
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
                                            'Coeurdes Alpes',
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
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Show map',
                                            style: TextStyle(
                                              fontSize: isTablet ? 18 : 16,
                                              color: const Color(0xFF1a237e),
                                              fontWeight: FontWeight.w500,
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
                                    Icons.star,
                                    color: Colors.amber,
                                    size: isTablet ? 24 : 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.5 (355 Reviews)',
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
                                'Aspen is as close as one can get to a storybook alpine town in America. The choose-your-own-adventure possibilities—skiing, hiking, dining, shopping and ....',
                                style: TextStyle(
                                  fontSize: isTablet
                                      ? 18
                                      : (screenWidth < 350 ? 14 : 16),
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),

                              SizedBox(height: isTablet ? 12 : 8),

                              // Read More - Responsive
                              TextButton(
                                onPressed: () {},
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
                                      'Read more',
                                      style: TextStyle(
                                        fontSize: isTablet ? 18 : 16,
                                        color: const Color(0xFF1a237e),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.keyboard_arrow_down,
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
                              _buildResponsiveFacilities(
                                  context, isTablet, screenWidth),

                              SizedBox(height: isTablet ? 48 : 37),
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
                              'Price: ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Text(
                              '\$199',
                              style: TextStyle(
                                fontSize: 28,
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
                            onPressed: () {},
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
                              'Price',
                              style: TextStyle(
                                fontSize: isTablet ? 16 : 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$199',
                              style: TextStyle(
                                fontSize: isTablet
                                    ? 36
                                    : (screenWidth < 350 ? 28 : 32),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: isTablet ? 32 : 24),
                            child: ElevatedButton(
                              onPressed: () {},
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
      BuildContext context, bool isTablet, double screenWidth) {
    final facilities = [
      {'icon': Icons.thermostat, 'label': '1 Heater'},
      {'icon': Icons.restaurant, 'label': 'Dinner'},
      {'icon': Icons.bathtub, 'label': '1 Tub'},
      {'icon': Icons.pool, 'label': 'Pool'},
    ];

    // For very small screens, use 2x2 grid
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

    // Default row layout for larger screens
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
