import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/booking_service.dart';
import '../../chat/presentation/chat_screen.dart';
import '../../payment/presentation/invoice_screen.dart';
import '../../tracking/presentation/live_tracking_screen.dart';
import 'job_progress_screen.dart';
import 'confirm_booking_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  final BookingItem? booking;

  const BookingDetailsScreen({
    super.key,
    this.booking,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late BookingItem _item;

  @override
  void initState() {
    super.initState();
    _item = widget.booking ??
        const BookingItem(
          id: 'BK-1003',
          title: 'Light & Fan Installation',
          time: 'Today, 10:00 AM',
          date: '25 May 2024',
          address: '24, Galle Road, Colombo 03',
          workerName: 'Sarah Jenkins',
          workerRole: 'Certified Electrician',
          workerAvatarUrl:
              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&fit=crop&q=80',
          serviceIcon: Icons.electrical_services_rounded,
          price: 'LKR 1,800',
          laborCharge: 'LKR 1,600',
          platformFee: 'LKR 200',
          materialsCost: 'LKR 0',
          status: BookingStatus.completed,
          statusText: 'COMPLETED',
          rating: 5.0,
          reviewNote: 'Outstanding service and very polite! Solved the problem quickly.',
          tags: ['On Time ⏱️', 'Clean Work 🧹', 'Expert Service 🛠️'],
        );
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
                'Calling ${_item.workerName}...',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '+94 77 123 4567 • Connected via FixMate VoIP',
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
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0F172A),
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
          'Booking Details',
          style: GoogleFonts.inter(
            color: const Color(0xFF0F172A),
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
              color: _item.status == BookingStatus.completed
                  ? const Color(0xFFDCFCE7)
                  : _item.status == BookingStatus.inProgress
                      ? const Color(0xFFEFF6FF)
                      : const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _item.status == BookingStatus.completed
                    ? const Color(0xFF86EFAC)
                    : _item.status == BookingStatus.inProgress
                        ? const Color(0xFFBFDBFE)
                        : const Color(0xFFFDE68A),
              ),
            ),
            child: Text(
              _item.statusText,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: _item.status == BookingStatus.completed
                    ? const Color(0xFF166534)
                    : _item.status == BookingStatus.inProgress
                        ? const Color(0xFF005AC2)
                        : const Color(0xFF92400E),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Assigned Worker Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.035),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 58,
                        height: 58,
                        color: const Color(0xFFEFF6FF),
                        child: Image.network(
                          _item.workerAvatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, color: Color(0xFF005AC2), size: 30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  _item.workerName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified_rounded, color: Color(0xFF005AC2), size: 16),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _item.workerRole,
                            style: const TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone_rounded, color: Color(0xFF005AC2)),
                      onPressed: _callWorker,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF005AC2)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              workerName: _item.workerName,
                              workerRole: _item.workerRole,
                              avatarUrl: _item.workerAvatarUrl,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 2. Service & Location Details Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(_item.serviceIcon, color: const Color(0xFF005AC2), size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SERVICE BOOKED',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                _item.title.replaceAll('\n', ' '),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ),
                    // Address Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined, color: Color(0xFF64748B), size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _item.address,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF334155), fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Time Row
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, color: Color(0xFF64748B), size: 18),
                        const SizedBox(width: 10),
                        Text(
                          '${_item.date} • ${_item.time.replaceAll('\n', ' ')}',
                          style: const TextStyle(fontSize: 13, color: Color(0xFF334155), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 3. User Review / Completed Feedback Card (If completed)
              if (_item.status == BookingStatus.completed) ...[
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Review & Rating',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              _item.rating.toInt(),
                              (index) => const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                            ),
                          ),
                        ],
                      ),
                      if (_item.reviewNote != null && _item.reviewNote!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          '"${_item.reviewNote}"',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF475569),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      if (_item.tags.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _item.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF005AC2)),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],

              // 4. Payment & Billing Breakdown Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Summary',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Labor Fee', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                        Text(_item.laborCharge, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Platform Fee', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                        Text(_item.platformFee, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Amount', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                        Text(
                          _item.price,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF005AC2)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _item.paymentMethod.contains('Complete')
                            ? const Color(0xFFF0FDF4)
                            : const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _item.paymentMethod.contains('Complete')
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFDBEAFE),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _item.paymentMethod.contains('Complete')
                                ? Icons.verified_user_rounded
                                : Icons.credit_card_rounded,
                            size: 16,
                            color: _item.paymentMethod.contains('Complete')
                                ? const Color(0xFF16A34A)
                                : const Color(0xFF005AC2),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Payment: ${_item.paymentMethod}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _item.paymentMethod.contains('Complete')
                                  ? const Color(0xFF15803D)
                                  : const Color(0xFF005AC2),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _item.paymentMethod.contains('Complete')
                                ? 'Due after service'
                                : 'Prepaid',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: _item.paymentMethod.contains('Complete')
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF005AC2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 5. Action Buttons based on status
              if (_item.status == BookingStatus.completed) ...[
                // View Invoice Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvoiceScreen(
                            invoiceId: _item.id,
                            serviceName: _item.title.replaceAll('\n', ' '),
                            workerName: _item.workerName,
                            workerRole: _item.workerRole,
                            avatarUrl: _item.workerAvatarUrl,
                            price: _item.price,
                            laborCharge: _item.laborCharge,
                            platformFee: _item.platformFee,
                            materialsCost: _item.materialsCost,
                            date: _item.date,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.receipt_rounded, size: 20, color: Colors.white),
                    label: const Text(
                      'View Service Invoice & Receipt',
                      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005AC2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Rebook Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmBookingScreen(
                            workerName: _item.workerName,
                            workerRole: _item.workerRole,
                            avatarUrl: _item.workerAvatarUrl,
                            price: _item.price,
                            serviceName: _item.title,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF005AC2), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text(
                      'Book This Professional Again',
                      style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF005AC2)),
                    ),
                  ),
                ),
              ] else if (_item.status == BookingStatus.inProgress) ...[
                // Continue / Track Service
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobProgressScreen(
                            workerName: _item.workerName,
                            workerRole: _item.workerRole,
                            avatarUrl: _item.workerAvatarUrl,
                            price: _item.price,
                            serviceName: _item.title,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_circle_fill_rounded, size: 22, color: Colors.white),
                    label: const Text(
                      'Continue / Track Active Service',
                      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF16A34A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ] else ...[
                // Scheduled: Start Tracking or Re-schedule
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveTrackingScreen(
                            workerName: _item.workerName,
                            workerRole: _item.workerRole,
                            avatarUrl: _item.workerAvatarUrl,
                            price: _item.price,
                            serviceName: _item.title,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.navigation_rounded, size: 20, color: Colors.white),
                    label: const Text(
                      'Start Live Tracking',
                      style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005AC2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
