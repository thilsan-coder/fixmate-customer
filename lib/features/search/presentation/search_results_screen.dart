import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/fix_mate_bottom_nav.dart';
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
  final String? reviewSnippet;
  final List<String> skills;

  const WorkerItem({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewsCount,
    required this.distance,
    required this.price,
    required this.avatarUrl,
    this.isAvailable = true,
    this.reviewSnippet,
    this.skills = const [],
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

  String _selectedDistanceFilter = 'All';
  String _selectedRatingFilter = 'All';
  String _selectedPriceFilter = 'All';

  final List<String> _filters = ['Distance', 'Rating', 'Price'];
  late List<WorkerItem> _allWorkers;
  late List<WorkerItem> _workers;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.subService ?? widget.category,
    );
    _initWorkers();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
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
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Fixed our trip switch and short circuit in 20 mins! Super polite."',
          skills: const ['House Wiring', 'MCB Tripping', 'Solar Inverter'],
        ),
        WorkerItem(
          name: 'Kasun\nPerera',
          role: 'Wiring & Circuit Expert',
          rating: 4.8,
          reviewsCount: 112,
          distance: '0.9 km away',
          price: widget.initialPrice ?? 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Excellent switchboard and chandelier light installation."',
          skills: const ['Appliance Wiring', 'LED Setup'],
        ),
        WorkerItem(
          name: 'Ruwan\nJayawardena',
          role: 'Appliance & MCB Specialist',
          rating: 4.7,
          reviewsCount: 84,
          distance: '1.4 km away',
          price: widget.initialPrice ?? 'LKR 2,000',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          isAvailable: false,
          reviewSnippet: '"Very neat cabling and high safety standards."',
          skills: const ['Fuse Boxes', 'Generator Setup'],
        ),
        WorkerItem(
          name: 'Pradeep\nKumara',
          role: 'Solar & Inverter Pro',
          rating: 4.9,
          reviewsCount: 130,
          distance: '1.8 km away',
          price: widget.initialPrice ?? 'LKR 2,500',
          avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Certified pro. Solved voltage fluctuation problems."',
          skills: const ['Solar Setup', 'Heavy Load Wiring'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Painted full 2-story living room with zero mess. Brilliant finish!"',
          skills: const ['Interior Emulsion', 'Waterproofing', 'Texture Wall'],
        ),
        WorkerItem(
          name: 'Bandara\nHerath',
          role: 'Wall & Texture Expert',
          rating: 4.8,
          reviewsCount: 95,
          distance: '1.1 km away',
          price: widget.initialPrice ?? 'LKR 4,000',
          avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Great exterior weather-shield painting before the rainy season."',
          skills: const ['Exterior Coating', 'Enamel Wood Paint'],
        ),
        WorkerItem(
          name: 'Lasantha\nFernando',
          role: 'Spray & Wood Polish Pro',
          rating: 4.7,
          reviewsCount: 68,
          distance: '1.6 km away',
          price: widget.initialPrice ?? 'LKR 3,200',
          avatarUrl: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Restored our vintage dining set and doors like brand new."',
          skills: const ['Spray Paint', 'Teak Wood Varnish'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Custom wardrobe repair and door alignment was done perfectly."',
          skills: const ['Door Locks', 'Cabinet Fitting', 'Teak Furniture'],
        ),
        WorkerItem(
          name: 'Mahesh\nGamage',
          role: 'Furniture & Lock Specialist',
          rating: 4.7,
          reviewsCount: 88,
          distance: '1.2 km away',
          price: widget.initialPrice ?? 'LKR 2,400',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Quickly repaired jammed balcony sliding door and installed smart lock."',
          skills: const ['Sliding Doors', 'Wood Polish'],
        ),
        WorkerItem(
          name: 'Nalin\nRajapakse',
          role: 'Modular Kitchen Specialist',
          rating: 4.8,
          reviewsCount: 104,
          distance: '1.9 km away',
          price: widget.initialPrice ?? 'LKR 3,500',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Fitted soft-close hinges and customized under-sink shelf."',
          skills: const ['Modular Cabinets', 'Pantry Fitting'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Deep foam cleaning made our AC ice cold again. No water leak!"',
          skills: const ['Inverter AC Cleaning', 'Gas Top-up', 'Leakage Fix'],
        ),
        WorkerItem(
          name: 'Rohan\nAbeysekara',
          role: 'AC Gas & PCB Specialist',
          rating: 4.8,
          reviewsCount: 110,
          distance: '1.0 km away',
          price: widget.initialPrice ?? 'LKR 3,500',
          avatarUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Diagnosed PCB error code in 10 mins and replaced capacitor."',
          skills: const ['PCB Repair', 'Compressor Check'],
        ),
        WorkerItem(
          name: 'Asela\nJayakody',
          role: 'Split & Cassette AC Pro',
          rating: 4.7,
          reviewsCount: 72,
          distance: '1.5 km away',
          price: widget.initialPrice ?? 'LKR 2,800',
          avatarUrl: 'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Clean indoor high-pressure water wash with zero mess on walls."',
          skills: const ['Pressure Wash', 'Copper Piping'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Replaced 12 bathroom cracked tiles with precision alignment."',
          skills: const ['Floor Tiling', 'Plastering', 'Bathroom Renovation'],
        ),
        WorkerItem(
          name: 'Jayantha\nAlwis',
          role: 'Plaster & Concrete Pro',
          rating: 4.8,
          reviewsCount: 64,
          distance: '1.3 km away',
          price: widget.initialPrice ?? 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Solid cement plastering and wall crack repair work."',
          skills: const ['Concrete Repair', 'Boundary Wall'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Welded our broken iron gate hinge in under 30 mins."',
          skills: const ['ARC Welding', 'Gate Repair', 'Window Grills'],
        ),
        WorkerItem(
          name: 'Lalith\nPremadasa',
          role: 'Steel Railing & Gate Specialist',
          rating: 4.8,
          reviewsCount: 52,
          distance: '1.5 km away',
          price: widget.initialPrice ?? 'LKR 2,600',
          avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Stainless steel staircase railing reinforcement done cleanly."',
          skills: const ['Stainless Steel', 'Heavy Fabrication'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Kitchen deep scrub and tile shining looked like brand new!"',
          skills: const ['Kitchen Deep Clean', 'Bathroom Sanitizing', 'Floor Polishing'],
        ),
        WorkerItem(
          name: 'Nalinda\nDias',
          role: 'Sofa & Sanitization Pro',
          rating: 4.8,
          reviewsCount: 145,
          distance: '0.9 km away',
          price: widget.initialPrice ?? 'LKR 3,800',
          avatarUrl: 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Extracted tough stains from 5-seater fabric sofa."',
          skills: const ['Sofa Extraction', 'Mattress Sterilizing'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Safe odorless cockroach gel treatment. Haven\'t seen any bug in months."',
          skills: const ['Cockroach Gel', 'Bedbug Eradication', 'Eco-Friendly Spray'],
        ),
        WorkerItem(
          name: 'Mohamed\nRifaz',
          role: 'Termite & Heat Fogging Expert',
          rating: 4.8,
          reviewsCount: 88,
          distance: '1.2 km away',
          price: widget.initialPrice ?? 'LKR 4,200',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Thorough anti-termite drilling and wood protection."',
          skills: const ['Termite Treatment', 'Mosquito Fogging'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Fixed refrigerator cooling failure and replaced thermostat fast."',
          skills: const ['Refrigerator Repair', 'Microwave Oven', 'Induction Cooker'],
        ),
        WorkerItem(
          name: 'Priyashantha\nSilva',
          role: 'Washing Machine Pro',
          rating: 4.8,
          reviewsCount: 142,
          distance: '1.1 km away',
          price: widget.initialPrice ?? 'LKR 3,000',
          avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Replaced front-load washing machine drum belt on the spot."',
          skills: const ['Washing Machine', 'Water Heater Repair'],
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
          avatarUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Fixed high pressure leak under kitchen sink immediately. Super clean!"',
          skills: const ['Pipe Leakages', 'Tap & Mixer', 'Drain Unclogging'],
        ),
        WorkerItem(
          name: 'Kamal\nFernando',
          role: 'Senior Plumber',
          rating: 4.7,
          reviewsCount: 98,
          distance: '0.8 km away',
          price: 'LKR 1,800',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Installed new shower set and water pressure pump smoothly."',
          skills: const ['Bathroom Fittings', 'Pressure Pumps'],
        ),
        WorkerItem(
          name: 'Saman\nKumara',
          role: 'Pipe Specialist',
          rating: 4.6,
          reviewsCount: 75,
          distance: '1.2 km away',
          price: 'LKR 2,200',
          avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
          isAvailable: false,
          reviewSnippet: '"Reliable water tank cleaning and overhead line plumbing."',
          skills: const ['Overhead Tank', 'PVC Piping'],
        ),
        WorkerItem(
          name: 'Dinesh\nFonseka',
          role: 'Leakage Expert',
          rating: 4.9,
          reviewsCount: 142,
          distance: '1.5 km away',
          price: 'LKR 2,500',
          avatarUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
          isAvailable: true,
          reviewSnippet: '"Located hidden wall leakage without breaking extra tiles!"',
          skills: const ['Concealed Leakages', 'Sewer Lines'],
        ),
      ];
    }
    _allWorkers = List.from(_workers);
  }

  double _parseDistance(String dist) {
    final match = RegExp(r'([0-9]+(?:\.[0-9]+)?)').firstMatch(dist);
    if (match != null) {
      return double.tryParse(match.group(1)!) ?? 999.0;
    }
    return 999.0;
  }

  int _parsePrice(String price) {
    final clean = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(clean) ?? 0;
  }

  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();
    final cat = widget.category.toLowerCase();
    final sub = widget.subService?.toLowerCase() ?? '';

    // If query is empty or just matches the screen category / subService, don't filter out by query
    final isCategoryQuery = query.isEmpty ||
        query == cat ||
        (sub.isNotEmpty && query == sub) ||
        cat.contains(query) ||
        query.contains(cat);

    List<WorkerItem> list = _allWorkers.where((w) {
      if (!isCategoryQuery) {
        final workerText =
            '${w.name} ${w.role} ${w.skills.join(" ")} ${w.reviewSnippet ?? ""} $cat $sub'
                .toLowerCase();
        final queryWords = query
            .split(RegExp(r'\s+'))
            .where((s) => s.isNotEmpty)
            .toList();

        final matchesQuery = queryWords.every((word) {
          final stem =
              word.length > 4 ? word.substring(0, word.length - 3) : word;
          return workerText.contains(word) || workerText.contains(stem);
        });
        if (!matchesQuery) return false;
      }

      // Distance filter
      if (_selectedDistanceFilter == '< 1 km') {
        if (_parseDistance(w.distance) > 1.0) return false;
      } else if (_selectedDistanceFilter == '< 2 km') {
        if (_parseDistance(w.distance) > 2.0) return false;
      }

      // Rating filter
      if (_selectedRatingFilter == '4.8+') {
        if (w.rating < 4.8) return false;
      } else if (_selectedRatingFilter == '4.7+') {
        if (w.rating < 4.7) return false;
      }

      // Price filter
      if (_selectedPriceFilter == '< LKR 2,500') {
        if (_parsePrice(w.price) > 2500) return false;
      } else if (_selectedPriceFilter == '< LKR 3,000') {
        if (_parsePrice(w.price) > 3000) return false;
      }

      return true;
    }).toList();

    // Sorting
    if (_selectedDistanceFilter == 'Nearest') {
      list.sort((a, b) =>
          _parseDistance(a.distance).compareTo(_parseDistance(b.distance)));
    } else if (_selectedRatingFilter == 'Top Rated') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_selectedPriceFilter == 'Low to High') {
      list.sort((a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
    } else if (_selectedPriceFilter == 'High to Low') {
      list.sort((a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
    }

    setState(() {
      _workers = list;
    });
  }

  void _resetAllFilters() {
    setState(() {
      _selectedDistanceFilter = 'All';
      _selectedRatingFilter = 'All';
      _selectedPriceFilter = 'All';
    });
    _applyFilters();
  }

  void _showDistanceFilterSheet() {
    final options = [
      {'key': 'All', 'label': 'All Distances', 'desc': 'Show all verified pros nearby'},
      {'key': 'Nearest', 'label': 'Nearest First', 'desc': 'Sort by closest distance to you'},
      {'key': '< 1 km', 'label': 'Under 1.0 km', 'desc': 'Walking distance & fastest arrival'},
      {'key': '< 2 km', 'label': 'Under 2.0 km', 'desc': 'Within local neighborhood radius'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (sheetContext) {
        String tempSelection = _selectedDistanceFilter;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.near_me_rounded,
                              color: Color(0xFF005AC2),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Distance & Proximity',
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Filter or sort pros by arrival distance',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 10),

                      // Option tiles
                      ...options.map((opt) {
                        final isSelected = tempSelection == opt['key'];
                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            setModalState(() {
                              tempSelection = opt['key']!;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? const Color(0xFF005AC2) : const Color(0xFF94A3B8),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        opt['label']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                          color: isSelected ? const Color(0xFF005AC2) : const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        opt['desc']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 11.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 14),

                      // Action buttons
                      Row(
                        children: [
                          if (tempSelection != 'All')
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedDistanceFilter = 'All';
                                  });
                                  _applyFilters();
                                },
                                child: Text(
                                  'Clear',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          if (tempSelection != 'All') const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005AC2),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _selectedDistanceFilter = tempSelection;
                                });
                                _applyFilters();
                              },
                              child: Text(
                                'Apply Filter',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
            );
          },
        );
      },
    );
  }

  void _showRatingFilterSheet() {
    final options = [
      {'key': 'All', 'label': 'All Ratings', 'desc': 'Show all rated service specialists'},
      {'key': 'Top Rated', 'label': 'Top Rated First', 'desc': 'Sort by highest star ratings & reviews'},
      {'key': '4.8+', 'label': '4.8 ★ & Above', 'desc': 'Top tier certified master pros only'},
      {'key': '4.7+', 'label': '4.7 ★ & Above', 'desc': 'Highly recommended by satisfied customers'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (sheetContext) {
        String tempSelection = _selectedRatingFilter;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFD97706),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ratings & Reviews',
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Filter by verified customer satisfaction',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 10),

                      // Option tiles
                      ...options.map((opt) {
                        final isSelected = tempSelection == opt['key'];
                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            setModalState(() {
                              tempSelection = opt['key']!;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFFFBEB) : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFD97706) : const Color(0xFFE2E8F0),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        opt['label']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                          color: isSelected ? const Color(0xFF92400E) : const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        opt['desc']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 11.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 14),

                      // Action buttons
                      Row(
                        children: [
                          if (tempSelection != 'All')
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedRatingFilter = 'All';
                                  });
                                  _applyFilters();
                                },
                                child: Text(
                                  'Clear',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          if (tempSelection != 'All') const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005AC2),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _selectedRatingFilter = tempSelection;
                                });
                                _applyFilters();
                              },
                              child: Text(
                                'Apply Filter',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
            );
          },
        );
      },
    );
  }

  void _showPriceFilterSheet() {
    final options = [
      {'key': 'All', 'label': 'All Price Ranges', 'desc': 'Show all standard service pricing tiers'},
      {'key': 'Low to High', 'label': 'Price: Low to High', 'desc': 'Most budget-friendly starting rates'},
      {'key': 'High to Low', 'label': 'Price: High to Low', 'desc': 'Premium and master tier services'},
      {'key': '< LKR 2,500', 'label': 'Under LKR 2,500', 'desc': 'Affordable inspections & minor fixes'},
      {'key': '< LKR 3,000', 'label': 'Under LKR 3,000', 'desc': 'Standard repairs & installations'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (sheetContext) {
        String tempSelection = _selectedPriceFilter;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.payments_rounded,
                              color: Color(0xFF16A34A),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price & Budget',
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Sort and filter by starting inspection prices',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 10),

                      // Option tiles
                      ...options.map((opt) {
                        final isSelected = tempSelection == opt['key'];
                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            setModalState(() {
                              tempSelection = opt['key']!;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF16A34A) : const Color(0xFFE2E8F0),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                  color: isSelected ? const Color(0xFF16A34A) : const Color(0xFF94A3B8),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        opt['label']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                          color: isSelected ? const Color(0xFF166534) : const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        opt['desc']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 11.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 14),

                      // Action buttons
                      Row(
                        children: [
                          if (tempSelection != 'All')
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedPriceFilter = 'All';
                                  });
                                  _applyFilters();
                                },
                                child: Text(
                                  'Clear',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          if (tempSelection != 'All') const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005AC2),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _selectedPriceFilter = tempSelection;
                                });
                                _applyFilters();
                              },
                              child: Text(
                                'Apply Filter',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
            );
          },
        );
      },
    );
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
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.inter(
                        fontSize: 14.5,
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF64748B),
                          size: 22,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.cancel_rounded,
                                  color: Color(0xFF94A3B8),
                                  size: 18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                        hintText: 'Search services or pros...',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                      ),
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
                        String filterLabel = _filters[index];
                        bool isFilterActive = false;

                        if (index == 0) {
                          isFilterActive = _selectedDistanceFilter != 'All';
                          filterLabel = isFilterActive
                              ? _selectedDistanceFilter
                              : 'Distance';
                        } else if (index == 1) {
                          isFilterActive = _selectedRatingFilter != 'All';
                          filterLabel = isFilterActive
                              ? _selectedRatingFilter
                              : 'Rating';
                        } else if (index == 2) {
                          isFilterActive = _selectedPriceFilter != 'All';
                          filterLabel = isFilterActive
                              ? _selectedPriceFilter
                              : 'Price';
                        }

                        return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              _showDistanceFilterSheet();
                            } else if (index == 1) {
                              _showRatingFilterSheet();
                            } else if (index == 2) {
                              _showPriceFilterSheet();
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isFilterActive
                                  ? const Color(0xFF005AC2)
                                  : const Color(0xFFEFF3F9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isFilterActive
                                    ? const Color(0xFF005AC2)
                                    : const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  filterLabel,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: isFilterActive
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isFilterActive
                                        ? Colors.white
                                        : const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 18,
                                  color: isFilterActive
                                      ? Colors.white
                                      : const Color(0xFF64748B),
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

            // 3. Worker Listing Cards (Scrollable ListView or Empty State)
            Expanded(
              child: _workers.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.filter_alt_off_rounded,
                                size: 48,
                                color: Color(0xFF005AC2),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No matching pros found',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your distance, rating, or price filters to see more available workers.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: const Color(0xFF64748B),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF005AC2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                              onPressed: _resetAllFilters,
                              icon: const Icon(Icons.refresh_rounded,
                                  color: Colors.white, size: 18),
                              label: Text(
                                'Reset All Filters',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
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
      bottomNavigationBar: const FixMateBottomNav(
        currentIndex: -1,
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

                if (worker.skills.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: worker.skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          skill,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                if (worker.reviewSnippet != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote_rounded,
                          size: 14,
                          color: Color(0xFF005AC2),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            worker.reviewSnippet!,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF64748B),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 10),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),

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
                    ),                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
