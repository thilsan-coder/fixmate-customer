import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Worker Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.heart)),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.background,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.person, size: 40, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Sunimal Perera',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.verified, size: 18, color: AppColors.primary),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Certified Master Plumber',
                          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star_rounded, size: 18, color: AppColors.accent),
                            SizedBox(width: 4),
                            Text(
                              '4.9 (142 reviews)',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Statistics Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('5+ Years', 'Experience'),
                  _buildStatItem('350+', 'Jobs Done'),
                  _buildStatItem('99%', 'Satisfaction'),
                ],
              ),
            ),
            const Divider(color: AppColors.divider),

            // About Me
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    'Experienced plumber with 5+ years of expertise in residential and commercial plumbing installations, leak detection, drainage, bathroom fitting, and emergency maintenance. Dedicated to delivering reliable, long-lasting solutions.',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
                  ),
                ],
              ),
            ),

            // Pricing & Rate
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Estimated Hourly Rate:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    Text('LKR 1,800 - 2,500', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Chat',
                isOutlined: true,
                icon: Iconsax.message,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.chat);
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 2,
              child: CustomButton(
                text: 'Book Now',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.extraService);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}
