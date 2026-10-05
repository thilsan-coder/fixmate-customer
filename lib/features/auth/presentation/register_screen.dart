import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
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
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.build_rounded, size: 40, color: AppColors.primary),
                    SizedBox(height: 6),
                    Text(
                      'FixMate',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _nameController,
                labelText: 'Full Name',
                hintText: 'e.g. Alex Johnson',
                prefixIcon: const Icon(Icons.person_outline, color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                hintText: '+94 77 123 4567',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email Address (Optional)',
                hintText: 'alex@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.mail_outline, color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _whatsappController,
                labelText: 'WhatsApp Number',
                hintText: '+94 77 123 4567',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.chat_outlined, color: AppColors.textMuted),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _cityController,
                labelText: 'Select your city',
                hintText: 'Colombo, Kandy, Jaffna...',
                prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.textMuted),
              ),
              const SizedBox(height: 28),
              CustomButton(
                text: 'Create Account',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.otpVerification);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
