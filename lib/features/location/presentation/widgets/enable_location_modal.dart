import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/location_service.dart';

class EnableLocationModal extends StatefulWidget {
  final VoidCallback? onLocationEnabled;
  final VoidCallback? onManualCitySelected;

  const EnableLocationModal({
    super.key,
    this.onLocationEnabled,
    this.onManualCitySelected,
  });

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onLocationEnabled,
    VoidCallback? onManualCitySelected,
  }) {
    LocationService.markPrompted();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EnableLocationModal(
        onLocationEnabled: onLocationEnabled,
        onManualCitySelected: onManualCitySelected,
      ),
    );
  }

  @override
  State<EnableLocationModal> createState() => _EnableLocationModalState();
}

class _EnableLocationModalState extends State<EnableLocationModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _radarController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  Future<void> _handleEnableGps() async {
    setState(() => _isLoading = true);
    final success = await LocationService.requestGpsAndPermission();
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pop();

    if (success) {
      widget.onLocationEnabled?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF16A34A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              const Icon(Icons.my_location_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'GPS Location enabled! Showing nearby pros.',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _handleManualCity() {
    Navigator.of(context).pop();
    widget.onManualCitySelected?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 8),

              // Top Close Button Row
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ),

              // Animated Radar Location Pin
              AnimatedBuilder(
                animation: _radarController,
                builder: (context, child) {
                  final val = _radarController.value;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Pulse Ring
                      Container(
                        width: 90 + (val * 35),
                        height: 90 + (val * 35),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF005AC2).withValues(
                            alpha: (1.0 - val) * 0.15,
                          ),
                        ),
                      ),
                      // Inner Pulse Ring
                      Container(
                        width: 70 + (val * 20),
                        height: 70 + (val * 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF005AC2).withValues(
                            alpha: (1.0 - val) * 0.25,
                          ),
                        ),
                      ),
                      // Center Pin Circle
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF2563EB), Color(0xFF005AC2)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF005AC2).withValues(alpha: 0.35),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 18),

              // Title
              Text(
                'Turn On Device Location',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 6),

              // Subtitle
              Text(
                'FixMate uses your GPS location to match you with nearby verified pros and provide accurate emergency safety dispatch.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  color: const Color(0xFF64748B),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 16),

              // Benefit 1: Nearby Pros
              _buildBenefitRow(
                icon: Icons.electric_bolt_rounded,
                iconColor: const Color(0xFF2563EB),
                iconBg: const Color(0xFFEFF6FF),
                title: 'Find Closest Pros (Within 2 km)',
                subtitle: 'Get faster arrival times and accurate local pricing.',
              ),

              const SizedBox(height: 8),

              // Benefit 2: Emergency Tracking
              _buildBenefitRow(
                icon: Icons.shield_rounded,
                iconColor: const Color(0xFFDC2626),
                iconBg: const Color(0xFFFEF2F2),
                title: 'Live 119 Emergency SOS Dispatch',
                subtitle: 'Automatic GPS coordinates transmission during threats.',
              ),

              const SizedBox(height: 20),

              // Primary Action: Enable GPS
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _handleEnableGps,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.my_location_rounded, size: 18),
                  label: Text(
                    _isLoading ? 'Checking GPS...' : 'Enable Location & GPS',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005AC2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Secondary Action: Enter City Manually
              SizedBox(
                width: double.infinity,
                height: 46,
                child: TextButton.icon(
                  onPressed: _handleManualCity,
                  icon: const Icon(
                    Icons.location_city_rounded,
                    size: 17,
                    color: Color(0xFF64748B),
                  ),
                  label: Text(
                    'Select City Manually',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 17),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
