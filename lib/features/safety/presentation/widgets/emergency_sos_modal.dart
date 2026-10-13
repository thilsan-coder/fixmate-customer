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
      enableDrag: false,
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
    with SingleTickerProviderStateMixin {
  int _countdown = 5;
  Timer? _countdownTimer;
  bool _isTriggered = false;
  bool _showReportDetails = false;
  SosMode _selectedMode = SosMode.loud;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    // If already active, jump straight to active state
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
        _fireEmergency(_selectedMode);
      }
    });
  }

  void _fireEmergency(SosMode mode) {
    _countdownTimer?.cancel();
    setState(() {
      _isTriggered = true;
      _selectedMode = mode;
    });

    EmergencyService.triggerEmergency(
      workerName: widget.workerName,
      workerRole: widget.workerRole,
      workerAvatar: widget.workerAvatar,
      serviceName: widget.serviceName,
      price: widget.price,
      mode: mode,
      autoCall119: mode == SosMode.loud,
    );
  }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    Navigator.of(context).pop();
  }

  void _resolveEmergency() {
    EmergencyService.resolveEmergency();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Emergency Mode Deactivated. Glad you are safe!'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        color: _selectedMode == SosMode.silent && _isTriggered
            ? const Color(0xFF0F172A)
            : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Drag Handle Bar
            const SizedBox(height: 12),
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: _selectedMode == SosMode.silent && _isTriggered
                    ? Colors.white24
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 12),

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
  // VIEW 1: 5-SECOND COUNTDOWN VIEW
  // ==========================================
  Widget _buildCountdownView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Warning Icon with Pulsing Effect
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFEE2E2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withValues(
                        alpha: 0.2 + (_pulseController.value * 0.25),
                      ),
                      blurRadius: 24,
                      spreadRadius: _pulseController.value * 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDC2626),
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

          const SizedBox(height: 18),

          Text(
            'Emergency Assistance Triggering',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'All 3 emergency channels will be alerted automatically in $_countdown seconds.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          // Automatic Actions Preview Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.bolt_rounded,
                        color: Color(0xFFDC2626), size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '3 AUTOMATIC ACTIONS WILL FIRE:',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF991B1B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildAutoActionPreviewRow(
                  icon: Icons.shield_rounded,
                  title: '1. FixMate Safety Desk Dispatched',
                  subtitle: 'Live GPS, worker profile & booking details',
                ),
                const SizedBox(height: 8),
                _buildAutoActionPreviewRow(
                  icon: Icons.local_police_rounded,
                  title: '2. Kollupitiya Police Alerted',
                  subtitle: 'Emergency SMS sent to local station',
                ),
                const SizedBox(height: 8),
                _buildAutoActionPreviewRow(
                  icon: Icons.phone_in_talk_rounded,
                  title: '3. 119 Emergency Hotline Call',
                  subtitle: 'Direct control room line opened instantly',
                ),
                const SizedBox(height: 8),
                _buildAutoActionPreviewRow(
                  icon: Icons.mic_rounded,
                  title: '4. 30-Sec Audio Evidence Recording',
                  subtitle: 'Background microphone records incident sound',
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Primary Button: "Trigger Immediately"
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => _fireEmergency(SosMode.loud),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Trigger Immediately (Loud SOS)',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Secondary Action: "Silent SOS Mode"
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => _fireEmergency(SosMode.silent),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF475569),
                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.volume_off_rounded, size: 18, color: Color(0xFF475569)),
                  const SizedBox(width: 8),
                  Text(
                    '🤫 Trigger as Silent SOS (No Sound)',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Cancel False Alarm Button
          TextButton(
            onPressed: _cancelCountdown,
            child: Text(
              'Cancel (I am Safe - False Alarm)',
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoActionPreviewRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 14, color: const Color(0xFFDC2626)),
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
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // VIEW 2: ACTIVE EMERGENCY HUB
  // ==========================================
  Widget _buildActiveEmergencyView() {
    return ValueListenableBuilder<EmergencyIncident?>(
      valueListenable: EmergencyService.incidentNotifier,
      builder: (context, incident, _) {
        final isSilent = incident?.mode == SosMode.silent;
        final textColor = isSilent ? Colors.white : const Color(0xFF0F172A);
        final subtextColor = isSilent ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TOP STATUS BADGE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDC2626),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) => Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(
                                alpha: 0.5 + (_pulseController.value * 0.5),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'LIVE SOS ACTIVE',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    incident?.incidentId ?? '#SOS-99281',
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: isSilent ? const Color(0xFF38BDF8) : const Color(0xFF005AC2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                isSilent ? '🤫 Silent Emergency Active' : '🚨 Emergency Assistance Triggered',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isSilent
                    ? 'Worker has not been alerted. Help is silently tracking your location.'
                    : 'All 3 safety systems have been notified automatically with your live location.',
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  color: subtextColor,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 14),

              // Mode Switcher (Loud vs Silent)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSilent ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => EmergencyService.switchMode(SosMode.loud),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: !isSilent ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: !isSilent
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              '🔴 Loud SOS Mode',
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: !isSilent ? const Color(0xFFDC2626) : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => EmergencyService.switchMode(SosMode.silent),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSilent ? const Color(0xFF334155) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSilent
                                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              '🤫 Silent Mode (Secret)',
                              style: GoogleFonts.inter(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: isSilent ? Colors.white : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 2. THE 4 AUTOMATIC STATUS CARDS (ALL 3 + AUDIO EVIDENCE)
              _buildLiveStatusCard(
                isSilent: isSilent,
                icon: Icons.shield_rounded,
                iconColor: const Color(0xFF16A34A),
                title: 'FixMate Safety Desk (24/7)',
                subtitle: 'Dispatched with Live GPS & Worker Profile',
                statusText: 'AUTO-SENT',
                statusColor: const Color(0xFF16A34A),
              ),

              const SizedBox(height: 10),

              _buildLiveStatusCard(
                isSilent: isSilent,
                icon: Icons.local_police_rounded,
                iconColor: const Color(0xFF005AC2),
                title: 'Kollupitiya Police Station (1.2 km)',
                subtitle: 'Automated GPS & Incident SMS Sent (011 257 3254)',
                statusText: 'ALERTED',
                statusColor: const Color(0xFF005AC2),
              ),

              const SizedBox(height: 10),

              _buildLiveStatusCard(
                isSilent: isSilent,
                icon: Icons.phone_forwarded_rounded,
                iconColor: const Color(0xFFD97706),
                title: '119 National Police Hotline',
                subtitle: 'Direct Emergency Call line initiated',
                statusText: 'CONNECTED',
                statusColor: const Color(0xFFD97706),
              ),

              const SizedBox(height: 10),

              // Audio Evidence Recording Card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSilent ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: incident?.audioRecordingActive == true
                        ? const Color(0xFFDC2626)
                        : (isSilent ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.mic_rounded, size: 18, color: Color(0xFFDC2626)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Audio Evidence Recording',
                                style: GoogleFonts.inter(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              if (incident?.audioRecordingActive == true)
                                Text(
                                  '(${incident?.audioSecondsRecorded ?? 0}s / 30s)',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFDC2626),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            incident?.audioRecordingActive == true
                                ? 'Recording surrounding voices for legal evidence...'
                                : '30s Audio Saved & Uploaded to Admin file ✅',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: subtextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 3. IMMEDIATE CALL BUTTONS
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: EmergencyService.callPolice119,
                        icon: const Icon(Icons.phone_rounded, size: 16),
                        label: const Text('Call 119'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton.icon(
                        onPressed: EmergencyService.callLocalPoliceStation,
                        icon: const Icon(Icons.local_police_rounded, size: 16),
                        label: const Text('Local Station'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isSilent ? Colors.white : const Color(0xFF005AC2),
                          side: BorderSide(
                            color: isSilent ? Colors.white38 : const Color(0xFF005AC2),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 4. VIEW DISPATCHED REPORT ACCORDION
              InkWell(
                onTap: () {
                  setState(() {
                    _showReportDetails = !_showReportDetails;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSilent ? const Color(0xFF1E293B) : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSilent ? const Color(0xFF334155) : const Color(0xFFBFDBFE),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.description_outlined, size: 16, color: Color(0xFF005AC2)),
                          const SizedBox(width: 8),
                          Text(
                            'View Dispatched Incident Report',
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: isSilent ? const Color(0xFF38BDF8) : const Color(0xFF005AC2),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        _showReportDetails
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xFF005AC2),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              // Dispatched Payload Card (JSON Data View)
              if (_showReportDetails) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSilent ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSilent ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReportRow('Customer:', '${incident?.customerName} (${incident?.customerPhone})', textColor, subtextColor),
                      _buildReportRow('Worker:', '${incident?.workerName} • ${incident?.workerRole}', textColor, subtextColor),
                      _buildReportRow('Location:', incident?.address ?? '24, Galle Road, Colombo 03', textColor, subtextColor),
                      _buildReportRow('GPS Coordinates:', '${incident?.latitude}, ${incident?.longitude}', textColor, subtextColor),
                      _buildReportRow('Booking ID:', incident?.bookingId ?? '#FM-882910', textColor, subtextColor),
                      _buildReportRow('Nearest Station:', incident?.nearestPoliceStation ?? 'Kollupitiya Station', textColor, subtextColor),
                      _buildReportRow('Google Maps Link:', incident?.googleMapsLink ?? 'https://maps.google.com', textColor, subtextColor),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 18),

              // 5. RESOLVE / "I AM SAFE NOW" BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _resolveEmergency,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'I Am Safe Now (Deactivate SOS)',
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLiveStatusCard({
    required bool isSilent,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String statusText,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSilent ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSilent ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
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
                    color: isSilent ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 1.5),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: isSilent ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              statusText,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportRow(String label, String value, Color textColor, Color subtextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: subtextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
