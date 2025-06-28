import 'package:flutter/material.dart';
import 'package:fe/data/models/room.dart';
import 'package:fe/data/models/booking.dart';

class BookingRoom {
  static void show(BuildContext context, Room room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BookingModal(room: room),
    );
  }
}

class BookingModal extends StatefulWidget {
  final Room room;

  const BookingModal({Key? key, required this.room}) : super(key: key);

  @override
  State<BookingModal> createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _adultsController = TextEditingController(text: '1');
  final _childrenController = TextEditingController(text: '0');
  final _checkInController = TextEditingController();
  final _checkOutController = TextEditingController();
  final _specialRequestController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _adultsController.dispose();
    _childrenController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    _specialRequestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 10,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle Bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Close Button & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Book ${widget.room.roomName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Room Info Card
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF1a237e).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Color(0xFF1a237e).withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hotel, color: Color(0xFF1a237e), size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.room.roomName ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '\$${widget.room.roomPrice}/night',
                              style: TextStyle(
                                color: Color(0xFF1a237e),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Guest Information Section
                _buildSectionTitle('Guest Information'),
                _buildTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (value) => value?.isEmpty == true
                      ? 'Please enter your full name'
                      : null,
                  textInputAction: TextInputAction.next,
                ),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty == true)
                      return 'Please enter your email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) => value?.isEmpty == true
                      ? 'Please enter your phone number'
                      : null,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 20),

                // Booking Details Section
                _buildSectionTitle('Booking Details'),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _adultsController,
                        label: 'Adults',
                        icon: Icons.person,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty == true) return 'Required';
                          if (int.tryParse(value!) == null ||
                              int.parse(value) < 1) {
                            return 'Min 1 adult';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _childrenController,
                        label: 'Children',
                        icon: Icons.child_care,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty == true) return 'Required';
                          if (int.tryParse(value!) == null ||
                              int.parse(value) < 0) {
                            return 'Min 0';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        context: context,
                        controller: _checkInController,
                        label: 'Check-in',
                        icon: Icons.login,
                        isCheckIn: true,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDateField(
                        context: context,
                        controller: _checkOutController,
                        label: 'Check-out',
                        icon: Icons.logout,
                        isCheckIn: false,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Terms and Conditions
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'By booking, you agree to our Terms of Service and Privacy Policy. Cancellation policy applies.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed:
                            _isLoading ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey[400]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () => _handleBooking(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Color(0xFF1a237e),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                'Confirm Booking',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleBooking() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Create booking data menggunakan model Booking yang sudah ada
        final booking = Booking(
          room: widget.room,
          guest_fullName: _fullNameController.text,
          guest_email: _emailController.text,
          adults: int.parse(_adultsController.text),
          children: int.parse(_childrenController.text),
          total_guest: int.parse(_adultsController.text) +
              int.parse(_childrenController.text),
          check_in: _checkInController.text,
          check_out: _checkOutController.text,
          // confirmation_Code akan di-generate di backend
        );

        // Simulate booking process
        await Future.delayed(Duration(seconds: 2));

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking confirmed successfully!'),
            backgroundColor: Color(0xFF1a237e),
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pop(context);

        // Here you can:
        // 1. Send booking data to your backend API
        // 2. Navigate to booking confirmation page
        // 3. Save to local database
        // Example:
        // final result = await BookingService.createBooking(booking);
        // if (result.success) {
        //   Navigator.pushNamed(context, '/booking-confirmation',
        //     arguments: result.booking);
        // }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking failed. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputAction? textInputAction,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        textInputAction: textInputAction,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF1a237e), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isCheckIn,
  }) {
    return _buildTextField(
      controller: controller,
      label: label,
      icon: icon,
      readOnly: true,
      validator: (value) => value?.isEmpty == true ? 'Select date' : null,
      onTap: () async {
        DateTime initialDate =
            isCheckIn ? DateTime.now() : DateTime.now().add(Duration(days: 1));
        DateTime firstDate =
            isCheckIn ? DateTime.now() : DateTime.now().add(Duration(days: 1));

        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: DateTime.now().add(Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color(0xFF1a237e),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          controller.text =
              "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        }
      },
    );
  }
}
