import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'emergency_sos_modal.dart';

enum SosButtonVariant { pill, floating, cardButton }

class SosButton extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final String workerAvatar;
  final String serviceName;
  final String? subServiceName;
  final String price;
  final SosButtonVariant variant;

  const SosButton({
    super.key,
    required this.workerName,
    required this.workerRole,
    required this.workerAvatar,
    required this.serviceName,
    this.subServiceName,
    this.price = 'LKR 2,000',
    this.variant = SosButtonVariant.pill,
  });

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onPressed() {
    EmergencySosModal.show(
      context,
      workerName: widget.workerName,
      workerRole: widget.workerRole,
      workerAvatar: widget.workerAvatar,
      serviceName: widget.serviceName,
      subServiceName: widget.subServiceName,
      price: widget.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant == SosButtonVariant.floating) {
      return AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withValues(
                    alpha: 0.25 + (_pulseController.value * 0.35),
                  ),
                  blurRadius: 14 + (_pulseController.value * 6),
                  spreadRadius: _pulseController.value * 3,
                ),
              ],
            ),
            child: Material(
              color: const Color(0xFFDC2626),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _onPressed,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shield_rounded, color: Colors.white, size: 20),
                      SizedBox(height: 2),
                      Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    if (widget.variant == SosButtonVariant.cardButton) {
      return Material(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shield_rounded, size: 14, color: Color(0xFFDC2626)),
                const SizedBox(width: 4),
                Text(
                  '🚨 SOS Emergency',
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFDC2626),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Default Pill Variant for AppBars
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEF4444).withValues(
                  alpha: 0.15 + (_pulseController.value * 0.25),
                ),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Material(
            color: const Color(0xFFDC2626),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: _onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      'SOS',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
