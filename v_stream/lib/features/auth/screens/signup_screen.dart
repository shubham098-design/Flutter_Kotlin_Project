import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:v_stream/features/auth/controller/auth_controller.dart';

import '../../../route/routes_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  String _selectedCountryCode = '+91'; // default India

  AuthController authController = Get.put(AuthController());
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> signup()async{
    await authController.signUp(usernameController.text.trim(), emailController.text.trim(), passwordController.text.trim(), phoneController.text.trim());
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sign up to get started!',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),

                  _buildTextField(controller:usernameController,label: 'Username', icon: Icons.person),
                  const SizedBox(height: 16),

                  _buildTextField(controller:emailController,label: 'Email', icon: Icons.email, keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),

                  _buildPasswordField(),
                  const SizedBox(height: 16),

                  _buildPhoneField(),
                  const SizedBox(height: 32),

                 Obx(()=> SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signup();
                        }
                      },
                      child: authController.isSigningUp.value ? const CircularProgressIndicator()
                          : Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                      ) ,
                    ),
                  )
                 ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(RoutesName.login_screen_route);
                        },
                        child: Text(
                          'Log In',
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.lightBlueAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: (value) => value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _obscurePassword,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: (value) => value == null || value.isEmpty ? 'Enter Password' : null,
    );
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        CountryCodePicker(
          onChanged: (code) {
            setState(() {
              _selectedCountryCode = code.dialCode ?? '+91';
            });
          },
          initialSelection: 'IN',
          favorite: ['+91', 'US'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: (value) => value == null || value.isEmpty ? 'Enter phone number' : null,
          ),
        ),
      ],
    );
  }
}
