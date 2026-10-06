import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  String _selectedCity = 'Colombo';

  final List<String> _cities = [
    'Colombo',
    'Kandy',
    'Galle',
    'Jaffna',
    'Gampaha',
    'Negombo',
    'Kurunegala',
    'Matara',
    'Batticaloa',
    'Anuradhapura',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF005AC2), size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Register',
          style: TextStyle(
            color: Color(0xFF005AC2),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Join thousands getting their home repaired effortlessly',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),

              // Full Name
              CustomTextField(
                controller: _nameController,
                labelText: 'Full Name',
                hintText: 'e.g. Alex Johnson',
                prefixIcon: const Icon(Iconsax.user, color: Color(0xFF94A3B8), size: 20),
              ),
              const SizedBox(height: 16),

              // Phone Number
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                hintText: '+94 77 123 4567',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Iconsax.call, color: Color(0xFF94A3B8), size: 20),
              ),
              const SizedBox(height: 16),

              // Email Address
              CustomTextField(
                controller: _emailController,
                labelText: 'Email Address (Optional)',
                hintText: 'alex@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Iconsax.sms, color: Color(0xFF94A3B8), size: 20),
              ),
              const SizedBox(height: 16),

              // WhatsApp Number
              CustomTextField(
                controller: _whatsappController,
                labelText: 'WhatsApp Number',
                hintText: '+94 77 123 4567',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.chat_outlined, color: Color(0xFF94A3B8), size: 20),
              ),
              const SizedBox(height: 16),

              // Select City Dropdown
              const Text(
                'Select Your City',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCity,
                    isExpanded: true,
                    icon: const Icon(Iconsax.arrow_down_1, color: Color(0xFF64748B), size: 18),
                    items: _cities.map((city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Row(
                          children: [
                            const Icon(Iconsax.location, color: Color(0xFF005AC2), size: 18),
                            const SizedBox(width: 10),
                            Text(
                              city,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1E293B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedCity = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // "Create Account" Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.otpVerification);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047AB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 20),

              // "Already have an account? Login"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF005AC2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
