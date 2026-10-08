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
  final String price;

  const _NearbyWorkerData({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.price,
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
  late String _currentWorkerName;
  late String _currentWorkerRole;
  late String _currentAvatarUrl;
  late String _currentPrice;
  late double _currentRating;
  late int _currentReviews;
  late String _currentDistance;

  int _workerIndex = 0;
  bool _isSwitchingWorker = false;

  late final List<_NearbyWorkerData> _workerPool;

  @override
  void initState() {
    super.initState();
    _currentWorkerName = widget.workerName;
    _currentWorkerRole = widget.workerRole;
    _currentAvatarUrl = widget.avatarUrl;
    _currentPrice = widget.price;
    _currentRating = 4.8;
    _currentReviews = 120;
    _currentDistance = '0.5 km away';

    // Populate alternative workers in this service category
    _workerPool = [
      _NearbyWorkerData(
        name: widget.workerName,
        role: widget.workerRole,
        avatarUrl: widget.avatarUrl,
        rating: 4.8,
        reviews: 120,
        distance: '0.5 km away (5 mins)',
        price: widget.price,
      ),
      _NearbyWorkerData(
        name: widget.serviceName.toLowerCase().contains('elec')
            ? 'Suresh Kumar'
            : widget.serviceName.toLowerCase().contains('ac')
                ? 'Ruwan Dissanayake'
                : 'Roshan Fernando',
        role: 'Senior ${widget.serviceName} Specialist',
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
        rating: 4.9,
        reviews: 185,
        distance: '0.9 km away (8 mins)',
        price: widget.price,
      ),
      _NearbyWorkerData(
        name: widget.serviceName.toLowerCase().contains('elec')
            ? 'Chaminda Perera'
            : widget.serviceName.toLowerCase().contains('ac')
                ? 'Asanka Jayawardena'
                : 'Sunil Wijesinghe',
        role: 'Certified ${widget.serviceName} Pro',
        avatarUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
        rating: 4.7,
        reviews: 94,
        distance: '1.2 km away (12 mins)',
        price: widget.price,
      ),
    ];
  }

  void _findAnotherWorker() {
    setState(() {
      _isSwitchingWorker = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _workerIndex = (_workerIndex + 1) % _workerPool.length;
        final nextWorker = _workerPool[_workerIndex];
        _currentWorkerName = nextWorker.name;
        _currentWorkerRole = nextWorker.role;
        _currentAvatarUrl = nextWorker.avatarUrl;
        _currentRating = nextWorker.rating;
        _currentReviews = nextWorker.reviews;
        _currentDistance = nextWorker.distance;
        _currentPrice = nextWorker.price;
        _isSwitchingWorker = false;
      });

      // Update active booking in shared state with new worker
      BookingService.createActiveBooking(
        workerName: _currentWorkerName,
        workerRole: _currentWorkerRole,
        avatarUrl: _currentAvatarUrl,
        price: _currentPrice,
        serviceName: widget.serviceName,
        subServiceName: widget.subServiceName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF005AC2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              const Icon(Icons.swap_horiz_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Connected to nearby worker: $_currentWorkerName',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _openWorkerProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerProfileScreen(
          name: _currentWorkerName,
          role: _currentWorkerRole,
          distance: _currentDistance,
          rating: _currentRating,
          reviewsCount: _currentReviews,
          avatarUrl: _currentAvatarUrl,
          price: _currentPrice,
          serviceName: widget.serviceName,
          subServiceName: widget.subServiceName,
        ),
      ),
    );
  }

  void _acceptAndTrack() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveTrackingScreen(
          workerName: _currentWorkerName,
          workerRole: _currentWorkerRole,
          avatarUrl: _currentAvatarUrl,
          price: _currentPrice,
          serviceName: widget.serviceName,
          subServiceName: widget.subServiceName,
          rating: _currentRating,
          reviewsCount: _currentReviews,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),

                      // 1. Worker Avatar with Verified Badge
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFE2E8F0),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neutral.withValues(alpha: 0.12),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  _currentAvatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: AppColors.primaryLightest,
                                    child: const Icon(
                                      Icons.person,
                                      color: AppColors.primary,
                                      size: 70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF005AC2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF005AC2)
                                          .withValues(alpha: 0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 2. Heading
                      Text(
                        'Worker Found Nearby!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Review profile details below. If set, accept to begin live tracking.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // 3. Worker Profile Quick Card (Name, Rating, Role & "View Profile" button)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _currentWorkerName,
                                        style: GoogleFonts.inter(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        _currentWorkerRole,
                                        style: GoogleFonts.inter(
                                          fontSize: 12.5,
                                          color: const Color(0xFF64748B),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Rating Pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star_rounded,
                                          color: Color(0xFFD97706), size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$_currentRating',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                      Text(
                                        ' ($_currentReviews)',
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: const Color(0xFFB45309),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Color(0xFFF1F5F9)),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.near_me_rounded,
                                        size: 16, color: Color(0xFF005AC2)),
                                    const SizedBox(width: 6),
                                    Text(
                                      _currentDistance,
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF334155),
                                      ),
                                    ),
                                  ],
                                ),
                                // "View Profile" Action Button
                                InkWell(
                                  onTap: _openWorkerProfile,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: const Color(0xFFBFDBFE)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'View Profile',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF005AC2),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 14,
                                          color: Color(0xFF005AC2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 4. Booking ID & Summary Card (NO OVERFLOW - EXPLICIT EXPANDED WRAPPING)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7FD),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Booking ID Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Booking ID',
                                  style: GoogleFonts.inter(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '#FM-882910',
                                  style: GoogleFonts.inter(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            // Date & Time Row (Safe Expanded)
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBACFFB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date & Time',
                                        style: GoogleFonts.inter(
                                          color: AppColors.textSecondary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Today • Immediate Arrival (5-8m)',
                                        style: GoogleFonts.inter(
                                          color: AppColors.textPrimary,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Service Row (SAFE EXPANDED - FIXES OVERFLOW ERROR)
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBACFFB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.build_rounded,
                                    color: AppColors.primary,
                                    size: 19,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Service Details',
                                        style: GoogleFonts.inter(
                                          color: AppColors.textSecondary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        widget.subServiceName ??
                                            '${widget.serviceName} Service',
                                        style: GoogleFonts.inter(
                                          color: AppColors.textPrimary,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // 5. Bottom Actions Area
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Primary Button: Accept & Track
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _acceptAndTrack,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005AC2),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Accept & Track Booking',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Secondary Button: "Find Another Worker" (Worker set aahalla enda)
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: _isSwitchingWorker ? null : _findAnotherWorker,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF005AC2),
                        side: const BorderSide(
                          color: Color(0xFF005AC2),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isSwitchingWorker
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF005AC2),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.sync_rounded,
                                  size: 18,
                                  color: Color(0xFF005AC2),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Find Another Worker (Nearby)',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF005AC2),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Back to Home Text Link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'Cancel & Back to Home',
                      style: GoogleFonts.inter(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
