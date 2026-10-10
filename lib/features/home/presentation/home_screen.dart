import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/country_data.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/session_manager.dart';
import '../../../core/widgets/fix_mate_bottom_nav.dart';
import '../../booking/presentation/book_service_screen.dart';
import 'all_categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      'distance': '2.5 km away',
      'categoryName': 'Painter',
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
      'distance': '3.2 km away',
      'categoryName': 'AC Repair',
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
      'distance': '1.8 km away',
      'categoryName': 'Plumber',
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
    final confirm = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top drag bar
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),

              // Glowing Red Logout Icon Container
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFECACA), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFDC2626),
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title
              const Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'You will need to sign in again with your phone number to access your bookings, live tracking and wallet balance.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Account card preview
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.person_rounded, color: Color(0xFF005AC2), size: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            '$_userCity, ${CountryData.selectedCountry.name}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.lock_outline_rounded, size: 12, color: Color(0xFF005AC2)),
                          SizedBox(width: 3),
                          Text('Active', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF005AC2))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons: Cancel vs Logout
              Row(
                children: [
                  // Cancel / Keep Logged In
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Confirm Logout
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context, true),
                        icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                        label: const Text(
                          'Yes, Log Out',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          elevation: 2,
                          shadowColor: const Color(0xFFDC2626).withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
                      InkWell(
                        onLongPress: _handleLogout,
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
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
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.notifications);
                    },
                    onLongPress: _showCrossDeviceSecurityDialog,
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

              // 2. Search & Filter Bar
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.searchResults);
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
                      Navigator.pushNamed(context, AppRoutes.searchResults);
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
                                      Navigator.pushNamed(context, AppRoutes.bookService);
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
                      if (id == 'more') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllCategoriesScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookServiceScreen(
                              serviceName: cat['title'] as String,
                              isCategoryFixed: true,
                            ),
                          ),
                        );
                      }
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
                      Navigator.pushNamed(context, AppRoutes.searchResults);
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
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 1. Service Thumbnail Image (Tap to Book)
                        GestureDetector(
                          onTap: () => _navigateToBooking(service),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              width: 76,
                              height: 76,
                              color: const Color(0xFFF1F5F9),
                              child: Image.asset(
                                service['image'] as String,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.handyman_rounded, color: Color(0xFF94A3B8), size: 30),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Service Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 2. Tag / Badge (Clickable -> Distance & ETA modal)
                              if (service['tag'] != null) ...[
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    _showBadgeInfoModal(context, service);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: const Color(0xFFDBEAFE)),
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
                                ),
                                const SizedBox(height: 3),
                              ],

                              // 3. Service Title (Tap to Book)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _navigateToBooking(service),
                                child: Text(
                                  service['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),

                              // 4. Category & Distance (Tap to show distance info)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _showBadgeInfoModal(context, service),
                                child: Text(
                                  service['category'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),

                              // 5. Rating and Price row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Rating (Tap for Reviews Modal)
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _showReviewsModal(context, service);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFBEB),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: const Color(0xFFFEF3C7)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 13),
                                          const SizedBox(width: 2),
                                          Text(
                                            '${service['rating']} (${service['reviews']})',
                                            style: const TextStyle(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF92400E),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),

                                  // Price (Tap for Price Breakdown Modal)
                                  Flexible(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _showPriceBreakdownModal(context, service);
                                      },
                                      child: Text(
                                        service['price'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF005AC2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),

                        // Favorite Heart Icon
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            service['isFavorite'] == true ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: service['isFavorite'] == true ? const Color(0xFFEF4444) : const Color(0xFFCBD5E1),
                            size: 22,
                          ),
                          onPressed: () {
                            final wasFav = service['isFavorite'] == true;
                            setState(() {
                              service['isFavorite'] = !wasFav;
                            });
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      !wasFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      !wasFav
                                          ? '${service['name']} added to Saved'
                                          : '${service['name']} removed from Saved',
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF0F172A),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),

      // 7. Sleek Unified Bottom Navigation Bar
      bottomNavigationBar: const FixMateBottomNav(
        currentIndex: 0,
      ),
    );
  }

  void _navigateToBooking(Map<String, dynamic> service) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookServiceScreen(
          serviceName: service['categoryName'] as String? ?? (service['name'] as String),
          serviceSubtitle: service['name'] as String?,
          isCategoryFixed: true,
        ),
      ),
    );
  }

  void _showBadgeInfoModal(BuildContext context, Map<String, dynamic> service) {
    final tag = service['tag'] as String? ?? 'Special Offer';
    final name = service['name'] as String;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return SafeArea(
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005AC2),
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    service['category'] as String,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          Icons.near_me_rounded,
                          const Color(0xFF0284C7),
                          'Distance & Location',
                          'Technician nearby (~2.5 - 4.0 km away)',
                        ),
                        const Divider(height: 20, color: Color(0xFFE2E8F0)),
                        _buildInfoRow(
                          Icons.bolt_rounded,
                          const Color(0xFFD97706),
                          'Instant Arrival Promise',
                          'Average arrival in 30 minutes at your doorstep',
                        ),
                        const Divider(height: 20, color: Color(0xFFE2E8F0)),
                        _buildInfoRow(
                          Icons.verified_user_rounded,
                          const Color(0xFF10B981),
                          'Verified Professional',
                          '100% Background-checked & Skill-certified pro',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _navigateToBooking(service);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005AC2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Book This Service Now',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showReviewsModal(BuildContext context, Map<String, dynamic> service) {
    final rating = service['rating'] as String;
    final reviews = service['reviews'] as String;
    final name = service['name'] as String;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return SafeArea(
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ratings & Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFB45309),
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (index) => const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$reviews reviews',
                              style: const TextStyle(fontSize: 11, color: Color(0xFF78350F), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              _buildRatingBar('5 ★', 0.88),
                              const SizedBox(height: 4),
                              _buildRatingBar('4 ★', 0.09),
                              const SizedBox(height: 4),
                              _buildRatingBar('3 ★', 0.03),
                              const SizedBox(height: 4),
                              _buildRatingBar('2 ★', 0.00),
                              const SizedBox(height: 4),
                              _buildRatingBar('1 ★', 0.00),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Recent Customer Feedback',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildReviewItem(
                    'Kasun Wickrama',
                    '2 days ago',
                    5,
                    'Super fast and clean work! Very knowledgeable technician.',
                  ),
                  const SizedBox(height: 8),
                  _buildReviewItem(
                    'Nimali Perera',
                    '5 days ago',
                    5,
                    'Arrived exactly on time and finished without any fuss. Highly recommended!',
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _navigateToBooking(service);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005AC2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Book This Service Now',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPriceBreakdownModal(BuildContext context, Map<String, dynamic> service) {
    final price = service['price'] as String;
    final name = service['name'] as String;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return SafeArea(
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price & Rate Card',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Estimated Price',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005AC2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        _buildPricingItem('Standard Inspection & Visit', 'Included FREE', true),
                        const Divider(height: 18, color: Color(0xFFE2E8F0)),
                        _buildPricingItem('Labor / Work Charge', price, false),
                        const Divider(height: 18, color: Color(0xFFE2E8F0)),
                        _buildPricingItem('7-Day FixMate Warranty', 'Included FREE', true),
                        const Divider(height: 18, color: Color(0xFFE2E8F0)),
                        _buildPricingItem('Spare Parts / Materials', 'Extra (At Market Rate)', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: const [
                      Icon(Icons.shield_rounded, color: Color(0xFF10B981), size: 18),
                      SizedBox(width: 6),
                      Text(
                        'No Hidden Charges • Pay after completion',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF15803D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _navigateToBooking(service);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005AC2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Proceed to Book',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, Color color, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(String label, double percent) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(String name, String time, int stars, String comment) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: List.generate(
              stars,
              (i) => const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 13),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            comment,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFF475569)),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingItem(String title, String value, bool isHighlight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF334155)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: isHighlight ? const Color(0xFF16A34A) : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
