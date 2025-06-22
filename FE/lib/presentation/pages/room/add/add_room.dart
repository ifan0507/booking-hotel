import 'dart:io';

import 'package:fe/presentation/pages/room/add/add_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final AddRoomController _addRoomController = Get.put(AddRoomController());
  final _formKey = GlobalKey<FormState>();

  final List<String> roomType = ['Deluxe', 'Standard', 'Suite', 'Presidential'];
  String? hintText;
  String? selectedRoomType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _addRoomController.isFullScreen.value
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 0.8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  _addRoomController.isFullScreen.value ? 0 : 25),
              topRight: Radius.circular(
                  _addRoomController.isFullScreen.value ? 0 : 25),
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
                    topLeft: Radius.circular(
                        _addRoomController.isFullScreen.value ? 0 : 25),
                    topRight: Radius.circular(
                        _addRoomController.isFullScreen.value ? 0 : 25),
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
                    if (!_addRoomController.isFullScreen.value)
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
                      'Add new room',
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
                              _addRoomController.isFullScreen.value =
                                  !_addRoomController.isFullScreen.value;
                            });
                          },
                          icon: Icon(
                            _addRoomController.isFullScreen.value
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Color(0xFF1a237e),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _addRoomController.resetForm();
                            Navigator.pop(context);
                          },
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
                          child: _addRoomController.photoFile == null
                              ? InkWell(
                                  onTap: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(
                                        source: ImageSource.gallery);

                                    if (pickedFile != null) {
                                      setState(() {
                                        _addRoomController.photoFile =
                                            File(pickedFile.path);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Tidak ada gambar yang dipilih')),
                                      );
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_photo_alternate_outlined,
                                          size: 50, color: Colors.grey[400]),
                                      SizedBox(height: 10),
                                      Text('Add room picture',
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
                                        _addRoomController.photoFile!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () => setState(() =>
                                            _addRoomController.photoFile =
                                                null),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room Code',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1a237e),
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              readOnly: true,
                              controller: _addRoomController.roomCodeController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.qr_code,
                                    color: Color(0xFF1a237e)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Color(0xFF1a237e), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room Type',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1a237e),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 0.0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Tombol Tutup
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const SizedBox(
                                                        width:
                                                            48), // untuk keseimbangan
                                                    const Text(
                                                      'Pilih Tipe Kamar',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.close),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                  thickness: 0.5, height: 0),

                                              ...roomType
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                final index = entry.key;
                                                final value = entry.value;

                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(
                                                          _getRoomIcon(value),
                                                          color: Color(
                                                              0xFF1a237e)),
                                                      title: Text(
                                                        value,
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          selectedRoomType =
                                                              value;
                                                        });
                                                        _addRoomController
                                                            .roomTypeController
                                                            .text = value;
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    if (index !=
                                                        roomType.length - 1)
                                                      Divider(
                                                        height: 0,
                                                        thickness: 0.3,
                                                        color: Colors
                                                            .grey.shade300,
                                                        indent: 16,
                                                        endIndent: 16,
                                                      ),
                                                  ],
                                                );
                                              }).toList(),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          blurRadius: 3,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              _getRoomIcon(
                                                  selectedRoomType ?? ''),
                                              color: Colors.blue.shade900,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              selectedRoomType ??
                                                  'Pilih tipe kamar',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: selectedRoomType == null
                                                    ? Colors.grey
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),

                        SizedBox(height: 20),

                        // Room Name
                        _buildTextField(
                          controller: _addRoomController.roomNameController,
                          label: 'Room Name',
                          hint: 'Contoh: Kamar Deluxe Ocean View',
                          icon: Icons.hotel,
                        ),

                        SizedBox(height: 20),

                        // Room Description
                        _buildTextField(
                          controller:
                              _addRoomController.roomDescriptionController,
                          label: 'Room Description',
                          hint: 'Deskripsi lengkap kamar...',
                          icon: Icons.description,
                          maxLines: 3,
                        ),

                        SizedBox(height: 20),

                        // Room Price
                        _buildTextField(
                          controller: _addRoomController.roomPriceController,
                          label: 'Room Price',
                          hint: 'Contoh: 500000',
                          icon: Icons.attach_money,
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: 30),

                        // Facilities Section
                        Text(
                          'Ameniti Room',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a237e),
                          ),
                        ),

                        SizedBox(height: 15),

                        // Facilities switches
                        _buildFacilitySwitch(
                            'AC', Icons.ac_unit, _addRoomController.ac.value,
                            (value) {
                          setState(() => _addRoomController.ac.value = value);
                        }),

                        _buildFacilitySwitch(
                            'TV', Icons.tv, _addRoomController.tv.value,
                            (value) {
                          setState(() => _addRoomController.tv.value = value);
                        }),

                        _buildFacilitySwitch('Mini Bar', Icons.local_bar,
                            _addRoomController.miniBar.value, (value) {
                          setState(
                              () => _addRoomController.miniBar.value = value);
                        }),

                        _buildFacilitySwitch('Jacuzzi', Icons.bathtub,
                            _addRoomController.jacuzzi.value, (value) {
                          setState(
                              () => _addRoomController.jacuzzi.value = value);
                        }),

                        _buildFacilitySwitch('Balcony', Icons.balcony,
                            _addRoomController.balcony.value, (value) {
                          setState(
                              () => _addRoomController.balcony.value = value);
                        }),

                        _buildFacilitySwitch('Kitchen', Icons.kitchen,
                            _addRoomController.kitchen.value, (value) {
                          setState(
                              () => _addRoomController.kitchen.value = value);
                        }),

                        SizedBox(height: 40),

                        // Save Button
                        Obx(() => AnimatedOpacity(
                              opacity: _addRoomController.isFormValid.value
                                  ? 1.0
                                  : 0.5,
                              duration: Duration(milliseconds: 300),
                              child: SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: _addRoomController
                                              .isFormValid.value &&
                                          !_addRoomController.isLoading.value
                                      ? () {
                                          _addRoomController.saveRoom(context);
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1a237e),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 3,
                                  ),
                                  child: _addRoomController.isLoading.value
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color:
                                                Color.fromARGB(255, 8, 8, 158),
                                          ),
                                        )
                                      : const Text(
                                          'Save Room',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                            )),
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
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF1a237e), width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        )
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

  IconData _getRoomIcon(String? type) {
    switch (type) {
      case 'Deluxe':
        return Icons.hotel;
      case 'Standard':
        return Icons.bed;
      case 'Suite':
        return Icons.apartment;
      case 'Presidential':
        return Icons.business_center;
      default:
        return Icons.category;
    }
  }
}
