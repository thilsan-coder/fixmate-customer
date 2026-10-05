import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  final List<Map<String, dynamic>> _workers = const [
    {
      'name': 'Sunimal Perera',
      'role': 'Master Plumber',
      'rating': '4.9',
      'reviews': '142',
      'rate': 'LKR 1,800/hr',
      'distance': '2.3 km away',
      'badge': 'Top Rated',
    },
    {
      'name': 'Kamal Fernando',
      'role': 'Certified Electrician',
      'rating': '4.8',
      'reviews': '98',
      'rate': 'LKR 1,500/hr',
      'distance': '3.1 km away',
      'badge': 'Verified',
    },
    {
      'name': 'Nimal Jayakody',
      'role': 'AC Technician',
      'rating': '4.7',
      'reviews': '76',
      'rate': 'LKR 2,200/hr',
      'distance': '4.5 km away',
      'badge': 'Verified',
    },
    {
      'name': 'Dinesh Dharmadasa',
      'role': 'House Painter & Decorator',
      'rating': '4.9',
      'reviews': '210',
      'rate': 'LKR 1,400/hr',
      'distance': '1.8 km away',
      'badge': 'Top Rated',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search Experts'),
      ),
      body: Column(
        children: [
          // Filter & Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search plumber, electrician...',
                      prefixIcon: const Icon(Iconsax.search_normal, color: AppColors.textMuted, size: 18),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Iconsax.filter, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Worker list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _workers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final worker = _workers[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.workerProfile);
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
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppColors.primaryLight,
                              child: const Icon(Icons.person, size: 30, color: AppColors.primary),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        worker['name'],
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(Icons.verified, size: 16, color: AppColors.primary),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    worker['role'],
                                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded, size: 16, color: AppColors.accent),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${worker['rating']} (${worker['reviews']} reviews)',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.location_on, size: 14, color: AppColors.textMuted),
                                      Text(
                                        worker['distance'],
                                        style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24, color: AppColors.divider),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Hourly Rate', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                Text(
                                  worker['rate'],
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.workerProfile);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(100, 38),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('View Profile', style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
