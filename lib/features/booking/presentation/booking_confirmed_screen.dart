import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/booking_service.dart';
import '../../tracking/presentation/live_tracking_screen.dart';
import '../../workers/presentation/worker_profile_screen.dart';

class _NearbyWorkerData {
  final String name;
  final String role;
  final String avatarUrl;
  final double rating;
  final int reviews;
  final String distance;
  final String arrivalTime;
  final String price;
  final String badge;
  final Color badgeColor;
  final List<String> highlights;

  const _NearbyWorkerData({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.arrivalTime,
    required this.price,
    required this.badge,
    required this.badgeColor,
    required this.highlights,
  });
}

class BookingConfirmedScreen extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final String avatarUrl;
  final String price;
  final String serviceName;
  final String? subServiceName;

  const BookingConfirmedScreen({
    super.key,
    this.workerName = 'Nimal Perera',
    this.workerRole = 'Plumber',
    this.avatarUrl =
        'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&auto=format&fit=crop&q=80',
    this.price = 'LKR 2,000',
    this.serviceName = 'Plumbing',
    this.subServiceName,
  });

  @override
  State<BookingConfirmedScreen> createState() => _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState extends State<BookingConfirmedScreen> {
  late final PageController _pageController;
  late final ScrollController _avatarScrollController;
  int _workerIndex = 0;
  late final List<_NearbyWorkerData> _workerPool;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.90);
    _avatarScrollController = ScrollController();

    _workerPool = _buildWorkerPool();
  }

  List<_NearbyWorkerData> _buildWorkerPool() {
    final s = widget.serviceName.toLowerCase();
    if (s.contains('elec')) {
      return [
        _NearbyWorkerData(
          name: widget.workerName,
          role: widget.workerRole.isNotEmpty ? widget.workerRole : 'Master Electrician',
          avatarUrl: widget.avatarUrl,
          rating: 4.8,
          reviews: 120,
          distance: '0.5 km away',
          arrivalTime: '5-8 mins',
          price: widget.price,
          badge: '⭐ Top Match (Closest)',
          badgeColor: const Color(0xFF16A34A),
          highlights: ['Licensed Pro', 'Fast Arrival', 'Tools Ready'],
        ),
        _NearbyWorkerData(
          name: 'Suresh Kumar',
          role: 'Senior Electrical Specialist',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          rating: 4.9,
          reviews: 185,
          distance: '0.8 km away',
          arrivalTime: '8-12 mins',
          price: widget.price,
          badge: '🏆 Highest Rated (4.9★)',
          badgeColor: const Color(0xFFD97706),
          highlights: ['Short Circuit Expert', '12 Yrs Exp', 'Guaranteed Fix'],
        ),
        _NearbyWorkerData(
          name: 'Chaminda Perera',
          role: 'Certified Domestic Electrician',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          rating: 4.7,
          reviews: 94,
          distance: '1.2 km away',
          arrivalTime: '12-15 mins',
          price: widget.price,
          badge: '⚡ Speed Specialist',
          badgeColor: const Color(0xFF2563EB),
          highlights: ['Safety Certified', 'Affordable', 'Same Day'],
        ),
        _NearbyWorkerData(
          name: 'Dinesh Wickramasinghe',
          role: 'Master Appliance Electrician',
          avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
          rating: 4.8,
          reviews: 142,
          distance: '1.8 km away',
          arrivalTime: '15-20 mins',
          price: widget.price,
          badge: '🛡️ Verified Pro',
          badgeColor: const Color(0xFF7C3AED),
          highlights: ['Heavy Machinery', 'Equipped Van', 'Top Reviews'],
        ),
      ];
    } else if (s.contains('ac') || s.contains('air')) {
      return [
        _NearbyWorkerData(
          name: widget.workerName,
          role: widget.workerRole.isNotEmpty ? widget.workerRole : 'HVAC / AC Specialist',
          avatarUrl: widget.avatarUrl,
          rating: 4.8,
          reviews: 120,
          distance: '0.5 km away',
          arrivalTime: '5-8 mins',
          price: widget.price,
          badge: '⭐ Top Match (Closest)',
          badgeColor: const Color(0xFF16A34A),
          highlights: ['Gas Leak Expert', 'Fast Clean', 'Tools Ready'],
        ),
        _NearbyWorkerData(
          name: 'Ruwan Dissanayake',
          role: 'Senior Air Con Technician',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          rating: 4.9,
          reviews: 185,
          distance: '0.8 km away',
          arrivalTime: '8-12 mins',
          price: widget.price,
          badge: '🏆 Highest Rated (4.9★)',
          badgeColor: const Color(0xFFD97706),
          highlights: ['Compressor Pro', '10 Yrs Exp', 'Original Parts'],
        ),
        _NearbyWorkerData(
          name: 'Asanka Jayawardena',
          role: 'Certified Cooling Specialist',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          rating: 4.7,
          reviews: 94,
          distance: '1.2 km away',
          arrivalTime: '12-15 mins',
          price: widget.price,
          badge: '⚡ Speed Specialist',
          badgeColor: const Color(0xFF2563EB),
          highlights: ['Deep Chemical Clean', 'Inverter Expert', 'Fast Response'],
        ),
        _NearbyWorkerData(
          name: 'Roshan Fernando',
          role: 'Industrial & Home AC Pro',
          avatarUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400&fit=crop&q=80',
          rating: 4.8,
          reviews: 142,
          distance: '1.8 km away',
          arrivalTime: '15-20 mins',
          price: widget.price,
          badge: '🛡️ Verified Pro',
          badgeColor: const Color(0xFF7C3AED),
          highlights: ['Full Diagnostics', 'Warranty Fix', 'Fair Rates'],
        ),
      ];
    } else {
      // Default Plumbing / General Services
      return [
        _NearbyWorkerData(
          name: widget.workerName,
          role: widget.workerRole.isNotEmpty ? widget.workerRole : 'Master Plumber',
          avatarUrl: widget.avatarUrl,
          rating: 4.8,
          reviews: 120,
          distance: '0.5 km away',
          arrivalTime: '5-8 mins',
          price: widget.price,
          badge: '⭐ Top Match (Closest)',
          badgeColor: const Color(0xFF16A34A),
          highlights: ['Pipe & Tap Pro', 'Fast Arrival', 'Tools Ready'],
        ),
        _NearbyWorkerData(
          name: 'Roshan Fernando',
          role: 'Senior Plumbing Specialist',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          rating: 4.9,
          reviews: 185,
          distance: '0.8 km away',
          arrivalTime: '8-12 mins',
          price: widget.price,
          badge: '🏆 Highest Rated (4.9★)',
          badgeColor: const Color(0xFFD97706),
          highlights: ['Leakage Specialist', '10 Yrs Exp', 'Zero Mess'],
        ),
        _NearbyWorkerData(
          name: 'Sunil Wijesinghe',
          role: 'Certified Master Plumber',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          rating: 4.7,
          reviews: 94,
          distance: '1.2 km away',
          arrivalTime: '12-15 mins',
          price: widget.price,
          badge: '⚡ Speed Specialist',
          badgeColor: const Color(0xFF2563EB),
          highlights: ['Bathroom Fittings', 'Motor & Tank', 'Fast Arrival'],
        ),
        _NearbyWorkerData(
          name: 'Kasun Bandara',
          role: 'Emergency Plumbing Technician',
          avatarUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400&fit=crop&q=80',
          rating: 4.8,
          reviews: 142,
          distance: '1.8 km away',
          arrivalTime: '15-20 mins',
          price: widget.price,
          badge: '🛡️ Verified Pro',
          badgeColor: const Color(0xFF7C3AED),
          highlights: ['Emergency Repairs', 'Tap & Pipe Pro', 'Fair Rates'],
        ),
      ];
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _avatarScrollController.dispose();
    super.dispose();
  }

  void _onWorkerSelected(int index) {
    if (index >= 0 && index < _workerPool.length) {
      setState(() {
        _workerIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openWorkerProfile(_NearbyWorkerData worker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerProfileScreen(
          name: worker.name,
          role: worker.role,
          distance: worker.distance,
          rating: worker.rating,
          reviewsCount: worker.reviews,
          avatarUrl: worker.avatarUrl,
          price: worker.price,
          serviceName: widget.serviceName,
          subServiceName: widget.subServiceName,
        ),
      ),
    );
  }

  void _hireWorker(_NearbyWorkerData worker) {
    // Register active booking in shared state
    BookingService.createActiveBooking(
      workerName: worker.name,
      workerRole: worker.role,
      avatarUrl: worker.avatarUrl,
      price: worker.price,
      serviceName: widget.serviceName,
      subServiceName: widget.subServiceName,
      paymentMethod: 'Pay After Complete',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Hired ${worker.name}! Arriving in ${worker.arrivalTime}',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LiveTrackingScreen(
          workerName: worker.name,
          workerRole: worker.role,
          avatarUrl: worker.avatarUrl,
          price: worker.price,
          serviceName: widget.serviceName,
          subServiceName: widget.subServiceName,
          rating: worker.rating,
          reviewsCount: worker.reviews,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWorker = _workerPool[_workerIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A), size: 24),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          'Nearby Workers (${_workerPool.length})',
          style: GoogleFonts.inter(
            color: const Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF86EFAC)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFF16A34A),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Online Now',
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP HEADER INFO & LOCATION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 16, color: Color(0xFF005AC2)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '4 Active Workers in Colombo 03 (3 km radius)',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 2. TOP WORKER AVATAR SELECTOR STRIP
            SizedBox(
              height: 78,
              child: ListView.separated(
                controller: _avatarScrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: _workerPool.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final worker = _workerPool[index];
                  final isSelected = _workerIndex == index;
                  final firstName = worker.name.split(' ').first;

                  return GestureDetector(
                    onTap: () => _onWorkerSelected(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF005AC2).withValues(alpha: 0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xFFE2E8F0),
                                backgroundImage: NetworkImage(worker.avatarUrl),
                              ),
                              if (index == 0)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF16A34A),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.star, size: 8, color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    firstName,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.5,
                                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                      color: isSelected ? const Color(0xFF005AC2) : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 4),
                                    const Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF005AC2)),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                worker.distance.split(' ').first,
                                style: GoogleFonts.inter(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                ),
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

            const SizedBox(height: 8),

            // 3. MAIN SWIPEABLE CAROUSEL (PAGEVIEW)
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _workerIndex = index;
                      });
                    },
                    itemCount: _workerPool.length,
                    itemBuilder: (context, index) {
                      final worker = _workerPool[index];
                      return _buildWorkerCard(worker, index);
                    },
                  ),

                  // Floating Left Navigation Arrow
                  if (_workerIndex > 0)
                    Positioned(
                      left: 6,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          elevation: 3,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => _onWorkerSelected(_workerIndex - 1),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.chevron_left_rounded, size: 24, color: Color(0xFF0F172A)),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Floating Right Navigation Arrow
                  if (_workerIndex < _workerPool.length - 1)
                    Positioned(
                      right: 6,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          elevation: 3,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () => _onWorkerSelected(_workerIndex + 1),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.chevron_right_rounded, size: 24, color: Color(0xFF0F172A)),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // 4. CAROUSEL DOTS & "BACK TO 1ST WORKER" HELPER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dots
                  Row(
                    children: List.generate(
                      _workerPool.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _workerIndex == i ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _workerIndex == i ? const Color(0xFF005AC2) : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Return to 1st Match Shortcut Button
                  if (_workerIndex > 0)
                    InkWell(
                      onTap: () => _onWorkerSelected(0),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF86EFAC)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.undo_rounded, size: 14, color: Color(0xFF15803D)),
                            const SizedBox(width: 4),
                            Text(
                              'Back to 1st Match (${_workerPool[0].name.split(' ').first})',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF15803D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Text(
                      'Swipe left to see more workers 👉',
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 5. STICKY BOTTOM ACTION BAR (HIRE BUTTON)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () => _hireWorker(currentWorker),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16A34A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_rounded, size: 20, color: Colors.white),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Hire ${currentWorker.name} (${currentWorker.price})',
                              style: GoogleFonts.inter(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Cancel & Back to Home',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
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
  }

  Widget _buildWorkerCard(_NearbyWorkerData worker, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _workerIndex == index ? const Color(0xFFBFDBFE) : const Color(0xFFE2E8F0),
          width: _workerIndex == index ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Badges Row (Distance, Tag)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.near_me_rounded, size: 12, color: Color(0xFF005AC2)),
                        const SizedBox(width: 4),
                        Text(
                          worker.distance,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF005AC2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: worker.badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      worker.badge,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: worker.badgeColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Worker Avatar with Verified Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neutral.withValues(alpha: 0.1),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        worker.avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFFBACFFB),
                          child: const Icon(Icons.person, color: Color(0xFF1E3A8A), size: 50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF005AC2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: const Center(
                        child: Icon(Icons.verified_rounded, color: Colors.white, size: 15),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Worker Name
              Text(
                worker.name,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 2),

              // Role
              Text(
                worker.role,
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // Rating & Reviews Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFD97706), size: 17),
                    const SizedBox(width: 4),
                    Text(
                      '${worker.rating}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF92400E),
                      ),
                    ),
                    Text(
                      ' (${worker.reviews} reviews) • 98% Success',
                      style: GoogleFonts.inter(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Feature / Skills Chips
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: worker.highlights.map((h) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      h,
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              // Arrival Time & Estimated Price Box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFF16A34A)),
                        const SizedBox(width: 6),
                        Text(
                          'Arrival: ${worker.arrivalTime}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF15803D),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      worker.price,
                      style: GoogleFonts.inter(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // "View Full Profile" Action Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () => _openWorkerProfile(worker),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF005AC2),
                    side: const BorderSide(color: Color(0xFF005AC2), width: 1.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_outline_rounded, size: 18, color: Color(0xFF005AC2)),
                      const SizedBox(width: 8),
                      Text(
                        'View Full Profile & Reviews',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF005AC2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0xFF005AC2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
