import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/session_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // 5-second Smooth Linear Progress Bar Animation
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.forward();

    // Auto-check persistent login session
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate({bool isImmediate = false}) async {
    if (!isImmediate) {
      await Future.delayed(const Duration(seconds: 5));
    }
    if (!mounted) return;

    final loggedIn = await SessionManager.isLoggedIn();
    final hasCompletedOnboarding = await SessionManager.hasCompletedOnboarding();
    if (!mounted) return;

    if (loggedIn) {
      // 1. User is already logged in -> Go straight to Home
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else if (hasCompletedOnboarding) {
      // 2. Returning or logged-out user -> Go to Login (skips onboarding, country, language, register)
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      // 3. New user / First time install -> Start onboarding flow
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    _checkSessionAndNavigate(isImmediate: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Top Right "Skip" button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _navigateToNext,
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    backgroundColor: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF64748B)),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // White Rounded Card (Elevation & Soft Shadow) with Logo
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 24,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppAssets.fixmateLogo,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.home_repair_service_rounded,
                            size: 64,
                            color: AppColors.primary,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // App Name "FixMate"
              const Text(
                'FixMate',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF005AC2),
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle Tagline
              const Text(
                'Expert repairs, Instantly.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF475569),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),

              const Spacer(flex: 3),

              // "INITIALIZING..." Label
              const Text(
                'INITIALIZING...',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: Color(0xFF94A3B8),
                ),
              ),

              const SizedBox(height: 14),

              // Thin Smooth Progress Line (Blue on Light Grey)
              Container(
                width: 200,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _progressAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF005AC2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // Footer: "SECURE ENTERPRISE PLATFORM" with Shield Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 14,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'SECURE ENTERPRISE PLATFORM',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
