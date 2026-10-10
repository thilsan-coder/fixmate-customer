import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import 'booking_confirmed_screen.dart';

class FindingWorkersScreen extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final String avatarUrl;
  final String price;
  final String serviceName;
  final String? subServiceName;

  const FindingWorkersScreen({
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
  State<FindingWorkersScreen> createState() => _FindingWorkersScreenState();
}

class _FindingWorkersScreenState extends State<FindingWorkersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  int _foundCount = 0;
  String _statusTitle = 'Scanning for nearby workers...';
  String _statusSubtitle = 'Searching in 3 km radius around Colombo 03';
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Step 1: Detect first 2 workers after 1.1 seconds
    _timers.add(Timer(const Duration(milliseconds: 1100), () {
      if (mounted) {
        setState(() {
          _foundCount = 2;
          _statusTitle = 'Found 2 online workers nearby...';
          _statusSubtitle = 'Connecting to nearby active networks';
        });
      }
    }));

    // Step 2: Detect all 4 workers after 2.2 seconds
    _timers.add(Timer(const Duration(milliseconds: 2200), () {
      if (mounted) {
        setState(() {
          _foundCount = 4;
          _statusTitle = 'Found 4 verified workers nearby!';
          _statusSubtitle = 'Preparing best matches and distance ratings...';
        });
      }
    }));

    // Step 3: Transition to the worker selection screen after 3.4 seconds
    _timers.add(Timer(const Duration(milliseconds: 3400), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookingConfirmedScreen(
              workerName: widget.workerName,
              workerRole: widget.workerRole,
              avatarUrl: widget.avatarUrl,
              price: widget.price,
              serviceName: widget.serviceName,
              subServiceName: widget.subServiceName,
            ),
          ),
        );
      }
    }));
  }

  @override
  void dispose() {
    for (final timer in _timers) {
      timer.cancel();
    }
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
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
        title: Text(
          'FixMate',
          style: GoogleFonts.inter(
            color: AppColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(12),
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
                  _foundCount > 0 ? '$_foundCount Online' : 'Scanning',
                  style: GoogleFonts.inter(
                    fontSize: 12,
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Radar / Map Visualizer Card
              Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral.withValues(alpha: 0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Street Map Grid Background
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _MapGridPainter(),
                        ),
                      ),

                      // Animated Radar Pulsing Rings
                      AnimatedBuilder(
                        animation: _radarController,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(260, 260),
                            painter: _RadarWavesPainter(
                              progress: _radarController.value,
                            ),
                          );
                        },
                      ),

                      // Center User Location Pin
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 16,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_pin_circle_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),

                      // Pin 1 (Detected worker 1 - 0.5km)
                      if (_foundCount >= 1)
                        Positioned(
                          top: 55,
                          right: 65,
                          child: _buildWorkerRadarPin('1', '0.5km', true),
                        ),

                      // Pin 2 (Detected worker 2 - 0.8km)
                      if (_foundCount >= 2)
                        Positioned(
                          bottom: 50,
                          left: 60,
                          child: _buildWorkerRadarPin('2', '0.8km', false),
                        ),

                      // Pin 3 (Detected worker 3 - 1.2km)
                      if (_foundCount >= 3)
                        Positioned(
                          top: 70,
                          left: 45,
                          child: _buildWorkerRadarPin('3', '1.2km', false),
                        ),

                      // Pin 4 (Detected worker 4 - 1.8km)
                      if (_foundCount >= 4)
                        Positioned(
                          bottom: 60,
                          right: 50,
                          child: _buildWorkerRadarPin('4', '1.8km', false),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Live Counter Badge
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: _foundCount > 0 ? const Color(0xFFEFF6FF) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _foundCount > 0 ? const Color(0xFF93C5FD) : const Color(0xFFCBD5E1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _foundCount > 0 ? Icons.check_circle_rounded : Icons.radar_rounded,
                      size: 16,
                      color: _foundCount > 0 ? const Color(0xFF005AC2) : const Color(0xFF64748B),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      _foundCount > 0
                          ? '$_foundCount Workers Online in 3 km Radius'
                          : 'Searching for nearby workers...',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _foundCount > 0 ? const Color(0xFF005AC2) : const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 2. Main Status Text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  key: ValueKey(_statusTitle),
                  children: [
                    Text(
                      _statusTitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _statusSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 3. Service Request Summary Card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.6),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutral.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFBACFFB),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.handyman_rounded,
                        color: Color(0xFF1E3A8A),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REQUESTED SERVICE',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${widget.serviceName} Service',
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'EST. ${widget.price}',
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 4. Bottom Metrics Cards Row
              Row(
                children: [
                  // Radius Metric Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FB),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.borderLight.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.primary,
                            size: 22,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'SEARCH RADIUS',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '3.0 km',
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Found Workers Metric Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FB),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.borderLight.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.people_alt_outlined,
                            color: Color(0xFF16A34A),
                            size: 22,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'WORKERS ONLINE',
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _foundCount > 0 ? '$_foundCount Active' : 'Scanning...',
                            style: GoogleFonts.inter(
                              color: _foundCount > 0 ? const Color(0xFF16A34A) : AppColors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkerRadarPin(String number, String dist, bool isBest) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: isBest ? const Color(0xFF16A34A) : const Color(0xFF005AC2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isBest ? const Color(0xFF16A34A) : const Color(0xFF005AC2)).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.handyman_rounded, color: Colors.white, size: 11),
          const SizedBox(width: 3),
          Text(
            dist,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter to draw light grayscale map street lines texture
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE5E9EE);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final mainRoadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    for (double x = 20; x < size.width; x += 26) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), roadPaint);
    }
    for (double y = 20; y < size.height; y += 26) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), roadPaint);
    }

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), mainRoadPaint);
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), mainRoadPaint);

    final diagPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, size.height * 0.2), Offset(size.width * 0.8, 0), diagPaint);
    canvas.drawLine(Offset(size.width * 0.2, size.height), Offset(size.width, size.height * 0.3), diagPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for the animated pulsing radar circles
class _RadarWavesPainter extends CustomPainter {
  final double progress;

  _RadarWavesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) * 0.52;

    for (int i = 0; i < 3; i++) {
      final waveProgress = (progress + (i / 3.0)) % 1.0;
      final radius = 24.0 + waveProgress * (maxRadius - 24.0);
      final opacity = (1.0 - waveProgress) * 0.35;

      final fillPaint = Paint()
        ..color = const Color(0xFF0052CC).withValues(alpha: opacity * 0.2)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, fillPaint);

      final strokePaint = Paint()
        ..color = const Color(0xFF0052CC).withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(center, radius, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RadarWavesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
