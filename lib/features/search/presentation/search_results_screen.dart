import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../workers/presentation/worker_profile_screen.dart';

class WorkerItem {
  final String name;
  final String role;
  final double rating;
  final int reviewsCount;
  final String distance;
  final String price;
  final String avatarUrl;
  final bool isAvailable;

  const WorkerItem({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewsCount,
    required this.distance,
    required this.price,
    required this.avatarUrl,
    this.isAvailable = true,
  });
}

class SearchResultsScreen extends StatefulWidget {
  final String category;
  final String? subService;
  final String? initialPrice;

  const SearchResultsScreen({
    super.key,
    this.category = 'Plumbing',
    this.subService,
    this.initialPrice,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late final TextEditingController _searchController;
  int _selectedFilterIndex = 0; // 0: Distance, 1: Rating, 2: Price
  int _currentNavIndex = 1; // "Bookings" active tab

  final List<String> _filters = ['Distance', 'Rating', 'Price'];
  late List<WorkerItem> _workers;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.subService ?? widget.category,
    );
    _initWorkers();
  }

  void _initWorkers() {
    final cat = widget.category.toLowerCase();
    final defaultPrice = widget.initialPrice ?? 'LKR 2,000';

    if (cat.contains('electr')) {
      _workers = [
        WorkerItem(
          name: 'Nuwan\nSilva',
          role: 'Master Electrician',
          rating: 4.9,
          reviewsCount: 156,
          distance: '0.4 km away',
          price: widget.initialPrice ?? 'LKR 1,800',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Kasun\nPerera',
          role: 'Wiring & Circuit Expert',
          rating: 4.8,
          reviewsCount: 112,
          distance: '0.9 km away',
          price: widget.initialPrice ?? 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Ruwan\nJayawardena',
          role: 'Appliance & MCB Specialist',
          rating: 4.7,
          reviewsCount: 84,
          distance: '1.4 km away',
          price: widget.initialPrice ?? 'LKR 2,000',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: false,
        ),
        WorkerItem(
          name: 'Pradeep\nKumara',
          role: 'Solar & Inverter Pro',
          rating: 4.9,
          reviewsCount: 130,
          distance: '1.8 km away',
          price: widget.initialPrice ?? 'LKR 2,500',
          avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('paint')) {
      _workers = [
        WorkerItem(
          name: 'Sanath\nGunawardena',
          role: 'Master Painter',
          rating: 4.9,
          reviewsCount: 140,
          distance: '0.6 km away',
          price: widget.initialPrice ?? 'LKR 3,500',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Bandara\nHerath',
          role: 'Wall & Texture Expert',
          rating: 4.8,
          reviewsCount: 95,
          distance: '1.1 km away',
          price: widget.initialPrice ?? 'LKR 4,000',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('carpenter') || cat.contains('carpent')) {
      _workers = [
        WorkerItem(
          name: 'Anura\nSenanayake',
          role: 'Master Carpenter',
          rating: 4.9,
          reviewsCount: 168,
          distance: '0.7 km away',
          price: widget.initialPrice ?? 'LKR 2,800',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Mahesh\nGamage',
          role: 'Furniture & Lock Specialist',
          rating: 4.7,
          reviewsCount: 88,
          distance: '1.2 km away',
          price: widget.initialPrice ?? 'LKR 2,400',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('ac') || cat.contains('air')) {
      _workers = [
        WorkerItem(
          name: 'Chaminda\nVithanage',
          role: 'HVAC & AC Technician',
          rating: 4.9,
          reviewsCount: 185,
          distance: '0.5 km away',
          price: widget.initialPrice ?? 'LKR 3,000',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Rohan\nAbeysekara',
          role: 'AC Gas & PCB Specialist',
          rating: 4.8,
          reviewsCount: 110,
          distance: '1.0 km away',
          price: widget.initialPrice ?? 'LKR 3,500',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('mason') || cat.contains('tile')) {
      _workers = [
        WorkerItem(
          name: 'Sunil\nShanmugam',
          role: 'Master Mason & Tile Expert',
          rating: 4.9,
          reviewsCount: 95,
          distance: '0.7 km away',
          price: widget.initialPrice ?? 'LKR 2,800',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Jayantha\nAlwis',
          role: 'Plaster & Concrete Pro',
          rating: 4.8,
          reviewsCount: 64,
          distance: '1.3 km away',
          price: widget.initialPrice ?? 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('weld')) {
      _workers = [
        WorkerItem(
          name: 'Suresh\nKumar',
          role: 'Master Welder & Fabricator',
          rating: 4.9,
          reviewsCount: 78,
          distance: '0.6 km away',
          price: widget.initialPrice ?? 'LKR 2,000',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Lalith\nPremadasa',
          role: 'Steel Railing & Gate Specialist',
          rating: 4.8,
          reviewsCount: 52,
          distance: '1.5 km away',
          price: widget.initialPrice ?? 'LKR 2,600',
          avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('clean')) {
      _workers = [
        WorkerItem(
          name: 'Kumari\nJayasinghe',
          role: 'Deep Cleaning Specialist',
          rating: 4.9,
          reviewsCount: 190,
          distance: '0.4 km away',
          price: widget.initialPrice ?? 'LKR 2,500',
          avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Nalinda\nDias',
          role: 'Sofa & Sanitization Pro',
          rating: 4.8,
          reviewsCount: 145,
          distance: '0.9 km away',
          price: widget.initialPrice ?? 'LKR 3,800',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('pest')) {
      _workers = [
        WorkerItem(
          name: 'Anton\nRodrigo',
          role: 'Certified Pest Controller',
          rating: 4.9,
          reviewsCount: 135,
          distance: '0.8 km away',
          price: widget.initialPrice ?? 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Mohamed\nRifaz',
          role: 'Termite & Heat Fogging Expert',
          rating: 4.8,
          reviewsCount: 88,
          distance: '1.2 km away',
          price: widget.initialPrice ?? 'LKR 4,200',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else if (cat.contains('appliance')) {
      _workers = [
        WorkerItem(
          name: 'Tharindu\nSamarasinghe',
          role: 'Appliance & Fridge Specialist',
          rating: 4.9,
          reviewsCount: 168,
          distance: '0.5 km away',
          price: widget.initialPrice ?? 'LKR 2,500',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Priyashantha\nSilva',
          role: 'Washing Machine Pro',
          rating: 4.8,
          reviewsCount: 142,
          distance: '1.1 km away',
          price: widget.initialPrice ?? 'LKR 3,000',
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    } else {
      _workers = [
        WorkerItem(
          name: 'Nimal\nPerera',
          role: 'Master Plumber',
          rating: 4.8,
          reviewsCount: 120,
          distance: '0.5 km away',
          price: defaultPrice,
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Kamal\nFernando',
          role: 'Senior Plumber',
          rating: 4.7,
          reviewsCount: 98,
          distance: '0.8 km away',
          price: 'LKR 1,800',
          avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
        WorkerItem(
          name: 'Saman\nKumara',
          role: 'Pipe Specialist',
          rating: 4.6,
          reviewsCount: 75,
          distance: '1.2 km away',
          price: 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&fit=crop&q=80',
          isAvailable: false,
        ),
        WorkerItem(
          name: 'Dinesh\nFonseka',
          role: 'Leakage Expert',
          rating: 4.9,
          reviewsCount: 142,
          distance: '1.5 km away',
          price: 'LKR 2,500',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&fit=crop&q=80',
          isAvailable: true,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
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
          'Search Results',
          style: GoogleFonts.inter(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 24,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Column(
                children: [
                  // 1. Search Bar with Clear Button
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF2F7),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF64748B),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: const Color(0xFF0F172A),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search for services...',
                              hintStyle: GoogleFonts.inter(
                                color: const Color(0xFF94A3B8),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: Color(0xFF64748B),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 2. Filter Dropdown Chips Row
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final filterName = _filters[index];
                        final isSelected = _selectedFilterIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFFEFF3F9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  filterName,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF1E293B),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 3. Worker Listing Cards (Scrollable ListView)
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _workers.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final worker = _workers[index];
                  return _buildWorkerCard(context, worker);
                },
              ),
            ),
          ],
        ),
      ),

      // 4. Bottom Navigation Bar
      bottomNavigationBar: Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.calendar_month_outlined,
                label: 'Bookings',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'Chat',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Worker Card Component
  Widget _buildWorkerCard(BuildContext context, WorkerItem worker) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerProfileScreen(
                  name: worker.name.replaceAll('\n', ' '),
                  role: worker.role,
                  rating: worker.rating,
                  reviewsCount: worker.reviewsCount,
                  distance: worker.distance,
                  avatarUrl: worker.avatarUrl,
                  price: worker.price,
                  serviceName: widget.category,
                  subServiceName: widget.subService,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Avatar, Name/Role & Availability Pill
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with verified badge & online indicator
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: 62,
                            height: 62,
                            color: const Color(0xFFEFF6FF),
                            child: Image.network(
                              worker.avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, color: Color(0xFF005AC2), size: 34),
                            ),
                          ),
                        ),
                        if (worker.isAvailable)
                          Positioned(
                            top: -1,
                            right: -1,
                            child: Container(
                              width: 14,
                              height: 14,
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

                    // Name, Role & Verification
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  worker.name.replaceAll('\n', ' '),
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
                              const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF005AC2)),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            worker.role,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star_rounded, size: 13, color: Color(0xFFD97706)),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${worker.rating}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF92400E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '(${worker.reviewsCount} reviews)',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('•', style: TextStyle(color: Color(0xFFCBD5E1))),
                              const SizedBox(width: 8),
                              const Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF64748B)),
                              const SizedBox(width: 2),
                              Text(
                                worker.distance,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),

                // Bottom Strip: Highlights, Price & Book Action
                Row(
                  children: [
                    // Highlights tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFDCFCE7)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            worker.isAvailable ? Icons.bolt_rounded : Icons.schedule_rounded,
                            size: 13,
                            color: worker.isAvailable ? const Color(0xFF16A34A) : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            worker.isAvailable ? 'Fast 20m Arrival' : 'Book for Tomorrow',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: worker.isAvailable ? const Color(0xFF166534) : const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Price Tag
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Starting',
                          style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          worker.price,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005AC2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),

                    // Action Arrow
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF005AC2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar Item Builder
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isActive = _currentNavIndex == index;

    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF005AC2), size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF005AC2),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.home, (route) => false);
        } else if (index == 2) {
          Navigator.pushNamed(context, AppRoutes.chat);
        } else if (index == 3) {
          Navigator.pushNamed(context, AppRoutes.editProfile);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(icon, color: const Color(0xFF94A3B8), size: 22),
      ),
    );
  }
}
