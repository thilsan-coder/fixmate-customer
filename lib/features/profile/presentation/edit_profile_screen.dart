import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Alex Johnson');
  final _phoneController = TextEditingController(text: '+94 77 123 4567');
  final _emailController = TextEditingController(text: 'alex.j@example.com');
  final _addressController = TextEditingController(text: 'No. 45, Galle Road, Colombo 03');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 46,
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person, size: 54, color: AppColors.primary),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            CustomTextField(
              controller: _nameController,
              labelText: 'Full Name',
              prefixIcon: const Icon(Icons.person_outline, color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _phoneController,
              labelText: 'Phone Number',
              readOnly: true,
              prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _emailController,
              labelText: 'Email Address',
              prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _addressController,
              labelText: 'Default Delivery Address',
              prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.textMuted),
            ),
            const SizedBox(height: 36),

            CustomButton(
              text: 'Save Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully!')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
