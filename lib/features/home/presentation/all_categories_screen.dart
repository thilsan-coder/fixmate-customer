import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'title': 'Cleaning', 'subtitle': 'Home, Office & Deep Cleaning', 'icon': Icons.cleaning_services, 'color': Colors.blue},
    {'title': 'Plumbing', 'subtitle': 'Pipe leakage, Tap fix & Installation', 'icon': Icons.plumbing, 'color': Colors.cyan},
    {'title': 'Electrician', 'subtitle': 'Wiring, Lights, Switches & MCB', 'icon': Icons.electrical_services, 'color': Colors.amber},
    {'title': 'Painting', 'subtitle': 'Interior, Exterior & Wall design', 'icon': Icons.format_paint, 'color': Colors.purple},
    {'title': 'Carpentry', 'subtitle': 'Furniture repair & Woodwork', 'icon': Icons.carpenter, 'color': Colors.brown},
    {'title': 'AC Repair', 'subtitle': 'Service, Gas refill & Installation', 'icon': Icons.ac_unit, 'color': Colors.teal},
    {'title': 'Appliance', 'subtitle': 'Fridge, Washing machine, Oven', 'icon': Icons.kitchen, 'color': Colors.deepOrange},
    {'title': 'Pest Control', 'subtitle': 'Termite, Bed bugs & General', 'icon': Icons.bug_report, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('All Categories')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.searchResults);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (cat['color'] as Color).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat['title'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cat['subtitle'] as String,
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textMuted),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
