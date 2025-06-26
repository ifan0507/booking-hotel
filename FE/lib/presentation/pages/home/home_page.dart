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

class AddRoomModal extends StatefulWidget {
  @override
  _AddRoomModalState createState() => _AddRoomModalState();
}

class _AddRoomModalState extends State<AddRoomModal> {
  final _formKey = GlobalKey<FormState>();
  final _roomCodeController = TextEditingController();
  final _roomTypeController = TextEditingController();
  final _roomNameController = TextEditingController();
  final _roomDescriptionController = TextEditingController();
  final _roomPriceController = TextEditingController();

  bool _isFullScreen = false;
  bool _ac = false;
  bool _tv = false;
  bool _miniBar = false;
  bool _jacuzzi = false;
  bool _balcony = false;
  bool _kitchen = false;
  File? _photoFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _isFullScreen
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 0.8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_isFullScreen ? 0 : 25),
              topRight: Radius.circular(_isFullScreen ? 0 : 25),
            ),
          ),
          child: Column(
            children: [
              // Header with drag handle and expand button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_isFullScreen ? 0 : 25),
                    topRight: Radius.circular(_isFullScreen ? 0 : 25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (!_isFullScreen)
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    Spacer(),
                    Text(
                      'Tambah Kamar Baru',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1a237e),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isFullScreen = !_isFullScreen;
                            });
                          },
                          icon: Icon(
                            _isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Color(0xFF1a237e),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Form content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Photo upload section
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: _photoFile == null
                              ? InkWell(
                                  onTap: () {
                                    // Implement photo picker
                                    _pickImage();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_photo_alternate_outlined,
                                          size: 50, color: Colors.grey[400]),
                                      SizedBox(height: 10),
                                      Text('Tambah Foto Kamar',
                                          style: TextStyle(
                                              color: Colors.grey[600])),
                                    ],
                                  ),
                                )
                              : Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        _photoFile!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _photoFile = null),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.close,
                                              color: Colors.white, size: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),

                        SizedBox(height: 25),

                        // Room Code
                        _buildTextField(
                          controller: _roomCodeController,
                          label: 'Kode Kamar',
                          hint: 'Contoh: R001',
                          icon: Icons.qr_code,
                        ),

                        SizedBox(height: 20),

                        // Room Type
                        _buildTextField(
                          controller: _roomTypeController,
                          label: 'Tipe Kamar',
                          hint: 'Contoh: Deluxe, Suite, Standard',
                          icon: Icons.category,
                        ),

                        SizedBox(height: 20),

                        // Room Name
                        _buildTextField(
                          controller: _roomNameController,
                          label: 'Nama Kamar',
                          hint: 'Contoh: Kamar Deluxe Ocean View',
                          icon: Icons.hotel,
                        ),

                        SizedBox(height: 20),

                        // Room Description
                        _buildTextField(
                          controller: _roomDescriptionController,
                          label: 'Deskripsi Kamar',
                          hint: 'Deskripsi lengkap kamar...',
                          icon: Icons.description,
                          maxLines: 3,
                        ),

                        SizedBox(height: 20),

                        // Room Price
                        _buildTextField(
                          controller: _roomPriceController,
                          label: 'Harga Kamar',
                          hint: 'Contoh: 500000',
                          icon: Icons.attach_money,
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: 30),

                        // Facilities Section
                        Text(
                          'Fasilitas Kamar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a237e),
                          ),
                        ),

                        SizedBox(height: 15),

                        // Facilities switches
                        _buildFacilitySwitch('AC', Icons.ac_unit, _ac, (value) {
                          setState(() => _ac = value);
                        }),

                        _buildFacilitySwitch('TV', Icons.tv, _tv, (value) {
                          setState(() => _tv = value);
                        }),

                        _buildFacilitySwitch(
                            'Mini Bar', Icons.local_bar, _miniBar, (value) {
                          setState(() => _miniBar = value);
                        }),

                        _buildFacilitySwitch('Jacuzzi', Icons.bathtub, _jacuzzi,
                            (value) {
                          setState(() => _jacuzzi = value);
                        }),

                        _buildFacilitySwitch('Balcony', Icons.balcony, _balcony,
                            (value) {
                          setState(() => _balcony = value);
                        }),

                        _buildFacilitySwitch('Kitchen', Icons.kitchen, _kitchen,
                            (value) {
                          setState(() => _kitchen = value);
                        }),

                        SizedBox(height: 40),

                        // Save Button
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveRoom,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1a237e),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            child: Text(
                              'Simpan Kamar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final permission = await Permission.photos.request();

      if (!permission.isGranted) {
        _showPermissionDialog('Galeri');
        return;
      }

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _photoFile = File(pickedFile.path);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Foto berhasil dipilih!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak ada foto yang dipilih'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih foto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPermissionDialog(String source) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Izin Diperlukan'),
        content: Text(
            'Aplikasi memerlukan izin untuk mengakses $source. Silakan berikan izin di pengaturan aplikasi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text('Pengaturan'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1a237e),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Color(0xFF1a237e)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF1a237e), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFacilitySwitch(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF1a237e), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF1a237e),
          ),
        ],
      ),
    );
  }

  void _saveRoom() {
    if (_formKey.currentState!.validate()) {
      // Create room object with the form data
      // You can access all the data like:
      // _roomCodeController.text
      // _roomTypeController.text
      // _roomNameController.text
      // _roomDescriptionController.text
      // double.parse(_roomPriceController.text)
      // _ac, _tv, _miniBar, _jacuzzi, _balcony, _kitchen
      // _photoFile

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kamar berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );

      // Close modal
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _roomCodeController.dispose();
    _roomTypeController.dispose();
    _roomNameController.dispose();
    _roomDescriptionController.dispose();
    _roomPriceController.dispose();
    super.dispose();
  }
}
