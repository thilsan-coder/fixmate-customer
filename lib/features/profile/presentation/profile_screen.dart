import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.person, size: 36, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alex Johnson',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '+94 77 123 4567',
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'alex.j@example.com',
                          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.editProfile);
                    },
                    icon: const Icon(Iconsax.edit, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profile Options Menu
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Iconsax.wallet_3,
                    title: 'Payment & Wallet',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.paymentHistory),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildMenuItem(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildMenuItem(
                    icon: Iconsax.language_circle,
                    title: 'Language',
                    trailing: 'English (US)',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.selectLanguage),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildMenuItem(
                    icon: Iconsax.info_circle,
                    title: 'Help & Support',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.helpSupport),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _buildMenuItem(
                    icon: Iconsax.logout,
                    title: 'Logout',
                    iconColor: AppColors.error,
                    textColor: AppColors.error,
                    onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? trailing,
    Color? iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.primary, size: 22),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: textColor ?? AppColors.textPrimary),
      ),
      trailing: trailing != null
          ? Text(trailing, style: const TextStyle(fontSize: 13, color: AppColors.textMuted))
          : const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textMuted),
      onTap: onTap,
    );
  }
}
