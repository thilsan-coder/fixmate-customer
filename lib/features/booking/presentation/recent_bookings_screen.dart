import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class RecentBookingsScreen extends StatelessWidget {
  const RecentBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: 'Ongoing (1)'),
              Tab(text: 'Completed (4)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Ongoing Bookings
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildBookingCard(
                  context,
                  title: 'Plumbing Service - Pipe Leak',
                  worker: 'Sunimal Perera',
                  status: 'In Progress',
                  statusColor: AppColors.warning,
                  price: 'LKR 2,950',
                  date: 'Today, 10:30 AM',
                  isOngoing: true,
                ),
              ],
            ),
            // Completed Bookings
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildBookingCard(
                  context,
                  title: 'Electrical Wiring Repair',
                  worker: 'Kamal Fernando',
                  status: 'Completed',
                  statusColor: AppColors.success,
                  price: 'LKR 3,500',
                  date: '02 Oct 2026',
                  isOngoing: false,
                ),
                const SizedBox(height: 12),
                _buildBookingCard(
                  context,
                  title: 'AC Gas Refill & Filter Wash',
                  worker: 'Nimal Jayakody',
                  status: 'Completed',
                  statusColor: AppColors.success,
                  price: 'LKR 5,200',
                  date: '28 Sep 2026',
                  isOngoing: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(
    BuildContext context, {
    required String title,
    required String worker,
    required String status,
    required Color statusColor,
    required String price,
    required String date,
    required bool isOngoing,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.bookingDetails);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text('Worker: $worker', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const Divider(height: 20, color: AppColors.divider),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary)),
                TextButton(
                  onPressed: () {
                    if (isOngoing) {
                      Navigator.pushNamed(context, AppRoutes.liveTracking);
                    } else {
                      Navigator.pushNamed(context, AppRoutes.invoice);
                    }
                  },
                  child: Text(isOngoing ? 'Track Live' : 'View Invoice'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
