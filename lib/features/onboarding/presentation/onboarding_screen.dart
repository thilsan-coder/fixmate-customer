import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Spacer(),

              // Modern Illustration Placeholder
              Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Icon(
                      Icons.handyman_rounded,
                      size: 90,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Title
              const Text(
                'Find Verified Experts',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'Connect with certified, verified professionals for all your home repair and maintenance services in minutes.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Action Buttons
              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.selectCountry);
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Login',
                isOutlined: true,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
