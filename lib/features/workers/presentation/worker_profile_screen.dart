import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../booking/presentation/confirm_booking_screen.dart';
import '../../chat/presentation/chat_screen.dart';

class WorkerProfileScreen extends StatefulWidget {
  final String name;
  final String role;
  final String distance;
  final double rating;
  final int reviewsCount;
  final String avatarUrl;
  final String price;
  final String serviceName;
  final String? subServiceName;

  const WorkerProfileScreen({
    super.key,
    this.name = 'Nuwan Silva',
    this.role = 'Master Electrician',
    this.distance = '0.4 km away',
    this.rating = 4.9,
    this.reviewsCount = 156,
    this.avatarUrl = 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
    this.price = 'LKR 2,000',
    this.serviceName = 'Electrician',
    this.subServiceName,
  });

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  bool _isFavorite = false;
  late String _currentPrice;

  @override
  void initState() {
    super.initState();
    _currentPrice = widget.price;
  }

  void _showNegotiatePriceDialog() {
    final controller = TextEditingController(
      text: _currentPrice.replaceAll(RegExp(r'[^0-9]'), ''),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.edit_note_rounded,
                        color: Color(0xFF005AC2),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Negotiated Booking Amount',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Enter the amount agreed with worker in chat',
                            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF005AC2), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'LKR ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005AC2),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'e.g. 2500',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final input = controller.text.trim();
                          if (input.isNotEmpty) {
                            setState(() {
                              _currentPrice = 'LKR $input';
                            });
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF005AC2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Update Price', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
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
                'Call ${widget.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '+94 77 123 4567 • Free Direct Call via FixMate',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF16A34A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Call Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _getCategoryCoverPhoto() {
    final role = widget.role.toLowerCase();
    final service = widget.serviceName.toLowerCase();

    if (role.contains('electr') || service.contains('electr')) {
      return 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=800&fit=crop&q=80';
    } else if (role.contains('paint') || service.contains('paint')) {
      return 'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=800&fit=crop&q=80';
    } else if (role.contains('carpent') || service.contains('carpent')) {
      return 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800&fit=crop&q=80';
    } else if (role.contains('ac') || service.contains('ac') || service.contains('air')) {
      return 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=800&fit=crop&q=80';
    } else if (role.contains('clean') || service.contains('clean')) {
      return 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800&fit=crop&q=80';
    }
    return 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=800&fit=crop&q=80';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // 1. Main Scrollable View
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1.1 Header & Cover Image with Action Icons
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: const BoxDecoration(
                        color: Color(0xFF003E8A),
                      ),
                      child: Image.network(
                        _getCategoryCoverPhoto(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFF005AC2),
                        ),
                      ),
                    ),
                    // Gradient Scrim for crisp contrast
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.5),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Top App Bar Icons
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Worker profile link copied to clipboard!'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.share_outlined, color: Colors.white, size: 19),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                        color: _isFavorite ? const Color(0xFFEF4444) : Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // 1.2 Main Profile Card (No overlapping clip issues)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Worker Avatar with online badge
                            Stack(
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFFEFF6FF),
                                    border: Border.all(color: const Color(0xFFBFDBFE), width: 2),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      widget.avatarUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.person, color: Color(0xFF005AC2), size: 38),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -2,
                                  right: -2,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 14),

                            // Name, Role & Location
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          widget.name,
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF0F172A),
                                            letterSpacing: -0.3,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.verified_rounded, color: Color(0xFF005AC2), size: 18),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    widget.role,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      color: Color(0xFF64748B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF005AC2)),
                                      const SizedBox(width: 3),
                                      Text(
                                        widget.distance,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF005AC2),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0FDF4),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Text(
                                          'Available Now',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF16A34A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        const SizedBox(height: 14),

                        // Key Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('Rating', '${widget.rating} ★', const Color(0xFFD97706)),
                            Container(width: 1, height: 26, color: const Color(0xFFE2E8F0)),
                            _buildStatItem('Jobs Done', '${widget.reviewsCount}+', const Color(0xFF005AC2)),
                            Container(width: 1, height: 26, color: const Color(0xFFE2E8F0)),
                            _buildStatItem('Experience', '5+ Yrs', const Color(0xFF0F172A)),
                            Container(width: 1, height: 26, color: const Color(0xFFE2E8F0)),
                            _buildStatItem('On-Time', '99%', const Color(0xFF10B981)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 1.3 Quality Guarantee Trust Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFBBF7D0)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.verified_user_rounded, color: Color(0xFF16A34A), size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'FixMate Verified & 30-Day Guarantee',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF166534),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Govt ID verified pro • Free re-service if not 100% satisfied.',
                                style: TextStyle(fontSize: 11.5, color: Color(0xFF15803D)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 1.4 Specialties & Skills List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Specialties & Services',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _getDynamicSpecialties().map((service) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF005AC2)),
                                const SizedBox(width: 6),
                                Text(
                                  service,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 1.5 Verified Customer Reviews
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Customer Reviews',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 14, color: Color(0xFFD97706)),
                                const SizedBox(width: 3),
                                Text(
                                  '${widget.rating} (${widget.reviewsCount})',
                                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF92400E)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildReviewItem(
                        name: 'Kusal Mendis',
                        time: 'Yesterday',
                        rating: 5.0,
                        comment: 'Arrived within 20 mins! Solved the main tripping circuit cleanly and explained the problem clearly.',
                      ),
                      const SizedBox(height: 10),
                      _buildReviewItem(
                        name: 'Sithara Perera',
                        time: '4 days ago',
                        rating: 5.0,
                        comment: 'Very polite behavior and neat work. Cleaned up all dust after finishing. Price was very fair.',
                      ),
                      const SizedBox(height: 10),
                      _buildReviewItem(
                        name: 'Mohamed Fazil',
                        time: '1 week ago',
                        rating: 4.8,
                        comment: 'Great craftsmanship and high attention to safety. Definitely calling him for future jobs.',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Spacing for bottom bar
              ],
            ),
          ),

          // 2. Fixed Bottom Action Bar (Price Tag + Chat + Call + Book Now)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    // Negotiate Price Box
                    InkWell(
                      onTap: _showNegotiatePriceDialog,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _currentPrice != widget.price ? 'Agreed' : 'Estimated',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: _currentPrice != widget.price ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
                                    fontWeight: _currentPrice != widget.price ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(Icons.edit_rounded, size: 12, color: Color(0xFF005AC2)),
                              ],
                            ),
                            Text(
                              _currentPrice,
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005AC2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Chat Button
                    Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF005AC2), size: 20),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                workerName: widget.name,
                                workerRole: widget.role,
                                avatarUrl: widget.avatarUrl,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Call Button
                    Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFBBF7D0)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.phone_rounded, color: Color(0xFF16A34A), size: 20),
                        onPressed: _callWorker,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Book Now Primary Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmBookingScreen(
                                  workerName: widget.name,
                                  workerRole: widget.role,
                                  distance: widget.distance,
                                  rating: widget.rating,
                                  reviewsCount: widget.reviewsCount,
                                  avatarUrl: widget.avatarUrl,
                                  price: _currentPrice,
                                  serviceName: widget.serviceName,
                                  subServiceName: widget.subServiceName,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF005AC2),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Book Now',
                                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_rounded, size: 15, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getDynamicSpecialties() {
    final role = widget.role.toLowerCase();
    final service = widget.serviceName.toLowerCase();

    if (role.contains('electr') || service.contains('electr')) {
      return ['Ceiling Fan Setup', 'Switchboard Repair', 'MCB Breaker Box', 'House Wiring', 'Chandelier Lighting'];
    } else if (role.contains('paint') || service.contains('paint')) {
      return ['Interior Wall Coat', 'Wall Putty Leveling', 'Damp-Proof Seal', 'Wood Polish', 'Exterior Weathercoat'];
    } else if (role.contains('carpent') || service.contains('carpent')) {
      return ['Door Locks & Handles', 'Furniture Assembly', 'Kitchen Cabinets', 'Floating Shelves', 'Hinges Repair'];
    } else if (role.contains('ac') || service.contains('ac') || service.contains('air')) {
      return ['Deep Foam Jet Wash', 'Gas Recharge R32', 'Inverter PCB Fix', 'Copper Piping', 'AC Relocation'];
    } else if (role.contains('mason') || service.contains('mason')) {
      return ['Tile Replacement', 'Wall Crack Bonding', 'Bathroom Slope Fix', 'Plastering', 'Cement Skirting'];
    } else if (role.contains('weld') || service.contains('weld')) {
      return ['Main Gate Hinges', 'Steel Railings SS304', 'Window Grills', 'Metal Truss', 'Arc Welding'];
    } else if (role.contains('clean') || service.contains('clean')) {
      return ['Bathroom Descaling', 'Sofa Shampooing', 'Kitchen Degreasing', 'Floor Sanitization', 'Window Glass Polish'];
    } else if (role.contains('pest') || service.contains('pest')) {
      return ['Anti-Cockroach Gel', 'Termite Barrier', 'Bedbug Steaming', 'Rodent Proofing', 'Odorless Spray'];
    } else if (role.contains('appliance') || service.contains('appliance')) {
      return ['Washing Machine Drum', 'Fridge Gas Refill', 'Microwave Magnetron', 'Motor Repair', 'PCB Diagnosis'];
    }

    return ['Pipe Fitting', 'Leak Repair', 'Drain Cleaning', 'Bathroom Installation', 'Tank Cleaning'];
  }

  Widget _buildReviewItem({
    required String name,
    required String time,
    required double rating,
    required String comment,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        name.substring(0, 1),
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF005AC2)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(time, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 15, color: Color(0xFFD97706)),
                  const SizedBox(width: 2),
                  Text(
                    '$rating',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF92400E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
