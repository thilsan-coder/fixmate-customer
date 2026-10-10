import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/fix_mate_bottom_nav.dart';
import '../../booking/presentation/book_service_screen.dart';

class ServiceCategoryModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String? badge;

  const ServiceCategoryModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bgColor,
    this.badge,
  });
}

class AllCategoriesScreen extends StatefulWidget {
  final String? initialCategoryId;

  const AllCategoriesScreen({super.key, this.initialCategoryId});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<ServiceCategoryModel> _allCategories = const [
    ServiceCategoryModel(
      title: 'Electrician',
      subtitle: 'Wiring, lights, fan & switches',
      icon: Icons.bolt_rounded,
      color: Color(0xFFD97706),
      bgColor: Color(0xFFFEF3C7),
      badge: 'POPULAR',
    ),
    ServiceCategoryModel(
      title: 'Plumber',
      subtitle: 'Pipes, leaks, taps & drainage',
      icon: Icons.plumbing_rounded,
      color: Color(0xFF0284C7),
      bgColor: Color(0xFFE0F2FE),
      badge: 'TOP',
    ),
    ServiceCategoryModel(
      title: 'Carpenter',
      subtitle: 'Furniture, doors, locks & wood',
      icon: Icons.carpenter_rounded,
      color: Color(0xFF92400E),
      bgColor: Color(0xFFFEF3C7),
    ),
    ServiceCategoryModel(
      title: 'Painter',
      subtitle: 'Wall repainting & damp fix',
      icon: Icons.format_paint_rounded,
      color: Color(0xFFDB2777),
      bgColor: Color(0xFFFCE7F3),
      badge: 'OFFER',
    ),
    ServiceCategoryModel(
      title: 'AC Repair',
      subtitle: 'Cooling, gas refill & clean',
      icon: Icons.ac_unit_rounded,
      color: Color(0xFF0891B2),
      bgColor: Color(0xFFE0F2FE),
      badge: 'HOT',
    ),
    ServiceCategoryModel(
      title: 'Mason',
      subtitle: 'Tile work, plaster & concrete',
      icon: Icons.foundation_rounded,
      color: Color(0xFFEA580C),
      bgColor: Color(0xFFFFEDD5),
    ),
    ServiceCategoryModel(
      title: 'Welder',
      subtitle: 'Gates, grills & metal repairs',
      icon: Icons.hardware_rounded,
      color: Color(0xFF4F46E5),
      bgColor: Color(0xFFEEF2FF),
    ),
    ServiceCategoryModel(
      title: 'Cleaning',
      subtitle: 'Full home deep clean & sofa',
      icon: Icons.cleaning_services_rounded,
      color: Color(0xFF10B981),
      bgColor: Color(0xFFD1FAE5),
      badge: 'TRENDING',
    ),
    ServiceCategoryModel(
      title: 'Appliance',
      subtitle: 'Washing machine, fridge & oven',
      icon: Icons.kitchen_rounded,
      color: Color(0xFFEC4899),
      bgColor: Color(0xFFFCE7F3),
    ),
    ServiceCategoryModel(
      title: 'Roofing & Ceiling',
      subtitle: 'Ceiling leaks, sheets & gutters',
      icon: Icons.roofing_rounded,
      color: Color(0xFF059669),
      bgColor: Color(0xFFD1FAE5),
    ),
    ServiceCategoryModel(
      title: 'Gardening & Lawn',
      subtitle: 'Lawn mow, tree trimming & weed',
      icon: Icons.yard_rounded,
      color: Color(0xFF16A34A),
      bgColor: Color(0xFFDCFCE7),
    ),
    ServiceCategoryModel(
      title: 'Pest Control',
      subtitle: 'Termite, bedbug & insect spray',
      icon: Icons.pest_control_rounded,
      color: Color(0xFFDC2626),
      bgColor: Color(0xFFFEE2E2),
    ),
    ServiceCategoryModel(
      title: 'CCTV & Security',
      subtitle: 'Camera install & smart lock setup',
      icon: Icons.videocam_rounded,
      color: Color(0xFF2563EB),
      bgColor: Color(0xFFDBEAFE),
    ),
    ServiceCategoryModel(
      title: 'Movers & Packers',
      subtitle: 'House shifting & heavy luggage',
      icon: Icons.local_shipping_rounded,
      color: Color(0xFF7C3AED),
      bgColor: Color(0xFFEDE9FE),
    ),
    ServiceCategoryModel(
      title: 'Vehicle Wash',
      subtitle: 'Doorstep car & bike detailing',
      icon: Icons.directions_car_rounded,
      color: Color(0xFF0284C7),
      bgColor: Color(0xFFE0F2FE),
    ),
    ServiceCategoryModel(
      title: 'Glass & Aluminium',
      subtitle: 'Partitions, windows & fittings',
      icon: Icons.window_rounded,
      color: Color(0xFF475569),
      bgColor: Color(0xFFF1F5F9),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategoryTapped(ServiceCategoryModel category) {
    // Open the same BookServiceScreen flow as the '+' button in bookings,
    // with this clicked category selected!
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookServiceScreen(
          serviceName: category.title,
          serviceSubtitle: category.subtitle,
          isCategoryFixed: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCategories = _allCategories.where((cat) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return cat.title.toLowerCase().contains(q) ||
          cat.subtitle.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Service Categories',
              style: GoogleFonts.inter(
                color: const Color(0xFF0F172A),
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Tap any service to request instantly',
              style: GoogleFonts.inter(
                color: const Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim();
                    });
                  },
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF94A3B8),
                      size: 22,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                color: Color(0xFF94A3B8), size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    hintText: 'Search plumber, electrician, cleaning...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 13.5,
                      color: const Color(0xFF94A3B8),
                    ),
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            // Category Count & Info Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${filteredCategories.length} Categories Available',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Instant Booking ⚡',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF005AC2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Categories Grid List
            Expanded(
              child: filteredCategories.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off_rounded,
                              size: 48, color: Color(0xFF94A3B8)),
                          const SizedBox(height: 12),
                          Text(
                            'No category found for "$_searchQuery"',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Try searching for plumbing, wiring, etc.',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredCategories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final cat = filteredCategories[index];

                        return InkWell(
                          onTap: () => _onCategoryTapped(cat),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Rounded square icon container
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: cat.bgColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      cat.icon,
                                      color: cat.color,
                                      size: 26,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Title, subtitle & badge
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            cat.title,
                                            style: GoogleFonts.inter(
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(0xFF0F172A),
                                            ),
                                          ),
                                          if (cat.badge != null) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFEFF6FF),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                cat.badge!,
                                                style: GoogleFonts.inter(
                                                  fontSize: 9.5,
                                                  fontWeight: FontWeight.w800,
                                                  color: const Color(0xFF005AC2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        cat.subtitle,
                                        style: GoogleFonts.inter(
                                          fontSize: 12.5,
                                          color: const Color(0xFF64748B),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Action Arrow Badge
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xFF005AC2),
                                      size: 18,
                                    ),
                                  ),
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
      bottomNavigationBar: const FixMateBottomNav(currentIndex: -1),
    );
  }
}
