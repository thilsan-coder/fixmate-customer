import 'package:flutter/material.dart';
import '../../search/presentation/search_results_screen.dart';

class CategoryItem {
  final String id;
  final String title;
  final String tagline;
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String bannerBadge;
  final List<SubServiceItem> subServices;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.tagline,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.bannerBadge,
    required this.subServices,
  });
}

class SubServiceItem {
  final String name;
  final String description;
  final String startingPrice;
  final String duration;
  final String rating;
  final int reviewsCount;
  final int prosCount;
  final String? badge;
  final List<String> highlights;

  const SubServiceItem({
    required this.name,
    required this.description,
    required this.startingPrice,
    required this.duration,
    required this.rating,
    required this.reviewsCount,
    required this.prosCount,
    this.badge,
    required this.highlights,
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
  late String _selectedCategoryId;
  bool _isGridView = false;

  final List<CategoryItem> _allCategories = const [
    CategoryItem(
      id: 'electrician',
      title: 'Electrician',
      tagline: 'Wiring, switches, lighting, fan & appliance fixing',
      icon: Icons.bolt_rounded,
      color: Color(0xFFD97706),
      bgColor: Color(0xFFFEF3C7),
      bannerBadge: '38+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Ceiling Fan Installation & Repair',
          description: 'Fix wobbling & noisy blades, capacitor change, motor rewinding',
          startingPrice: 'Rs. 1,200',
          duration: '30 mins',
          rating: '4.9',
          reviewsCount: 142,
          prosCount: 38,
          badge: 'Most Popular',
          highlights: ['Free testing', 'Genuine capacitors', '30-day warranty'],
        ),
        SubServiceItem(
          name: 'Switchboard & Socket Setup',
          description: 'Modular switch repair, heavy power socket setup for AC/Oven',
          startingPrice: 'Rs. 800',
          duration: '25 mins',
          rating: '4.8',
          reviewsCount: 96,
          prosCount: 45,
          badge: 'Fast 20m',
          highlights: ['Shockproof fitting', 'Safety load check', 'Neat wiring'],
        ),
        SubServiceItem(
          name: 'Emergency Short Circuit Fix',
          description: 'Urgent troubleshooting, MCB breaker trip, fuse box restoration',
          startingPrice: 'Rs. 2,000',
          duration: '45 mins',
          rating: '5.0',
          reviewsCount: 88,
          prosCount: 29,
          badge: 'Emergency ⚡',
          highlights: ['Instant dispatch', 'Earthing check', 'Safety certified'],
        ),
        SubServiceItem(
          name: 'Complete House Wiring & Conduit',
          description: 'Full house rewiring, safety testing, circuit breaker installation',
          startingPrice: 'Rs. 8,500',
          duration: '2-4 hrs',
          rating: '4.9',
          reviewsCount: 64,
          prosCount: 19,
          highlights: ['Standard code compliant', 'Flame-retardant wires', '1-year warranty'],
        ),
        SubServiceItem(
          name: 'Chandelier & Mood Lighting',
          description: 'Ceiling chandelier hanging, LED strip profile and smart lights',
          startingPrice: 'Rs. 1,800',
          duration: '40 mins',
          rating: '4.7',
          reviewsCount: 52,
          prosCount: 24,
          highlights: ['Precision leveling', 'Dimmer integration', 'Zero wall damage'],
        ),
      ],
    ),
    CategoryItem(
      id: 'plumber',
      title: 'Plumber',
      tagline: 'Pipes, taps, drainage, pumps & water tank repair',
      icon: Icons.plumbing_rounded,
      color: Color(0xFF0284C7),
      bgColor: Color(0xFFE0F2FE),
      bannerBadge: '52+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Pipe & Tap Leakage Fix',
          description: 'Fix dripping taps, leaking bib-cocks and concealed pipe cracks',
          startingPrice: 'Rs. 1,000',
          duration: '30 mins',
          rating: '4.9',
          reviewsCount: 210,
          prosCount: 52,
          badge: 'Best Seller',
          highlights: ['Teflon sealing', 'Pressure testing', 'Leak-proof guarantee'],
        ),
        SubServiceItem(
          name: 'Blocked Drain & Sink Clearing',
          description: 'Heavy duty rotary unclogging for kitchen sinks, shower & sewer',
          startingPrice: 'Rs. 1,500',
          duration: '45 mins',
          rating: '4.8',
          reviewsCount: 174,
          prosCount: 34,
          badge: 'No Mess',
          highlights: ['Chemical-free unclog', 'Odor eradication', 'Free pipe rinse'],
        ),
        SubServiceItem(
          name: 'Toilet Commode & Cistern Repair',
          description: 'Dual flush cistern mechanism, seal leakage, new commode fitting',
          startingPrice: 'Rs. 2,200',
          duration: '1 hr',
          rating: '4.9',
          reviewsCount: 118,
          prosCount: 26,
          highlights: ['Anti-bacterial seal', 'Genuine flush valves', '30-day warranty'],
        ),
        SubServiceItem(
          name: 'Overhead Water Tank Deep Clean',
          description: 'High pressure sanitized wash, algae & sediment removal',
          startingPrice: 'Rs. 3,500',
          duration: '2 hrs',
          rating: '5.0',
          reviewsCount: 82,
          prosCount: 15,
          badge: 'Sanitized',
          highlights: ['UV sanitization', 'Sludge vacuum', 'Water quality test'],
        ),
        SubServiceItem(
          name: 'Water Motor Pump Servicing',
          description: 'Automatic pressure sensor setup, impeller and motor service',
          startingPrice: 'Rs. 2,800',
          duration: '1.5 hrs',
          rating: '4.8',
          reviewsCount: 75,
          prosCount: 22,
          highlights: ['Thermal check', 'Noise reduction', 'Bearing lubrication'],
        ),
      ],
    ),
    CategoryItem(
      id: 'carpenter',
      title: 'Carpenter',
      tagline: 'Doors, locks, cabinets, hinges & custom woodwork',
      icon: Icons.carpenter_rounded,
      color: Color(0xFF92400E),
      bgColor: Color(0xFFFEF3C7),
      bannerBadge: '31+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Door Lock & Smart Handle Fitting',
          description: 'Mortise lock replacement, deadbolt, electronic smart lock setup',
          startingPrice: 'Rs. 1,200',
          duration: '35 mins',
          rating: '4.9',
          reviewsCount: 130,
          prosCount: 31,
          badge: 'Top Pick',
          highlights: ['High security fit', 'Clean chisel work', 'Keys tested'],
        ),
        SubServiceItem(
          name: 'Furniture Assembly & Repair',
          description: 'Bed frame, study desk, wardrobe, dining table assembly',
          startingPrice: 'Rs. 2,000',
          duration: '1 hr',
          rating: '4.8',
          reviewsCount: 104,
          prosCount: 40,
          highlights: ['Hardware included', 'Sturdy leveling', 'Anti-scratch pads'],
        ),
        SubServiceItem(
          name: 'Wardrobe & Kitchen Cabinet Fix',
          description: 'Soft-close hinge adjustment, sliding track fix, magnetic catch',
          startingPrice: 'Rs. 1,600',
          duration: '45 mins',
          rating: '4.9',
          reviewsCount: 92,
          prosCount: 28,
          highlights: ['Rustproof hinges', 'Smooth glide check', '30-day warranty'],
        ),
        SubServiceItem(
          name: 'Custom Floating Wall Shelves',
          description: 'Heavy duty invisible brackets, TV unit backdrops, book racks',
          startingPrice: 'Rs. 3,200',
          duration: '2 hrs',
          rating: '4.7',
          reviewsCount: 45,
          prosCount: 18,
          highlights: ['Laser level alignment', 'High load capacity', 'Sleek finish'],
        ),
      ],
    ),
    CategoryItem(
      id: 'painter',
      title: 'Painter',
      tagline: 'Interior walls, exterior & weatherproof coats',
      icon: Icons.format_paint_rounded,
      color: Color(0xFFDB2777),
      bgColor: Color(0xFFFCE7F3),
      bannerBadge: '24+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Interior Full Room Painting',
          description: '2 coats luxury emulsion paint + 1 coat primer & putty smoothing',
          startingPrice: 'Rs. 4,500',
          duration: '4-6 hrs',
          rating: '4.9',
          reviewsCount: 156,
          prosCount: 22,
          badge: 'Best Value',
          highlights: ['Floor masking included', 'Low odor paint', '1-year warranty'],
        ),
        SubServiceItem(
          name: 'Wall Putty & Surface Leveling',
          description: 'Crack patching, wall sanding, smoothing before paint',
          startingPrice: 'Rs. 2,500',
          duration: '3 hrs',
          rating: '4.8',
          reviewsCount: 88,
          prosCount: 19,
          highlights: ['Dust control prep', 'Waterproof putty', 'Mirror-smooth base'],
        ),
        SubServiceItem(
          name: 'Damp Proof & Anti-Mould Seal',
          description: 'Seepage blocker, silicone seal coating for rainy weather',
          startingPrice: 'Rs. 3,800',
          duration: '3 hrs',
          rating: '5.0',
          reviewsCount: 71,
          prosCount: 16,
          badge: 'Weatherproof',
          highlights: ['Deep penetrating seal', 'Mould protection', '3-year guarantee'],
        ),
        SubServiceItem(
          name: 'Teak Wood Polish & Varnish',
          description: 'Doors, banisters, antique furniture high gloss & matte polish',
          startingPrice: 'Rs. 3,000',
          duration: '2.5 hrs',
          rating: '4.8',
          reviewsCount: 54,
          prosCount: 14,
          highlights: ['Scratch protection', 'Rich wood grain pop', 'Water repellent'],
        ),
      ],
    ),
    CategoryItem(
      id: 'ac_repair',
      title: 'AC Repair',
      tagline: 'Deep foam jet clean, gas recharge & inverter PCB fix',
      icon: Icons.ac_unit_rounded,
      color: Color(0xFF0891B2),
      bgColor: Color(0xFFE0F2FE),
      bannerBadge: '42+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Deep Foam & High-Jet Pump Wash',
          description: 'Indoor coil anti-bacterial foam wash, outdoor condenser jet blast',
          startingPrice: 'Rs. 3,200',
          duration: '45 mins',
          rating: '5.0',
          reviewsCount: 230,
          prosCount: 42,
          badge: 'Super Clean',
          highlights: ['Power saving boost', 'Anti-fungal spray', 'Airflow check'],
        ),
        SubServiceItem(
          name: 'Refrigerant Gas Leak & Refill',
          description: 'Pressure nitrogen leak test, R32 / R410 genuine gas top-up',
          startingPrice: 'Rs. 4,800',
          duration: '1 hr',
          rating: '4.9',
          reviewsCount: 160,
          prosCount: 30,
          badge: 'Instant Chill',
          highlights: ['Genuine R32 gas', 'Free leak welding', '60-day cool warranty'],
        ),
        SubServiceItem(
          name: 'Inverter PCB Board & Sensor Fix',
          description: 'Error code diagnosis, display panel, capacitor & circuit repair',
          startingPrice: 'Rs. 3,500',
          duration: '1.5 hrs',
          rating: '4.7',
          reviewsCount: 92,
          prosCount: 18,
          highlights: ['OEM parts used', 'Digital diagnostic', '30-day warranty'],
        ),
        SubServiceItem(
          name: 'AC Dismantling & Shifting',
          description: 'Gas lock, safe copper piping removal, re-mount at new location',
          startingPrice: 'Rs. 5,000',
          duration: '2 hrs',
          rating: '4.8',
          reviewsCount: 65,
          prosCount: 25,
          highlights: ['Zero gas loss', 'Heavy bracket mount', 'Complete pipe test'],
        ),
      ],
    ),
    CategoryItem(
      id: 'mason',
      title: 'Mason & Tiles',
      tagline: 'Brickwork, floor tiling, wall cracks & plastering',
      icon: Icons.foundation_rounded,
      color: Color(0xFFEA580C),
      bgColor: Color(0xFFFFEDD5),
      bannerBadge: '21+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Floor & Wall Tile Repair',
          description: 'Hollow/broken tile replacement, adhesive leveling, waterproof grout',
          startingPrice: 'Rs. 2,800',
          duration: '2 hrs',
          rating: '4.8',
          reviewsCount: 95,
          prosCount: 21,
          badge: 'Seamless',
          highlights: ['Tile color match', 'Laser flat leveling', 'Epoxy grout finish'],
        ),
        SubServiceItem(
          name: 'Wall Crack Structural Bonding',
          description: 'Crack stitch binding, cement mortar re-plastering, smooth wall',
          startingPrice: 'Rs. 2,200',
          duration: '1.5 hrs',
          rating: '4.9',
          reviewsCount: 84,
          prosCount: 17,
          highlights: ['Crack stop mesh', 'Anti-shrink mortar', 'Sand smoothed'],
        ),
        SubServiceItem(
          name: 'Bathroom Floor Slope Correction',
          description: 'Fix water pooling near corners, new anti-slip floor tiling',
          startingPrice: 'Rs. 4,500',
          duration: '3 hrs',
          rating: '5.0',
          reviewsCount: 62,
          prosCount: 12,
          badge: 'No Pooling',
          highlights: ['Perfect drain angle', 'Complete waterproof base', 'Quick dry'],
        ),
      ],
    ),
    CategoryItem(
      id: 'welder',
      title: 'Welder',
      tagline: 'Main gates, window grills, steel railings & fabrication',
      icon: Icons.hardware_rounded,
      color: Color(0xFF4F46E5),
      bgColor: Color(0xFFEEF2FF),
      bannerBadge: '15+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Main Gate Hinge & Lock Weld',
          description: 'Sagging main gate leveling, heavy duty pivot hinges, rust cutting',
          startingPrice: 'Rs. 2,000',
          duration: '45 mins',
          rating: '4.9',
          reviewsCount: 78,
          prosCount: 15,
          badge: 'Heavy Duty',
          highlights: ['High-amp arc weld', 'Anti-rust primer', 'Smooth swing test'],
        ),
        SubServiceItem(
          name: 'Balcony & Staircase Steel Railing',
          description: 'Stainless steel (SS 304) and wrought iron joint welding & polish',
          startingPrice: 'Rs. 2,600',
          duration: '1 hr',
          rating: '4.8',
          reviewsCount: 61,
          prosCount: 14,
          highlights: ['Seamless weld grind', 'Buffed chrome shine', 'Shake-proof anchoring'],
        ),
        SubServiceItem(
          name: 'Roof Shed & Metal Truss Repair',
          description: 'Galvanized iron sheet welding, reinforcement and anchor bolts',
          startingPrice: 'Rs. 4,200',
          duration: '2.5 hrs',
          rating: '4.7',
          reviewsCount: 39,
          prosCount: 10,
          highlights: ['Storm-proof design', 'Zinc spray finish', 'High load capacity'],
        ),
      ],
    ),
    CategoryItem(
      id: 'cleaning',
      title: 'House Cleaning',
      tagline: 'Deep home, sofa, carpet & bathroom disinfection',
      icon: Icons.cleaning_services_rounded,
      color: Color(0xFF059669),
      bgColor: Color(0xFFD1FAE5),
      bannerBadge: '36+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Deep Bathroom Sanitizing & Descaling',
          description: 'Hard water scale removal, ceramic acid-safe scrub, tile shine',
          startingPrice: 'Rs. 2,500',
          duration: '1.5 hrs',
          rating: '4.9',
          reviewsCount: 190,
          prosCount: 36,
          badge: 'Hospital Grade',
          highlights: ['99.9% germ kill', 'Chrome fixture polish', 'Fresh scent'],
        ),
        SubServiceItem(
          name: 'Fabric Sofa & Mattress Shampooing',
          description: 'Wet vacuum extraction, pet allergen removal, stain lift',
          startingPrice: 'Rs. 3,800',
          duration: '2 hrs',
          rating: '5.0',
          reviewsCount: 145,
          prosCount: 28,
          badge: 'Like New',
          highlights: ['Deep fiber clean', 'Odor neutralization', 'Fast drying'],
        ),
        SubServiceItem(
          name: 'Kitchen Degreasing & Hob Wash',
          description: 'Exhaust fan deep soak, chimney filter scrub, oil grease removal',
          startingPrice: 'Rs. 3,000',
          duration: '2 hrs',
          rating: '4.8',
          reviewsCount: 110,
          prosCount: 24,
          highlights: ['Food-safe degreaser', 'Stainless steel buff', 'Oven interior clean'],
        ),
      ],
    ),
    CategoryItem(
      id: 'pest_control',
      title: 'Pest Control',
      tagline: 'Termite, cockroach, rodent & bedbug eradication',
      icon: Icons.pest_control_rounded,
      color: Color(0xFFDC2626),
      bgColor: Color(0xFFFEE2E2),
      bannerBadge: '20+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Herbal Anti-Cockroach Gel Treatment',
          description: 'Odorless non-toxic gel dots in kitchen corners & cupboards',
          startingPrice: 'Rs. 2,200',
          duration: '40 mins',
          rating: '4.9',
          reviewsCount: 135,
          prosCount: 20,
          badge: 'Safe for Pets',
          highlights: ['No need to empty kitchen', 'Child safe', '6-month warranty'],
        ),
        SubServiceItem(
          name: 'Termite Drilling & Chemical Barrier',
          description: 'Floor skirting injection, wood protection, colony elimination',
          startingPrice: 'Rs. 6,500',
          duration: '3 hrs',
          rating: '5.0',
          reviewsCount: 88,
          prosCount: 14,
          badge: '1-Yr Warranty',
          highlights: ['Government approved chemicals', 'Free re-inspection', 'Wood safe'],
        ),
        SubServiceItem(
          name: 'Bedbug Super-Heat & Steam Fogging',
          description: 'High-temp mattress steaming, crack fogging, 2-stage spray',
          startingPrice: 'Rs. 4,200',
          duration: '2 hrs',
          rating: '4.8',
          reviewsCount: 79,
          prosCount: 16,
          highlights: ['Egg destruction', 'Complete room treatment', 'Follow-up spray'],
        ),
      ],
    ),
    CategoryItem(
      id: 'appliance',
      title: 'Appliance Repair',
      tagline: 'Washing machines, fridges, microwaves & TVs',
      icon: Icons.tv_rounded,
      color: Color(0xFF7C3AED),
      bgColor: Color(0xFFEDE9FE),
      bannerBadge: '32+ Active Pros',
      subServices: [
        SubServiceItem(
          name: 'Washing Machine Drum & Spin Fix',
          description: 'Drain error, noisy spin cycle, door seal & control board repair',
          startingPrice: 'Rs. 2,500',
          duration: '1 hr',
          rating: '4.9',
          reviewsCount: 168,
          prosCount: 32,
          badge: 'All Brands',
          highlights: ['Genuine spare parts', 'On-spot diagnostic', '90-day warranty'],
        ),
        SubServiceItem(
          name: 'Refrigerator Cooling & Gas Refill',
          description: 'Compressor relay fix, thermostat calibration, frost drain unblock',
          startingPrice: 'Rs. 3,000',
          duration: '1.5 hrs',
          rating: '4.8',
          reviewsCount: 142,
          prosCount: 29,
          highlights: ['Direct cool & Inverter', 'Gas leak test', 'Door gasket check'],
        ),
        SubServiceItem(
          name: 'Microwave Oven Magnetron & Touch Fix',
          description: 'No heating issue, touch keypad replacement, glass turntable motor',
          startingPrice: 'Rs. 1,800',
          duration: '45 mins',
          rating: '4.7',
          reviewsCount: 94,
          prosCount: 21,
          highlights: ['Radiation leak test', 'High voltage fuse fix', 'Clean finish'],
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.initialCategoryId ?? _allCategories.first.id;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CategoryItem> get _filteredCategories {
    if (_searchQuery.trim().isEmpty) {
      return _allCategories;
    }
    final q = _searchQuery.toLowerCase();
    return _allCategories.where((cat) {
      final matchesTitle = cat.title.toLowerCase().contains(q);
      final matchesTagline = cat.tagline.toLowerCase().contains(q);
      final matchesSub = cat.subServices.any((s) => s.name.toLowerCase().contains(q) || s.description.toLowerCase().contains(q));
      return matchesTitle || matchesTagline || matchesSub;
    }).toList();
  }

  CategoryItem get _selectedCategory {
    final list = _filteredCategories;
    if (list.isEmpty) return _allCategories.first;
    return list.firstWhere(
      (c) => c.id == _selectedCategoryId,
      orElse: () => list.first,
    );
  }

  void _showSubServiceDetailModal(CategoryItem cat, SubServiceItem sub) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Drag Handle
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
              const SizedBox(height: 20),

              // Category Badge & Icon
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: cat.bgColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: cat.color.withValues(alpha: 0.2)),
                    ),
                    child: Center(
                      child: Icon(cat.icon, color: cat.color, size: 28),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                              decoration: BoxDecoration(
                                color: cat.color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                cat.title.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: cat.color,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            if (sub.badge != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: const Color(0xFFFECACA)),
                                ),
                                child: Text(
                                  sub.badge!,
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFDC2626),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sub.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text(
                sub.description,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Highlights bullet chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sub.highlights.map((h) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 14),
                        const SizedBox(width: 5),
                        Text(
                          h,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Metrics Row
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildModalBadge(Icons.timer_outlined, 'Est. Time', sub.duration),
                    Container(width: 1, height: 32, color: const Color(0xFFE2E8F0)),
                    _buildModalBadge(Icons.star_rounded, 'Rating', '${sub.rating} ★'),
                    Container(width: 1, height: 32, color: const Color(0xFFE2E8F0)),
                    _buildModalBadge(Icons.shield_outlined, 'Pros Near You', '${sub.prosCount}+ Online'),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Price & Action Button
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Starting from',
                        style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sub.startingPrice,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005AC2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultsScreen(
                              category: cat.title,
                              subService: sub.name,
                              initialPrice: sub.startingPrice,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005AC2),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Find Workers',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalBadge(IconData icon, String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF005AC2)),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _filteredCategories;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF005AC2), size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Categories',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          // Grid / List Mode Toggle
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: const Color(0xFF005AC2),
              size: 22,
            ),
            tooltip: _isGridView ? 'Switch to List' : 'Switch to Grid',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Search Bar & Header Strip in White Card
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
              child: Column(
                children: [
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      decoration: InputDecoration(
                        hintText: 'Search electric, plumbing, cleaning...',
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13.5),
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF005AC2), size: 22),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8), size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Horizontal Category Selector Pills (Always Visible)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = cat.id == _selectedCategoryId;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = cat.id;
                        });
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF005AC2).withValues(alpha: 0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              cat.icon,
                              size: 17,
                              color: isSelected ? Colors.white : cat.color,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              cat.title,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                color: isSelected ? Colors.white : const Color(0xFF334155),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // 3. Dynamic Content: Grid Mode vs Service List Mode
            Expanded(
              child: _isGridView
                  ? _buildCategoryGridView(categories)
                  : _buildSubServicesListView(_selectedCategory),
            ),
          ],
        ),
      ),
    );
  }

  // Grid View Mode: Shows all category cards
  Widget _buildCategoryGridView(List<CategoryItem> categories) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final cat = categories[index];
        final isSelected = cat.id == _selectedCategoryId;

        return InkWell(
          onTap: () {
            setState(() {
              _selectedCategoryId = cat.id;
              _isGridView = false; // Switch to detailed sub-services list on tap
            });
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                width: isSelected ? 1.8 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: cat.bgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Icon(cat.icon, color: cat.color, size: 24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${cat.subServices.length} items',
                        style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cat.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cat.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Detailed Sub-Services Mode for Selected Category
  Widget _buildSubServicesListView(CategoryItem activeCategory) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        // Active Category Premium Banner Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                activeCategory.bgColor,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: activeCategory.color.withValues(alpha: 0.25)),
            boxShadow: [
              BoxShadow(
                color: activeCategory.color.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(activeCategory.icon, color: activeCategory.color, size: 28),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${activeCategory.title} Services',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: activeCategory.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            activeCategory.bannerBadge,
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: activeCategory.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      activeCategory.tagline,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // List Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select a Service (${activeCategory.subServices.length})',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const Text(
              'Instant Booking Available',
              style: TextStyle(
                fontSize: 11.5,
                color: Color(0xFF10B981),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Service Items
        ...activeCategory.subServices.map((sub) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => _showSubServiceDetailModal(activeCategory, sub),
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Badge
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            sub.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (sub.badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFFECACA)),
                            ),
                            child: Text(
                              sub.badge!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDC2626),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Description
                    Text(
                      sub.description,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Highlight Pills
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: sub.highlights.take(2).map((h) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check, size: 12, color: Color(0xFF10B981)),
                              const SizedBox(width: 3),
                              Text(
                                h,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF475569),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // Bottom Row: Price, Est. Time, Rating & Book Button
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Starts at',
                              style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8)),
                            ),
                            Text(
                              sub.startingPrice,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005AC2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 14, color: Color(0xFF94A3B8)),
                            const SizedBox(width: 3),
                            Text(
                              sub.duration,
                              style: const TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, size: 15, color: Color(0xFFF59E0B)),
                            const SizedBox(width: 2),
                            Text(
                              sub.rating,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        // "Book Pro" Button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF005AC2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Book',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
