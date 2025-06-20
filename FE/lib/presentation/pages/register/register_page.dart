import 'package:fe/core/route/app_routes.dart';
import 'package:fe/presentation/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: screenHeight * 0.4,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/hotel.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.68,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Floating Icon
                  Positioned(
                    top: -40,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_add,
                              size: 40,
                              color: Color(0xFF1a237e),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1a237e),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Form
                  Positioned.fill(
                    top: 50,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('First Name'),
                          buildInputField('Enter your first name',
                              _registerController.firstNameController),
                          SizedBox(height: 20),
                          buildLabel('Last Name'),
                          buildInputField('Enter your last name',
                              _registerController.lastNameController),
                          SizedBox(height: 20),
                          buildLabel('E-mail Address'),
                          buildInputField('Enter your email',
                              _registerController.emailController),
                          SizedBox(height: 20),
                          buildLabel('Password'),
                          buildInputField('Create your password',
                              _registerController.passwordController,
                              obscure: true),
                          SizedBox(height: 40),

                          Obx(() => AnimatedOpacity(
                                opacity: _registerController.isFormValid.value
                                    ? 1.0
                                    : 0.5,
                                duration: Duration(milliseconds: 300),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: _registerController
                                                .isFormValid.value &&
                                            !_registerController.isLoading.value
                                        ? () {
                                            _registerController.register();
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF1a237e),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: _registerController.isLoading.value
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),

                          // Already have account
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(Routes.LOGIN);
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Color(0xFF1a237e),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1a237e),
      ),
    );
  }

  Widget buildInputField(String hint, TextEditingController controller,
      {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3f51b5), width: 2),
        ),
      ),
    );
  }
}
