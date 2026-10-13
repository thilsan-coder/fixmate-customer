import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/services/emergency_service.dart';

class EmergencySosModal extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final String workerAvatar;
  final String serviceName;
  final String? subServiceName;
  final String price;

  const EmergencySosModal({
    super.key,
    required this.workerName,
    required this.workerRole,
    required this.workerAvatar,
    required this.serviceName,
    this.subServiceName,
    this.price = 'LKR 2,000',
  });

  static Future<void> show(
    BuildContext context, {
    required String workerName,
    required String workerRole,
    required String workerAvatar,
    required String serviceName,
    String? subServiceName,
    String price = 'LKR 2,000',
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false, // Prevent accidental dismissal while panic countdown is active
      builder: (context) => EmergencySosModal(
        workerName: workerName,
        workerRole: workerRole,
        workerAvatar: workerAvatar,
        serviceName: serviceName,
        subServiceName: subServiceName,
        price: price,
      ),
    );
  }

  @override
  State<EmergencySosModal> createState() => _EmergencySosModalState();
}

class _EmergencySosModalState extends State<EmergencySosModal>
    with TickerProviderStateMixin {
  int _countdown = 5;
  Timer? _countdownTimer;
  bool _isTriggered = false;

  late AnimationController _pulseController;
  late AnimationController _equalizerController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _equalizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )..repeat(reverse: true);

    if (EmergencyService.hasActiveEmergency) {
      _isTriggered = true;
    } else {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        _fireEmergency();
      }
    });
  }

  void _fireEmergency() {
    _countdownTimer?.cancel();
    setState(() {
      _isTriggered = true;
    });

    // Auto-dispatch all channels: Admin telemetry + 119 Call + Nearest Station + 30s Audio
    EmergencyService.triggerEmergency(
      workerName: widget.workerName,
      workerRole: widget.workerRole,
      workerAvatar: widget.workerAvatar,
      serviceName: widget.serviceName,
      price: widget.price,
      mode: SosMode.loud,
      autoCall119: true,
    );
  }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    Navigator.of(context).pop();
  }

  void _resolveEmergency() {
    _countdownTimer?.cancel();
    EmergencyService.resolveEmergency();
    Navigator.of(context).pop();

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
                'Emergency cleared. You are marked safe.',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pulseController.dispose();
    _equalizerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Drag Handle
            const SizedBox(height: 10),
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),

            // Official Clean Header Strip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDC2626).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.shield_rounded,
                      color: Color(0xFFDC2626),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Emergency Assistance',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Sri Lanka Police 119 & FixMate 24/7 Desk',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _isTriggered ? _resolveEmergency : _cancelCountdown,
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
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Dynamic Body: Countdown OR Active Emergency Hub
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: !_isTriggered
                    ? _buildCountdownView()
                    : _buildActiveEmergencyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // VIEW 1: CLEAN 5-SECOND AUTO-COUNTDOWN VIEW
  // ==========================================
  Widget _buildCountdownView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 6),

          // High-Visibility Animated Countdown Disc
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final val = _pulseController.value;
              return Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFEE2E2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDC2626).withValues(
                        alpha: 0.2 + (val * 0.25),
                      ),
                      blurRadius: 16 + (val * 6),
                      spreadRadius: val * 3,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 74,
                    height: 74,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$_countdown',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 14),

          Text(
            'Auto-Dispatching in $_countdown Seconds',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Police 119, Nearest Station & FixMate Safety Desk will be automatically alerted with your live location unless cancelled.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),

          const SizedBox(height: 14),

          // Incident Dossier Card (Zero Overflows)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: Color(0xFF005AC2),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '24, Galle Road, Kollupitiya, Colombo 03',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'GPS Ready',
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF15803D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Pro: ${widget.workerName} • ${widget.serviceName}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.local_police_outlined,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Station: Kollupitiya Police (1.2 km)',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Primary: Send Now (No 5s wait)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _fireEmergency,
              icon: const Icon(Icons.bolt_rounded, color: Colors.white, size: 19),
              label: Text(
                'Send Alert Now',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Secondary: Cancel (Accidental click protection)
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: _cancelCountdown,
              icon: const Icon(Icons.close_rounded, size: 17, color: Color(0xFF475569)),
              label: Text(
                'Cancel (False Alarm)',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF334155),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Accidental click? Tap Cancel above to abort with zero alerts sent.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  // ==========================================
  // VIEW 2: ACTIVE EMERGENCY HUB (AFTER 5s)
  // ==========================================
  Widget _buildActiveEmergencyView() {
    return ValueListenableBuilder<EmergencyIncident?>(
      valueListenable: EmergencyService.incidentNotifier,
      builder: (context, incident, _) {
        final audioSec = incident?.audioSecondsRecorded ?? 0;
        final isAudioRecording = incident?.audioRecordingActive ?? true;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Red Alert Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFFECACA), width: 1.2),
                ),
                child: Row(
                  children: [
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) => Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDC2626).withValues(
                            alpha: 0.15 + (_pulseController.value * 0.2),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.warning_rounded,
                          color: Color(0xFFDC2626),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Emergency Dispatched',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF991B1B),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                incident?.incidentId ?? '#SOS-99281',
                                style: GoogleFonts.inter(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF005AC2),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Live GPS sent to FixMate HQ & Police 119 network.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: const Color(0xFFB91C1C),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // SECTION: ACTIVE CHANNELS
              Text(
                'ACTIVE RESCUE CHANNELS',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF94A3B8),
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 8),

              // Channel 1: Police 119
              _buildChannelTile(
                icon: Icons.local_police_rounded,
                iconBg: const Color(0xFFFEE2E2),
                iconColor: const Color(0xFFDC2626),
                title: 'Sri Lanka Police 119',
                status: 'Call Connected / Dialing...',
                statusColor: const Color(0xFFDC2626),
                actionLabel: 'Call 119',
                actionBg: const Color(0xFFDC2626),
                actionTextColor: Colors.white,
                onTap: () => EmergencyService.callPolice119(),
              ),

              const SizedBox(height: 8),

              // Channel 2: FixMate Safety Desk
              _buildChannelTile(
                icon: Icons.support_agent_rounded,
                iconBg: const Color(0xFFDBEAFE),
                iconColor: const Color(0xFF005AC2),
                title: 'FixMate Safety Desk (24/7)',
                status: 'Live GPS & Dossier Received',
                statusColor: const Color(0xFF15803D),
                actionLabel: 'Call Desk',
                actionBg: const Color(0xFF005AC2),
                actionTextColor: Colors.white,
                onTap: () => EmergencyService.callSafetyDesk(),
              ),

              const SizedBox(height: 8),

              // Channel 3: Nearest Station
              _buildChannelTile(
                icon: Icons.apartment_rounded,
                iconBg: const Color(0xFFF1F5F9),
                iconColor: const Color(0xFF334155),
                title: 'Kollupitiya Police Station',
                status: '011 257 3254 • 1.2 km away',
                statusColor: const Color(0xFF64748B),
                actionLabel: 'Call',
                actionBg: const Color(0xFFF8FAFC),
                actionBorder: const Color(0xFFCBD5E1),
                actionTextColor: const Color(0xFF0F172A),
                onTap: () => EmergencyService.callNearestPoliceStation(),
              ),

              const SizedBox(height: 8),

              // Channel 4: 30s Audio Recording with Equalizer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isAudioRecording
                        ? const Color(0xFFDC2626)
                        : const Color(0xFFE2E8F0),
                    width: isAudioRecording ? 1.4 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: isAudioRecording
                            ? const Color(0xFFFEE2E2)
                            : const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mic_rounded,
                        size: 17,
                        color: isAudioRecording
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAudioRecording
                                ? 'Recording Audio ($audioSec / 60s)'
                                : '1-Min Audio Evidence Secured',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isAudioRecording
                                  ? const Color(0xFFDC2626)
                                  : const Color(0xFF0F172A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            isAudioRecording
                                ? 'Encrypted evidence sent to safety desk'
                                : '1-min audio saved for police & safety dossier',
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
                    if (isAudioRecording) ...[
                      const SizedBox(width: 6),
                      AnimatedBuilder(
                        animation: _equalizerController,
                        builder: (context, child) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(4, (i) {
                            final h = 6 + (14 * ((i + _equalizerController.value) % 1.0));
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                              width: 3,
                              height: h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDC2626),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // SECTION: TRANSMITTED DOSSIER (WHAT ADMIN & POLICE RECEIVE)
              _buildTransmittedDossierCard(incident),

              const SizedBox(height: 18),

              // Safe Deactivate Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: _resolveEmergency,
                  icon: const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    'I Am Safe Now (Mark Incident Resolved)',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChannelTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String status,
    required Color statusColor,
    required String actionLabel,
    required Color actionBg,
    Color? actionBorder,
    required Color actionTextColor,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18),
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
                const SizedBox(height: 1),
                Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6.5),
                decoration: BoxDecoration(
                  color: actionBg,
                  borderRadius: BorderRadius.circular(16),
                  border: actionBorder != null ? Border.all(color: actionBorder) : null,
                ),
                child: Text(
                  actionLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: actionTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TRANSMITTED DOSSIER (WHAT ADMIN & POLICE SEE)
  // ==========================================
  Widget _buildTransmittedDossierCard(EmergencyIncident? incident) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF005AC2).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.cloud_done_rounded,
                  size: 16,
                  color: Color(0xFF005AC2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TRANSMITTED TO FIXMATE HQ',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF005AC2),
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Live payload securely logged in Admin database',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'SYNCED',
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 9),

          // 1. Live GPS
          _buildDossierRow(
            icon: Icons.location_on_rounded,
            label: 'Live GPS',
            value: '6.9015° N, 79.8529° E (24, Galle Rd, Col 03)',
          ),
          const SizedBox(height: 7),

          // 2. Customer
          _buildDossierRow(
            icon: Icons.person_rounded,
            label: 'Customer',
            value: '${incident?.customerName ?? "Alex"} (+94 77 123 4567 • #CUST-8492)',
          ),
          const SizedBox(height: 7),

          // 3. Reported Pro Under Watch
          _buildDossierRow(
            icon: Icons.engineering_rounded,
            label: 'Reported Pro',
            value: '${widget.workerName} (${widget.workerRole} • +94 71 889 2341)',
          ),
          const SizedBox(height: 7),

          // 4. Booking ID
          _buildDossierRow(
            icon: Icons.receipt_long_rounded,
            label: 'Booking ID',
            value: '${incident?.bookingId ?? "#FM-882910"} • ${widget.serviceName}',
          ),
          const SizedBox(height: 7),

          // 5. Police Dispatch Net
          _buildDossierRow(
            icon: Icons.local_police_rounded,
            label: 'Police Net',
            value: 'Sri Lanka 119 + Kollupitiya Station (1.2 km)',
          ),
          const SizedBox(height: 7),

          // 6. Evidence Audio
          _buildDossierRow(
            icon: Icons.mic_rounded,
            label: 'Audio Log',
            value: '1-min (60s) encrypted audio file linked to FIR dossier',
          ),
        ],
      ),
    );
  }

  Widget _buildDossierRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 13, color: const Color(0xFF64748B)),
        const SizedBox(width: 6),
        SizedBox(
          width: 78,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
