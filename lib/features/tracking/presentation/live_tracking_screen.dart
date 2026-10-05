import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Live Tracking')),
      body: Stack(
        children: [
          // Map Placeholder Simulation
          Container(
            color: const Color(0xFFE5E9EC),
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Simulated road route
                CustomPaint(
                  size: const Size(300, 300),
                  painter: _RoutePainter(),
                ),
                // Worker pin
                Positioned(
                  top: 200,
                  right: 120,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 12, spreadRadius: 4),
                      ],
                    ),
                    child: const Icon(Icons.two_wheeler, color: Colors.white, size: 24),
                  ),
                ),
                // Destination pin
                Positioned(
                  bottom: 260,
                  left: 100,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.error.withOpacity(0.4), blurRadius: 10),
                      ],
                    ),
                    child: const Icon(Icons.location_on, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Worker & ETA card
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(Icons.person, color: AppColors.primary, size: 28),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sunimal Perera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Master Plumber • 4.9 ★', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.chat);
                        },
                        icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: AppColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Estimated Arrival', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('12 Mins (2.4 km)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.paymentMethods);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 42),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Proceed to Pay'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.7, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.4, size.width * 0.3, size.height * 0.8);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
