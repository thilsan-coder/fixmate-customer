import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/booking_service.dart';
import '../../payment/presentation/invoice_screen.dart';

class JobCompletedScreen extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final String avatarUrl;
  final String price;
  final String serviceName;
  final String? subServiceName;

  const JobCompletedScreen({
    super.key,
    this.workerName = 'Nimal Perera',
    this.workerRole = 'Plumber',
    this.avatarUrl =
        'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
    this.price = 'LKR 2,000',
    this.serviceName = 'Plumbing',
    this.subServiceName,
  });

  @override
  State<JobCompletedScreen> createState() => _JobCompletedScreenState();
}

class _JobCompletedScreenState extends State<JobCompletedScreen> {
  int _selectedRating = 5; // Default 5 stars
  final TextEditingController _feedbackController = TextEditingController(
    text: 'Excellent and very professional work! Arrived on time and solved the issue cleanly.',
  );
  final Set<String> _selectedTags = {'On Time ⏱️', 'Clean Work 🧹', 'Expert Service 🛠️'};

  final List<String> _quickTags = [
    'On Time ⏱️',
    'Clean Work 🧹',
    'Expert Service 🛠️',
    'Fair Price 💰',
    'Polite & Friendly 😊',
    'Safety Verified 🛡️',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitReview() {
    // 1. Store completed booking in BookingService
    BookingService.completeBooking(
      workerName: widget.workerName,
      workerRole: widget.workerRole,
      avatarUrl: widget.avatarUrl,
      price: widget.price,
      serviceName: widget.subServiceName ?? widget.serviceName,
      rating: _selectedRating.toDouble(),
      reviewNote: _feedbackController.text.trim(),
      tags: _selectedTags.toList(),
    );

    // 2. Show Celebration Pop-up
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Celebration Badge
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF86EFAC), width: 2),
                ),
                child: const Center(
                  child: Icon(
                    Icons.verified_rounded,
                    color: Color(0xFF16A34A),
                    size: 46,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              Text(
                'Job Successfully Completed! 🎉',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Thank you! Your $_selectedRating-Star verified review and feedback have been published for ${widget.workerName}.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Completed Job Mini Summary Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Professional',
                          style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                        ),
                        Text(
                          widget.workerName,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Amount Paid',
                          style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                        ),
                        Text(
                          widget.price,
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Rating',
                          style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                        ),
                        Row(
                          children: List.generate(
                            _selectedRating,
                            (index) => const Icon(Icons.star_rounded, color: Color(0xFFD97706), size: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Primary Action: Return to Home
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005AC2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Return to Home',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Secondary Action: View in My Bookings
              SizedBox(
                width: double.infinity,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.bookingsList,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'View in My Bookings',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF005AC2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
            color: AppColors.textPrimary,
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
          'Job Completed',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Worker Profile Summary Card
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
                    // Worker Avatar with Checkmark
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 60,
                            height: 60,
                            color: const Color(0xFFEFF6FF),
                            child: Image.network(
                              widget.avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, color: Color(0xFF005AC2), size: 30),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF16A34A),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.check, size: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // Worker Name & Finished Status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.workerName,
                                  style: const TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF005AC2)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.workerRole,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Amount Paid / Agreed Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF166534),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 2. Main Heading & Subtitle
              const Text(
                'How was your experience?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Rate your service experience with this professional',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 18),

              // 3. Interactive Star Rating Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starNumber = index + 1;
                  final isSelected = starNumber <= _selectedRating;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = starNumber;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        isSelected ? Icons.star_rounded : Icons.star_border_rounded,
                        color: const Color(0xFFF59E0B),
                        size: 44,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 18),

              // 4. Quick Feedback Compliment Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: _quickTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? const Color(0xFF005AC2) : const Color(0xFF475569),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFFEFF6FF),
                    checkmarkColor: const Color(0xFF005AC2),
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // 5. Multi-line Feedback Box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  controller: _feedbackController,
                  minLines: 3,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF0F172A),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Share more details about the service...',
                    hintStyle: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 13.5,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 6. Action Buttons
              // Primary Button: Submit Review
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005AC2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Secondary Button: View Invoice
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InvoiceScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFCBD5E1),
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'View Service Invoice',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF334155),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
