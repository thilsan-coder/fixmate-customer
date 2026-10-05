import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Service Invoice'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Invoice Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FixMate Invoice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
                          SizedBox(height: 4),
                          Text('Invoice #INV-2026-904', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('PAID', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                  const Divider(height: 32, color: AppColors.divider),

                  // Billed To & Service Details
                  const Text('Service Details:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  const Text('Plumbing Pipe Leak Repair', style: TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                  const Text('Worker: Sunimal Perera (ID: #WK-441)', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const Text('Date: 05 Oct 2026, 11:30 AM', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const Divider(height: 32, color: AppColors.divider),

                  // Itemized Table
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textSecondary)),
                      Text('Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Inspection & Callout Fee', style: TextStyle(fontSize: 13)),
                      Text('LKR 1,000.00', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Labor Charges (1 hr)', style: TextStyle(fontSize: 13)),
                      Text('LKR 1,800.00', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service Commission & Tax', style: TextStyle(fontSize: 13)),
                      Text('LKR 150.00', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                  const Divider(height: 32, color: AppColors.divider),

                  // Total
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('LKR 2,950.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Rate worker button
            CustomButton(
              text: 'Rate & Review Worker',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.jobCompletedReview);
              },
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: 'Back to Home',
              isOutlined: true,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNav, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
