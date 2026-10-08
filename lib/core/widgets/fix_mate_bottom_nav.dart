import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_routes.dart';

class FixMateBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const FixMateBottomNav({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  void _onItemTapped(BuildContext context, int targetIndex) {
    if (onTap != null) {
      onTap!(targetIndex);
      return;
    }

    if (targetIndex == currentIndex) return;

    if (targetIndex == 0) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } else if (targetIndex == 1) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.bookingsList,
        (route) => route.settings.name == AppRoutes.home,
      );
    } else if (targetIndex == 2) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.chat,
        (route) => route.settings.name == AppRoutes.home,
      );
    } else if (targetIndex == 3) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.editProfile,
        (route) => route.settings.name == AppRoutes.home,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context: context,
              activeIcon: Icons.home_rounded,
              inactiveIcon: Icons.home_outlined,
              label: 'Home',
              index: 0,
            ),
            _buildNavItem(
              context: context,
              activeIcon: Icons.calendar_month_rounded,
              inactiveIcon: Icons.calendar_month_outlined,
              label: 'Bookings',
              index: 1,
            ),
            _buildNavItem(
              context: context,
              activeIcon: Icons.chat_bubble_rounded,
              inactiveIcon: Icons.chat_bubble_outline_rounded,
              label: 'Chat',
              index: 2,
            ),
            _buildNavItem(
              context: context,
              activeIcon: Icons.person_rounded,
              inactiveIcon: Icons.person_outline_rounded,
              label: 'Profile',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required String label,
    required int index,
  }) {
    final bool isActive = currentIndex == index;

    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFD0E2FF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              activeIcon,
              color: const Color(0xFF005AC2),
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF005AC2),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onItemTapped(context, index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              inactiveIcon,
              color: const Color(0xFF64748B),
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
