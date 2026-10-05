import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class ExtraServiceScreen extends StatefulWidget {
  const ExtraServiceScreen({super.key});

  @override
  State<ExtraServiceScreen> createState() => _ExtraServiceScreenState();
}

class _ExtraServiceScreenState extends State<ExtraServiceScreen> {
  final _descController = TextEditingController();

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Describe Your Problem')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What do you need help with?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add clear details or upload photos so our expert can bring the right tools.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _descController,
              labelText: 'Problem Description',
              hintText: 'e.g. The kitchen pipe is leaking water rapidly under the sink...',
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            const Text('Attach Photos (Optional)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, color: AppColors.primary, size: 28),
                      SizedBox(height: 4),
                      Text('Add Photo', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Choose Service Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: const Text('Emergency (Within 30 mins)'),
                  backgroundColor: AppColors.primaryLight,
                  side: const BorderSide(color: AppColors.primary),
                ),
                const Chip(
                  label: Text('Scheduled for Later'),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: AppColors.border),
                ),
              ],
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Continue to Summary',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.bookingSummary);
              },
            ),
          ],
        ),
      ),
    );
  }
}
