import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/country_data.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/session_manager.dart';
import 'all_categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String _userName = 'Alex';
  String _userCity = 'Colombo';

  // Hero Banner Carousel
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  final List<Map<String, dynamic>> _bannerSlides = [
    {
      'title': 'Trusted\nWorkers Near\nYou',
      'tagline': '20% OFF FIRST BOOKING',
      'buttonText': 'Book now',
      'image': AppAssets.workerBanner,
      'gradient': const [Color(0xFF0047AB), Color(0xFF005AC2)],
    },
    {
      'title': 'Emergency\n24/7 Rapid\nService',
      'tagline': '30 MIN ARRIVAL PROMISE',
      'buttonText': 'Find Now',
      'image': AppAssets.onboardingHero,
      'gradient': const [Color(0xFF0F766E), Color(0xFF0D9488)],
    },
    {
      'title': 'Certified\nQuality &\nWarranty',
      'tagline': '100% VERIFIED PROS',
      'buttonText': 'Explore',
      'image': AppAssets.servicePainting,
      'gradient': const [Color(0xFF4338CA), Color(0xFF6366F1)],
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'electrician',
      'title': 'Electrician',
      'icon': Icons.bolt_rounded,
      'color': const Color(0xFFD97706),
      'bgColor': const Color(0xFFFEF3C7),
      'badge': 'HOT',
    },
    {
      'id': 'plumber',
      'title': 'Plumber',
      'icon': Icons.plumbing_rounded,
      'color': const Color(0xFF0284C7),
      'bgColor': const Color(0xFFE0F2FE),
      'badge': null,
    },
    {
      'id': 'carpenter',
      'title': 'Carpenter',
      'icon': Icons.carpenter_rounded,
      'color': const Color(0xFF92400E),
      'bgColor': const Color(0xFFFEF3C7),
      'badge': null,
    },
    {
      'id': 'painter',
      'title': 'Painter',
      'icon': Icons.format_paint_rounded,
      'color': const Color(0xFFDB2777),
      'bgColor': const Color(0xFFFCE7F3),
      'badge': 'OFFER',
    },
    {
      'id': 'ac_repair',
      'title': 'AC Repair',
      'icon': Icons.ac_unit_rounded,
      'color': const Color(0xFF0891B2),
      'bgColor': const Color(0xFFE0F2FE),
      'badge': 'TOP',
    },
    {
      'id': 'mason',
      'title': 'Mason',
      'icon': Icons.foundation_rounded,
      'color': const Color(0xFFEA580C),
      'bgColor': const Color(0xFFFFEDD5),
      'badge': null,
    },
    {
      'id': 'welder',
      'title': 'Welder',
      'icon': Icons.hardware_rounded,
      'color': const Color(0xFF4F46E5),
      'bgColor': const Color(0xFFEEF2FF),
      'badge': null,
    },
    {
      'id': 'more',
      'title': 'More',
      'icon': Icons.grid_view_rounded,
      'color': const Color(0xFF005AC2),
      'bgColor': const Color(0xFFEFF6FF),
      'badge': null,
    },
  ];

  final List<Map<String, dynamic>> _popularServices = [
    {
      'name': 'Home Wall Painting',
      'category': 'Painter • Premium Emulsion',
      'rating': '4.9',
      'reviews': '142',
      'price': 'Rs. 2,500 / hr',
      'tag': 'Best Seller',
      'image': AppAssets.servicePainting,
      'isFavorite': true,
    },
    {
      'name': 'AC Deep Jet Servicing',
      'category': 'AC Repair • Anti-Bacterial Wash',
      'rating': '5.0',
      'reviews': '198',
      'price': 'Rs. 3,200 / unit',
      'tag': 'High Demand',
      'image': AppAssets.onboardingHero,
      'isFavorite': false,
    },
    {
      'name': 'Emergency Pipe & Tap Fix',
      'category': 'Plumber • Fast Arrival',
      'rating': '4.9',
      'reviews': '210',
      'price': 'Rs. 1,500 / hr',
      'tag': 'Instant 30m',
      'image': AppAssets.workerBanner,
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        final nextPage = (_currentBannerIndex + 1) % _bannerSlides.length;
        _bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final details = await SessionManager.getUserDetails();
    if (mounted) {
      setState(() {
        final fullName = details['name']!.isNotEmpty ? details['name']! : 'Alex';
        _userName = fullName.split(' ').first;
        _userCity = CountryData.selectedCountry.cities.first;
      });
    }
  }

  // Interactive City Selector Bottom Sheet
  void _showCityPicker() {
    final cities = CountryData.selectedCountry.cities;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Your City',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    '🇱🇰 ${CountryData.selectedCountry.name}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF005AC2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.45),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cities.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    final isSelected = city == _userCity;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: isSelected ? const Color(0xFF005AC2) : const Color(0xFF94A3B8),
                          size: 20,
                        ),
                      ),
                      title: Text(
                        city,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? const Color(0xFF005AC2) : const Color(0xFF1E293B),
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle_rounded, color: Color(0xFF005AC2), size: 22)
                          : null,
                      onTap: () {
                        setState(() => _userCity = city);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Cross-Device Security Verification Alert Dialog
  void _showCrossDeviceSecurityDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 16,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFECACA), width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.phonelink_lock_rounded,
                      color: Color(0xFFDC2626),
                      size: 34,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'New Login Attempt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),

                const Text(
                  'Someone is attempting to log into your account from another device.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSecurityRow(Icons.smartphone_rounded, 'Device', 'Samsung Galaxy S24 Ultra'),
                      const SizedBox(height: 8),
                      _buildSecurityRow(Icons.location_on_outlined, 'Location', 'Colombo, Sri Lanka'),
                      const SizedBox(height: 8),
                      _buildSecurityRow(Icons.access_time_rounded, 'Time', 'Just now'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                const Text(
                  '⚠️ Approving this request will log you out from this device immediately.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFB91C1C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login request denied ❌'),
                              backgroundColor: Color(0xFFDC2626),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 46),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Deny', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _approveAndLogout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF005AC2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 46),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Approve', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _approveAndLogout() async {
    await SessionManager.logout();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    }
  }

  Widget _buildSecurityRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Logout Handler
  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to log out from FixMate?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await SessionManager.logout();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Ultra-Modern Header: User Profile Greeting + Interactive City Pill + Notification Bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Good morning, $_userName',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 3),

                      // Interactive City Selector Pill
                      InkWell(
                        onTap: _showCityPicker,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined, color: Color(0xFF005AC2), size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '$_userCity, ${CountryData.selectedCountry.name}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF005AC2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF005AC2), size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Notification Bell Button
                  InkWell(
                    onTap: _showCrossDeviceSecurityDialog,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.notifications_none_rounded, color: Color(0xFF0F172A), size: 24),
                          Positioned(
                            top: 13,
                            right: 14,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // 2. Search & Filter Bar (Clickable directly into All Categories)
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.allCategories);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 14),
                            Icon(Icons.search_rounded, color: Color(0xFF005AC2), size: 22),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Search electrician, plumber, AC...',
                                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Filter Button
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.allCategories);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF005AC2),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF005AC2).withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Swipeable Carousel Hero Banner
              SizedBox(
                height: 175,
                child: PageView.builder(
                  controller: _bannerController,
                  itemCount: _bannerSlides.length,
                  onPageChanged: (idx) => setState(() => _currentBannerIndex = idx),
                  itemBuilder: (context, index) {
                    final slide = _bannerSlides[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: slide['gradient'] as List<Color>,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: (slide['gradient'] as List<Color>).first.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            // Background Ambient Circles
                            Positioned(
                              right: -30,
                              top: -30,
                              child: Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.08),
                                ),
                              ),
                            ),

                            // Worker Image
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              width: 155,
                              child: Image.asset(
                                slide['image'] as String,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.handyman_rounded, color: Colors.white70, size: 70),
                                  );
                                },
                              ),
                            ),

                            // Text & Button Content
                            Positioned(
                              left: 20,
                              top: 18,
                              bottom: 18,
                              right: 145,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      slide['tagline'] as String,
                                      style: const TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    slide['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.18,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, AppRoutes.allCategories);
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            slide['buttonText'] as String,
                                            style: const TextStyle(
                                              color: Color(0xFF0047AB),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          const Icon(Icons.arrow_forward_rounded, color: Color(0xFF0047AB), size: 14),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Banner Indicator Dots
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(_bannerSlides.length, (idx) {
                    final isSelected = idx == _currentBannerIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isSelected ? 20 : 6,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // 4. Quality Shield Strip (Apple/Urban Company Standard)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified_user_rounded, color: Color(0xFF16A34A), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '100% Background-Checked Pros • Fixed Upfront Prices • 7-Day Warranty',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF166534),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. Categories Section Header: "Categories" + "View All"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.allCategories);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF005AC2),
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF005AC2), size: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 8 Categories Grid with Micro Badges & Glow
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.80,
                ),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final badge = cat['badge'] as String?;

                  return InkWell(
                    onTap: () {
                      final id = cat['id'] as String;
                      final initialId = id == 'more' ? 'electrician' : id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllCategoriesScreen(initialCategoryId: initialId),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: cat['bgColor'] as Color,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: (cat['color'] as Color).withValues(alpha: 0.2),
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  cat['icon'] as IconData,
                                  color: cat['color'] as Color,
                                  size: 26,
                                ),
                              ),
                            ),
                            if (badge != null)
                              Positioned(
                                top: -4,
                                right: -4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEF4444),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white, width: 1.5),
                                  ),
                                  child: Text(
                                    badge,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cat['title'] as String,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 22),

              // 6. Popular Services Header: "Popular Services" + "Explore"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.allCategories);
                    },
                    child: const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF005AC2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Popular Services Card List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _popularServices.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final service = _popularServices[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.allCategories);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        children: [
                          // Service Thumbnail Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 80,
                              height: 80,
                              color: const Color(0xFFF1F5F9),
                              child: Image.asset(
                                service['image'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.handyman_rounded, color: Color(0xFF94A3B8), size: 32),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Service Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (service['tag'] != null) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      service['tag'] as String,
                                      style: const TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF005AC2),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                ],
                                Text(
                                  service['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  service['category'] as String,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 15),
                                    const SizedBox(width: 3),
                                    Text(
                                      '${service['rating']} (${service['reviews']})',
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      service['price'] as String,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF005AC2),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),

                          // Favorite Heart Icon
                          IconButton(
                            icon: Icon(
                              service['isFavorite'] == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: service['isFavorite'] == true ? const Color(0xFFEF4444) : const Color(0xFFCBD5E1),
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                service['isFavorite'] = !(service['isFavorite'] as bool);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // 7. Sleek Bottom Navigation Bar (Home, Bookings, Chat, Profile)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: (index) {
            setState(() => _currentNavIndex = index);
            if (index == 3) {
              _handleLogout();
            }
          },
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF005AC2),
          unselectedItemColor: const Color(0xFF94A3B8),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Iconsax.home_2, size: 22),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Iconsax.home_2, size: 22, color: Color(0xFF005AC2)),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Iconsax.calendar_1, size: 22),
              ),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Iconsax.message, size: 22),
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(Iconsax.user, size: 22),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
