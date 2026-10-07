import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/country_data.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/session_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String _userName = 'Alex';
  String _userCity = 'Colombo';

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Electrician',
      'icon': Icons.bolt_rounded,
      'color': const Color(0xFFD97706),
      'bgColor': const Color(0xFFFEF3C7),
    },
    {
      'title': 'Plumber',
      'icon': Icons.plumbing_rounded,
      'color': const Color(0xFF0284C7),
      'bgColor': const Color(0xFFE0F2FE),
    },
    {
      'title': 'Carpenter',
      'icon': Icons.carpenter_rounded,
      'color': const Color(0xFF92400E),
      'bgColor': const Color(0xFFFEF3C7),
    },
    {
      'title': 'Painter',
      'icon': Icons.format_paint_rounded,
      'color': const Color(0xFFDB2777),
      'bgColor': const Color(0xFFFCE7F3),
    },
    {
      'title': 'AC Repair',
      'icon': Icons.ac_unit_rounded,
      'color': const Color(0xFF0891B2),
      'bgColor': const Color(0xFFE0F2FE),
    },
    {
      'title': 'Mason',
      'icon': Icons.foundation_rounded,
      'color': const Color(0xFFEA580C),
      'bgColor': const Color(0xFFFFEDD5),
    },
    {
      'title': 'Welder',
      'icon': Icons.hardware_rounded,
      'color': const Color(0xFF4F46E5),
      'bgColor': const Color(0xFFEEF2FF),
    },
    {
      'title': 'More',
      'icon': Icons.more_horiz_rounded,
      'color': const Color(0xFF475569),
      'bgColor': const Color(0xFFF1F5F9),
    },
  ];

  final List<Map<String, dynamic>> _popularServices = [
    {
      'name': 'Home Painting',
      'category': 'Wall & Ceiling Painting',
      'rating': '4.9',
      'reviews': '124',
      'price': 'Rs. 2,500 / hr',
      'image': AppAssets.servicePainting,
      'isFavorite': true,
    },
    {
      'name': 'AC Deep Servicing',
      'category': 'Filter Cleaning & Gas Refill',
      'rating': '4.8',
      'reviews': '98',
      'price': 'Rs. 3,500 / unit',
      'image': AppAssets.onboardingHero,
      'isFavorite': false,
    },
    {
      'name': 'Pipe & Tap Leak Repair',
      'category': 'Bathroom & Kitchen Plumbing',
      'rating': '5.0',
      'reviews': '210',
      'price': 'Rs. 1,800 / hr',
      'image': AppAssets.workerBanner,
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
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
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login approved on new device. Logged out from this device.'),
        backgroundColor: Color(0xFF005AC2),
      ),
    );
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }

  Widget _buildSecurityRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // Logout handler
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
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header: "Good morning, Alex 👋" + Location + Notification Bell
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
                              color: Color(0xFF1E293B),
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('👋', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 3),
                      InkWell(
                        onTap: _handleLogout,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined, color: Color(0xFF005AC2), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '$_userCity, ${CountryData.selectedCountry.name}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 2),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B), size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Notification Bell Squircle Button
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
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.notifications_none_rounded, color: Color(0xFF1E293B), size: 24),
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
                  // Search Input Field
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.searchResults);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 14),
                            Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 22),
                            SizedBox(width: 10),
                            Text(
                              'Search for services...',
                              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Separate Filter Sliders Button
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.searchResults);
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Center(
                        child: Icon(Icons.tune_rounded, color: Color(0xFF1E293B), size: 22),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Hero Promo Banner: "Trusted Workers Near You" + 3D Handyman Asset
              Container(
                width: double.infinity,
                height: 165,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0047AB), Color(0xFF005AC2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0047AB).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Background Graphic Circles
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                      ),

                      // Worker Image on Right
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        width: 155,
                        child: Image.asset(
                          AppAssets.workerBanner,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.handyman_rounded, color: Colors.white70, size: 70),
                            );
                          },
                        ),
                      ),

                      // Text and "Book now ->" button on Left
                      Positioned(
                        left: 20,
                        top: 20,
                        bottom: 20,
                        right: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Trusted\nWorkers Near\nYou',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.bookService);
                              },
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Book now',
                                      style: TextStyle(
                                        color: Color(0xFF0047AB),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF0047AB), size: 15),
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
              ),
              const SizedBox(height: 24),

              // 4. Categories Section Header: "Categories" + "View All"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.categories);
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF005AC2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Categories Grid (2 Rows x 4 Columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.confirmBooking);
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Column(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: cat['bgColor'] as Color,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Icon(
                              cat['icon'] as IconData,
                              color: cat['color'] as Color,
                              size: 26,
                            ),
                          ),
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
              const SizedBox(height: 24),

              // 5. Popular Services Header: "Popular Services"
              const Text(
                'Popular Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
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
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.confirmBooking);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Service Thumbnail Image
                          ClipRRect(
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
                                Text(
                                  service['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  service['category'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${service['rating']} (${service['reviews']})',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
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
                          const SizedBox(width: 8),

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

      // 6. Bottom Navigation Bar (Home, Bookings, Chat, Profile)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: (index) {
            setState(() => _currentNavIndex = index);
            if (index == 1) {
              Navigator.pushNamed(context, AppRoutes.bookingsList);
            } else if (index == 2) {
              Navigator.pushNamed(context, AppRoutes.chat);
            } else if (index == 3) {
              Navigator.pushNamed(context, AppRoutes.editProfile);
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
