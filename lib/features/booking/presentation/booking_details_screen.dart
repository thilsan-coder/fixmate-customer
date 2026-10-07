import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import 'job_completed_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  int _currentNavIndex = 1; // "Bookings" active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        titleSpacing: 0,
        title: Text(
          'Booking Details',
          style: GoogleFonts.inter(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.primary,
              size: 24,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Booking Summary Top Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badges Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Service Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightest,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Plumbing',
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3FCEF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Completed',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF006644),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Job Title & Date
                    Text(
                      'Emergency Leak',
                      style: GoogleFonts.inter(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Oct 24, 2023',
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.borderLight.withValues(alpha: 0.6),
                      ),
                    ),

                    // Assigned Professional Tile
                    Row(
                      children: [
                        // Professional Avatar
                        ClipOval(
                          child: Container(
                            width: 54,
                            height: 54,
                            color: AppColors.borderLight,
                            child: Image.network(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppColors.primaryLightest,
                                child: const Icon(Icons.person,
                                    color: AppColors.primary, size: 28),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Professional Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Assigned\nProfessional',
                                style: GoogleFonts.inter(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                  height: 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Aruna\nPerera',
                                style: GoogleFonts.inter(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Action Buttons: Chat & Call
                        // Chat Button
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Call Button
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.phone_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 2. Service Timeline Section Header
              Text(
                'Service Timeline',
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 20),

              // 3. Vertical Stepper Timeline
              _buildTimelineStep(
                title: 'Job Request',
                time: 'Oct 24, 09:00 AM',
                icon: Icons.check_rounded,
                isCompleted: true,
                isLast: false,
              ),
              _buildTimelineStep(
                title: 'Professional Assigned',
                time: 'Oct 24, 09:15 AM',
                icon: Icons.check_rounded,
                isCompleted: true,
                isLast: false,
              ),
              _buildTimelineStep(
                title: 'Work in Progress',
                time: 'Oct 24, 10:00 AM',
                icon: Icons.check_rounded,
                isCompleted: true,
                isLast: false,
              ),
              _buildTimelineStep(
                title: 'Job Completed',
                time: 'Oct 24, 10:45 AM',
                icon: Icons.celebration_rounded,
                isCompleted: true,
                isLast: true,
                isCelebration: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JobCompletedScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // 4. Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral.withValues(alpha: 0.06),
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
                icon: Icons.home_outlined,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.calendar_month_outlined,
                label: 'Bookings',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Chat',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Timeline Step Builder with vertical connecting line
  Widget _buildTimelineStep({
    required String title,
    required String time,
    required IconData icon,
    required bool isCompleted,
    required bool isLast,
    bool isCelebration = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Step Icon Circle + Connector Line Column
          Column(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFD5DFED),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // Step Title & Time Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: isCelebration
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  // Bottom Nav Item Builder (Handles active pill state & inactive state)
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = _currentNavIndex == index;

    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
        } else if (index == 2) {
          Navigator.pushNamed(context, AppRoutes.chat);
        } else if (index == 3) {
          Navigator.pushNamed(context, AppRoutes.editProfile);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.textPrimary, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
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
