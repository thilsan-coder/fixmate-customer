import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../chat/presentation/chat_screen.dart';
import '../../booking/presentation/job_progress_screen.dart';

class LiveTrackingScreen extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final double rating;
  final int reviewsCount;
  final String avatarUrl;
  final String price;
  final String serviceName;
  final String? subServiceName;

  const LiveTrackingScreen({
    super.key,
    this.workerName = 'Nimal Perera',
    this.workerRole = 'Plumber',
    this.rating = 4.8,
    this.reviewsCount = 120,
    this.avatarUrl =
        'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&auto=format&fit=crop&q=80',
    this.price = 'LKR 2,000',
    this.serviceName = 'Plumbing',
    this.subServiceName,
  });

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  // Current Step: 0 = On the Way, 1 = Worker Reached, 2 = Work in Progress, 3 = Work Completed
  int _currentStep = 0;
  int _etaMinutes = 5;
  double _distanceKm = 0.8;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startLiveSimulation();
  }

  void _startLiveSimulation() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 12), (timer) {
      if (!mounted) return;
      if (_currentStep == 0) {
        setState(() {
          if (_etaMinutes > 1) {
            _etaMinutes--;
            _distanceKm = (_distanceKm - 0.15).clamp(0.1, 2.0);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _advanceToNextStep() {
    if (_currentStep == 0) {
      setState(() {
        _currentStep = 1;
        _etaMinutes = 0;
        _distanceKm = 0.0;
      });
    } else if (_currentStep == 1 || _currentStep == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => JobProgressScreen(
            workerName: widget.workerName,
            workerRole: widget.workerRole,
            avatarUrl: widget.avatarUrl,
            rating: widget.rating,
            reviewsCount: widget.reviewsCount,
            price: widget.price,
            serviceName: widget.serviceName,
            subServiceName: widget.subServiceName,
          ),
        ),
      );
    }
  }

  void _callWorker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.phone_in_talk_rounded, color: Color(0xFF005AC2), size: 32),
              ),
              const SizedBox(height: 14),
              Text(
                'Calling ${widget.workerName}...',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '+94 77 123 4567 • Connected via FixMate Secure VoIP',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('End Call', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        centerTitle: false,
        title: Text(
          'Live Tracking',
          style: GoogleFonts.inter(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFBFDBFE)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'GPS LIVE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF005AC2),
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
            // 1. Live Interactive Map View
            Expanded(
              child: Stack(
                children: [
                  // Map Background & Polyline Route Painter
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _LiveRouteMapPainter(step: _currentStep),
                    ),
                  ),

                  // Destination Pin: "Your Home"
                  Positioned(
                    top: 100,
                    right: 110,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: const Color(0xFF005AC2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Your Home',
                            style: TextStyle(
                              color: Color(0xFF005AC2),
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Worker Marker & Live ETA Speech Bubble
                  Positioned(
                    top: _currentStep == 0 ? 150 : 100,
                    left: _currentStep == 0 ? 30 : 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Tooltip Speech Bubble (ETA / Status)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _currentStep == 0
                                    ? '$_etaMinutes mins'
                                    : _currentStep == 1
                                        ? 'Reached'
                                        : 'Working',
                                style: TextStyle(
                                  color: _currentStep == 0
                                      ? const Color(0xFF005AC2)
                                      : const Color(0xFF16A34A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                _currentStep == 0
                                    ? '${_distanceKm.toStringAsFixed(1)} km away'
                                    : 'At Doorstep',
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Pointer triangle
                        CustomPaint(
                          size: const Size(12, 6),
                          painter: _TrianglePointerPainter(),
                        ),
                        const SizedBox(height: 3),

                        // Worker Avatar Marker with Bike Badge
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.18),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  widget.avatarUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.person, color: Color(0xFF005AC2), size: 28),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF005AC2),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                                child: const Icon(
                                  Icons.two_wheeler_rounded,
                                  color: Colors.white,
                                  size: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Floating Info Strip: Transport details & Delay/Traffic Status
                  Positioned(
                    top: 14,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.delivery_dining_rounded, color: Color(0xFF005AC2), size: 22),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Red Honda Activa • WP-AB 4920',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Low traffic • On time • No delays expected',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF16A34A),
                                    fontWeight: FontWeight.w600,
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
                            child: Text(
                              _currentStep == 0 ? '5 MINS' : 'REACHED',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005AC2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Interactive 4-Step Progress Status Indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: const Color(0xFFF8FAFC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SERVICE TIMELINE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF64748B),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        _currentStep == 0
                            ? 'Step 1 of 3: On the Way'
                            : _currentStep == 1
                                ? 'Step 2 of 3: Arrived'
                                : 'Step 3 of 3: In Progress',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005AC2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildStepPill(0, 'On Way', Icons.directions_bike_rounded),
                      _buildStepConnector(0),
                      _buildStepPill(1, 'Reached', Icons.location_on_rounded),
                      _buildStepConnector(1),
                      _buildStepPill(2, 'Working', Icons.build_circle_rounded),
                    ],
                  ),
                ],
              ),
            ),

            // 3. Worker Details & Contact Controls (Bottom Overlay)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Worker Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 50,
                          height: 50,
                          color: const Color(0xFFEFF6FF),
                          child: Image.network(
                            widget.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, color: Color(0xFF005AC2), size: 26),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Worker Name & Role
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.workerName,
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.workerRole} • ⭐ ${widget.rating} (${widget.reviewsCount})',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Message Worker Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                workerName: widget.workerName,
                                workerRole: widget.workerRole,
                                avatarUrl: widget.avatarUrl,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Color(0xFF005AC2),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Call Worker Button
                      GestureDetector(
                        onTap: _callWorker,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFF005AC2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.phone_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Next Step Action Button (e.g. Worker Reached -> Start Work -> Complete Work)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _advanceToNextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentStep == 2
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF005AC2),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _currentStep == 0
                                ? Icons.location_on_rounded
                                : _currentStep == 1
                                    ? Icons.play_arrow_rounded
                                    : Icons.check_circle_rounded,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _currentStep == 0
                                ? 'Worker Reached / Arrived'
                                : _currentStep == 1
                                    ? 'Start Work'
                                    : 'Work Completed & Write Review',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
  }

  Widget _buildStepPill(int stepIndex, String title, IconData icon) {
    final isDone = _currentStep > stepIndex;
    final isCurrent = _currentStep == stepIndex;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isCurrent
              ? const Color(0xFFEFF6FF)
              : isDone
                  ? const Color(0xFFDCFCE7)
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isCurrent
                ? const Color(0xFF005AC2)
                : isDone
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFE2E8F0),
            width: isCurrent ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDone ? Icons.check_circle_rounded : icon,
              size: 14,
              color: isCurrent
                  ? const Color(0xFF005AC2)
                  : isDone
                      ? const Color(0xFF16A34A)
                      : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isCurrent || isDone ? FontWeight.bold : FontWeight.w500,
                color: isCurrent
                    ? const Color(0xFF005AC2)
                    : isDone
                        ? const Color(0xFF16A34A)
                        : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepConnector(int stepIndex) {
    final isPassed = _currentStep > stepIndex;
    return Container(
      width: 14,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: isPassed ? const Color(0xFF16A34A) : const Color(0xFFCBD5E1),
    );
  }
}

/// Painter for the speech bubble triangle pointer
class _TrianglePointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for the realistic map background and blue navigation polyline
class _LiveRouteMapPainter extends CustomPainter {
  final int step;

  _LiveRouteMapPainter({this.step = 0});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Street map background
    final bgPaint = Paint()..color = const Color(0xFFF1EFE9);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final minorRoad = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke;

    final majorRoad = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    // Grid streets
    for (double i = 30; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i + 20, size.height), minorRoad);
    }
    for (double i = 20; i < size.height; i += 45) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i - 15), minorRoad);
    }

    // Arteries
    canvas.drawLine(Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.5), majorRoad);
    canvas.drawLine(Offset(size.width * 0.4, 0),
        Offset(size.width * 0.6, size.height), majorRoad);
    canvas.drawLine(Offset(0, size.height * 0.7),
        Offset(size.width * 0.8, 0), majorRoad);

    // 2. Thick Navigation Polyline Route
    final routePaint = Paint()
      ..color = step > 0 ? const Color(0xFF16A34A) : const Color(0xFF005AC2)
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = (step > 0 ? const Color(0xFF16A34A) : const Color(0xFF005AC2))
          .withValues(alpha: 0.25)
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final routePath = Path();
    final p0 = Offset(size.width * 0.18, size.height * 0.50);
    final p1 = Offset(size.width * 0.45, size.height * 0.52);
    final p2 = Offset(size.width * 0.55, size.height * 0.54);
    final p3 = Offset(size.width * 0.74, size.height * 0.22);

    routePath.moveTo(p0.dx, p0.dy);
    routePath.lineTo(p1.dx, p1.dy);
    routePath.lineTo(p2.dx, p2.dy);
    routePath.lineTo(p3.dx, p3.dy);

    canvas.drawPath(routePath, glowPaint);
    canvas.drawPath(routePath, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
