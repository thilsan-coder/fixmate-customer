import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class JobCompletedReviewScreen extends StatefulWidget {
  const JobCompletedReviewScreen({super.key});

  @override
  State<JobCompletedReviewScreen> createState() => _JobCompletedReviewScreenState();
}

class _JobCompletedReviewScreenState extends State<JobCompletedReviewScreen> {
  double _rating = 5.0;
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Rate Your Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Worker Avatar
            const CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.person, size: 50, color: AppColors.primary),
            ),
            const SizedBox(height: 14),
            const Text(
              'Sunimal Perera',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Plumbing Repair Service',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 28),

            const Text(
              'How was your experience?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Rating Bar
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: AppColors.accent,
              ),
              onRatingUpdate: (rating) {
                setState(() => _rating = rating);
              },
            ),
            const SizedBox(height: 28),

            CustomTextField(
              controller: _reviewController,
              labelText: 'Write a Review (Optional)',
              hintText: 'Share your experience with Sunimal...',
              maxLines: 4,
            ),
            const SizedBox(height: 36),

            CustomButton(
              text: 'Submit Review',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Thank you for your $_rating star rating!')),
                );
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNav, (route) => false);
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNav, (route) => false);
              },
              child: const Text('Skip for now', style: TextStyle(color: AppColors.textMuted)),
            ),
          ],
        ),
      ),
    );
  }
}
