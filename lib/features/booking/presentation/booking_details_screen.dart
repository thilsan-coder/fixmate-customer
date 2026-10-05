import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Booking Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.access_time_filled, color: AppColors.primary, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Emergency Leak Repair', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(height: 2),
                        Text('Service ID: #FX-89421', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Worker Assigned
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sunimal Perera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('Master Plumber', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.chat);
                    },
                    icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Service Timeline
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Service Timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 16),
                  _buildTimelineItem('Booking Placed', '10:15 AM', true, true),
                  _buildTimelineItem('Professional Assigned', '10:18 AM', true, true),
                  _buildTimelineItem('On the Way (Arrival ~10:45 AM)', '10:25 AM', true, false),
                  _buildTimelineItem('Job Completed', 'Pending', false, false),
                ],
              ),
            ),
            const SizedBox(height: 28),
            CustomButton(
              text: 'Track on Live Map',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.liveTracking);
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Complete & Review',
              isOutlined: true,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.jobCompletedReview);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, bool isDone, bool showLine) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 20,
              color: isDone ? AppColors.primary : AppColors.textMuted,
            ),
            if (showLine)
              Container(
                width: 2,
                height: 32,
                color: isDone ? AppColors.primary : AppColors.border,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isDone ? FontWeight.w600 : FontWeight.normal,
                    color: isDone ? AppColors.textPrimary : AppColors.textMuted,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
