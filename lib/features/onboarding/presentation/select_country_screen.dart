import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  String _selectedCountry = 'Sri Lanka';
  String _searchQuery = '';

  final List<Map<String, String>> _allCountries = [
    // South Asia & Middle East
    {'name': 'Sri Lanka', 'code': '+94', 'flag': '🇱🇰'},
    {'name': 'India', 'code': '+91', 'flag': '🇮🇳'},
    {'name': 'United Arab Emirates', 'code': '+971', 'flag': '🇦🇪'},
    {'name': 'Saudi Arabia', 'code': '+966', 'flag': '🇸🇦'},
    {'name': 'Qatar', 'code': '+974', 'flag': '🇶🇦'},
    {'name': 'Kuwait', 'code': '+965', 'flag': '🇰🇼'},
    {'name': 'Oman', 'code': '+968', 'flag': '🇴🇲'},
    {'name': 'Bahrain', 'code': '+973', 'flag': '🇧🇭'},
    {'name': 'Pakistan', 'code': '+92', 'flag': '🇵🇰'},
    {'name': 'Bangladesh', 'code': '+880', 'flag': '🇧🇩'},
    {'name': 'Maldives', 'code': '+960', 'flag': '🇲🇻'},
    
    // North America & Europe
    {'name': 'United States', 'code': '+1', 'flag': '🇺🇸'},
    {'name': 'United Kingdom', 'code': '+44', 'flag': '🇬🇧'},
    {'name': 'Canada', 'code': '+1', 'flag': '🇨🇦'},
    {'name': 'Germany', 'code': '+49', 'flag': '🇩🇪'},
    {'name': 'France', 'code': '+33', 'flag': '🇫🇷'},
    {'name': 'Italy', 'code': '+39', 'flag': '🇮🇹'},
    {'name': 'Spain', 'code': '+34', 'flag': '🇪🇸'},
    {'name': 'Netherlands', 'code': '+31', 'flag': '🇳🇱'},
    {'name': 'Switzerland', 'code': '+41', 'flag': '🇨🇭'},
    {'name': 'Sweden', 'code': '+46', 'flag': '🇸🇪'},
    {'name': 'Norway', 'code': '+47', 'flag': '🇳🇴'},
    {'name': 'Ireland', 'code': '+353', 'flag': '🇮🇪'},

    // Asia Pacific & Oceania
    {'name': 'Australia', 'code': '+61', 'flag': '🇦🇺'},
    {'name': 'New Zealand', 'code': '+64', 'flag': '🇳🇿'},
    {'name': 'Singapore', 'code': '+65', 'flag': '🇸🇬'},
    {'name': 'Malaysia', 'code': '+60', 'flag': '🇲🇾'},
    {'name': 'Japan', 'code': '+81', 'flag': '🇯🇵'},
    {'name': 'South Korea', 'code': '+82', 'flag': '🇰🇷'},
    {'name': 'China', 'code': '+86', 'flag': '🇨🇳'},
    {'name': 'Thailand', 'code': '+66', 'flag': '🇹🇭'},
    {'name': 'Indonesia', 'code': '+62', 'flag': '🇮🇩'},
    {'name': 'Philippines', 'code': '+63', 'flag': '🇵🇭'},

    // Africa & Others
    {'name': 'South Africa', 'code': '+27', 'flag': '🇿🇦'},
    {'name': 'Egypt', 'code': '+20', 'flag': '🇪🇬'},
    {'name': 'Kenya', 'code': '+254', 'flag': '🇰🇪'},
    {'name': 'Nigeria', 'code': '+234', 'flag': '🇳🇬'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCountries = _allCountries.where((c) {
      final name = c['name']!.toLowerCase();
      final code = c['code']!.toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) || code.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Country'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // World Map Header illustration banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.public_rounded, color: AppColors.primary, size: 30),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose Your Region',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'To find verified home experts nearby',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Search Input Field
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search country or code...',
                  prefixIcon: const Icon(Iconsax.search_normal, color: AppColors.textMuted, size: 20),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Countries List
              Expanded(
                child: ListView.separated(
                  itemCount: filteredCountries.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = filteredCountries[index];
                    final isSelected = _selectedCountry == item['name'];

                    return InkWell(
                      onTap: () {
                        setState(() => _selectedCountry = item['name']!);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryLight : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.border,
                            width: isSelected ? 1.8 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(item['flag']!, style: const TextStyle(fontSize: 26)),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    item['code']!,
                                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, size: 14, color: Colors.white),
                              )
                            else
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.border, width: 1.5),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Continue Button
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.selectLanguage);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
