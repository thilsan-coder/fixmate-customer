import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/booking_service.dart';
import '../../../core/services/session_manager.dart';
import 'finding_workers_screen.dart';

class ServiceOption {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String estPrice;
  final String defaultWorkerName;
  final String defaultWorkerRole;
  final String defaultAvatar;
  final List<String> quickIssues;

  const ServiceOption({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.estPrice,
    required this.defaultWorkerName,
    required this.defaultWorkerRole,
    required this.defaultAvatar,
    required this.quickIssues,
  });
}

class BookServiceScreen extends StatefulWidget {
  final String? serviceName;
  final String? serviceSubtitle;
  final bool isCategoryFixed;

  const BookServiceScreen({
    super.key,
    this.serviceName,
    this.serviceSubtitle,
    this.isCategoryFixed = false,
  });

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  // All 16 Service Categories Available in FixMate
  final List<ServiceOption> _services = const [
    ServiceOption(
      name: 'Electrician',
      subtitle: 'Wiring, lights, fan & switches',
      icon: Icons.bolt_rounded,
      color: Color(0xFFD97706),
      estPrice: 'LKR 2,200',
      defaultWorkerName: 'Nuwan Silva',
      defaultWorkerRole: 'Master Electrician',
      defaultAvatar:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&fit=crop&q=80',
      quickIssues: [
        'Power Tripping ⚡',
        'Switch Sparking 🔌',
        'Light Not Working 💡',
        'Short Circuit ⚠️',
      ],
    ),
    ServiceOption(
      name: 'Plumber',
      subtitle: 'Pipes, leaks, taps & drainage',
      icon: Icons.plumbing_rounded,
      color: Color(0xFF0284C7),
      estPrice: 'LKR 2,000',
      defaultWorkerName: 'Nimal Perera',
      defaultWorkerRole: 'Certified Plumber',
      defaultAvatar:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&auto=format&fit=crop&q=80',
      quickIssues: [
        'Pipe Leaking 💧',
        'Drain Blocked 🛑',
        'Tap Broken 🚰',
        'Water Tank Overflow 🌊',
      ],
    ),
    ServiceOption(
      name: 'Carpenter',
      subtitle: 'Furniture, doors, locks & wood',
      icon: Icons.carpenter_rounded,
      color: Color(0xFF92400E),
      estPrice: 'LKR 2,100',
      defaultWorkerName: 'Sanath Jayasuriya',
      defaultWorkerRole: 'Certified Carpenter',
      defaultAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&fit=crop&q=80',
      quickIssues: [
        'Door Lock Jammed 🔑',
        'Cabinet Hinge Broken 🗄️',
        'Furniture Repair 🪑',
        'Drawer Slide Repair 🚪',
      ],
    ),
    ServiceOption(
      name: 'Painter',
      subtitle: 'Wall repainting & damp fix',
      icon: Icons.format_paint_rounded,
      color: Color(0xFFDB2777),
      estPrice: 'LKR 2,400',
      defaultWorkerName: 'Kasun Wickrama',
      defaultWorkerRole: 'Master Painter',
      defaultAvatar:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
      quickIssues: [
        'Wall Touch-up & Repaint 🎨',
        'Dampness / Peeling Fix 🌧️',
        'Door & Window Varnish 🚪',
        'Waterproof Coating 🛡️',
      ],
    ),
    ServiceOption(
      name: 'AC Repair',
      subtitle: 'Cooling, gas refill & clean',
      icon: Icons.ac_unit_rounded,
      color: Color(0xFF0891B2),
      estPrice: 'LKR 2,500',
      defaultWorkerName: 'Kamal Silva',
      defaultWorkerRole: 'AC Specialist',
      defaultAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
      quickIssues: [
        'Not Cooling ❄️',
        'Water Dripping 💧',
        'Gas Refill Needed 🔄',
        'Unusual Noise 🔊',
      ],
    ),
    ServiceOption(
      name: 'Mason',
      subtitle: 'Tile work, plaster & concrete',
      icon: Icons.foundation_rounded,
      color: Color(0xFFEA580C),
      estPrice: 'LKR 2,300',
      defaultWorkerName: 'Ravi Fernando',
      defaultWorkerRole: 'Experienced Mason',
      defaultAvatar:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
      quickIssues: [
        'Broken Tile Replacement 🧱',
        'Wall Plaster Cracks 🏗️',
        'Floor Waterproofing 💧',
      ],
    ),
    ServiceOption(
      name: 'Welder',
      subtitle: 'Gates, grills & metal repairs',
      icon: Icons.hardware_rounded,
      color: Color(0xFF4F46E5),
      estPrice: 'LKR 2,200',
      defaultWorkerName: 'Sarath Bandara',
      defaultWorkerRole: 'Fabrication Welder',
      defaultAvatar:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&fit=crop&q=80',
      quickIssues: [
        'Gate Hinge Broken 🚪',
        'Window Grill Welding ⛓️',
        'Metal Railing Fix 🔧',
      ],
    ),
    ServiceOption(
      name: 'Cleaning',
      subtitle: 'Full home deep clean & sofa',
      icon: Icons.cleaning_services_rounded,
      color: Color(0xFF10B981),
      estPrice: 'LKR 1,800',
      defaultWorkerName: 'Priya Fernando',
      defaultWorkerRole: 'Cleaning Specialist',
      defaultAvatar:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&fit=crop&q=80',
      quickIssues: [
        'Full House Deep Clean 🏠',
        'Kitchen & Bathroom 🧼',
        'Sofa & Carpet Wash 🛋️',
      ],
    ),
    ServiceOption(
      name: 'Appliance',
      subtitle: 'Washing machine, fridge & oven',
      icon: Icons.kitchen_rounded,
      color: Color(0xFFEC4899),
      estPrice: 'LKR 2,000',
      defaultWorkerName: 'Dinesh Bandara',
      defaultWorkerRole: 'Appliance Specialist',
      defaultAvatar:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
      quickIssues: [
        'Washing Machine Error 🌀',
        'Fridge Not Cold ❄️',
        'Microwave Heating Issue ♨️',
      ],
    ),
    ServiceOption(
      name: 'Roofing & Ceiling',
      subtitle: 'Ceiling leaks, sheets & gutters',
      icon: Icons.roofing_rounded,
      color: Color(0xFF059669),
      estPrice: 'LKR 2,600',
      defaultWorkerName: 'Ajith Kumara',
      defaultWorkerRole: 'Roofing Technician',
      defaultAvatar:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&fit=crop&q=80',
      quickIssues: [
        'Rain Water Leakage 🌧️',
        'Ceiling Board Damage 🏚️',
        'Gutter Cleaning & Fix 🚿',
      ],
    ),
    ServiceOption(
      name: 'Gardening & Lawn',
      subtitle: 'Lawn mow, tree trimming & weed',
      icon: Icons.yard_rounded,
      color: Color(0xFF16A34A),
      estPrice: 'LKR 1,800',
      defaultWorkerName: 'Gayan Dias',
      defaultWorkerRole: 'Landscape Gardener',
      defaultAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&fit=crop&q=80',
      quickIssues: [
        'Lawn Grass Cutting 🌱',
        'Tree Branch Trimming 🌳',
        'Garden Weeding & Mulch 🪴',
      ],
    ),
    ServiceOption(
      name: 'Pest Control',
      subtitle: 'Termite, bedbug & insect spray',
      icon: Icons.pest_control_rounded,
      color: Color(0xFFDC2626),
      estPrice: 'LKR 2,800',
      defaultWorkerName: 'Pradeep Silva',
      defaultWorkerRole: 'Pest Exterminator',
      defaultAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&fit=crop&q=80',
      quickIssues: [
        'Termite Wood Spray 🪵',
        'Bed Bug Treatment 🛏️',
        'Cockroach & Ant Defense 🐜',
      ],
    ),
    ServiceOption(
      name: 'CCTV & Security',
      subtitle: 'Camera install & smart lock setup',
      icon: Icons.videocam_rounded,
      color: Color(0xFF2563EB),
      estPrice: 'LKR 2,500',
      defaultWorkerName: 'Thilina Perera',
      defaultWorkerRole: 'Security Tech',
      defaultAvatar:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
      quickIssues: [
        'Camera Offline Fix 📹',
        'New CCTV Installation 🎥',
        'Smart Door Lock Setup 🔐',
      ],
    ),
    ServiceOption(
      name: 'Movers & Packers',
      subtitle: 'House shifting & heavy luggage',
      icon: Icons.local_shipping_rounded,
      color: Color(0xFF7C3AED),
      estPrice: 'LKR 3,500',
      defaultWorkerName: 'Kusal Mendis',
      defaultWorkerRole: 'Relocation Supervisor',
      defaultAvatar:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&fit=crop&q=80',
      quickIssues: [
        'Furniture Relocation 🚚',
        'Boxes & Packing Help 📦',
        'Heavy Appliance Moving 🛋️',
      ],
    ),
    ServiceOption(
      name: 'Vehicle Wash',
      subtitle: 'Doorstep car & bike detailing',
      icon: Icons.directions_car_rounded,
      color: Color(0xFF0284C7),
      estPrice: 'LKR 1,500',
      defaultWorkerName: 'Nadeem Khan',
      defaultWorkerRole: 'Auto Detailer',
      defaultAvatar:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&fit=crop&q=80',
      quickIssues: [
        'Full Exterior Foam Wash 🚗',
        'Interior Vacuum & Polish ✨',
        'Bike Detailing 🏍️',
      ],
    ),
    ServiceOption(
      name: 'Glass & Aluminium',
      subtitle: 'Partitions, windows & fittings',
      icon: Icons.window_rounded,
      color: Color(0xFF475569),
      estPrice: 'LKR 2,400',
      defaultWorkerName: 'Chamara Silva',
      defaultWorkerRole: 'Glass Specialist',
      defaultAvatar:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&fit=crop&q=80',
      quickIssues: [
        'Sliding Window Stuck 🪟',
        'Glass Partition Repair 🚪',
        'Aluminium Frame Fitting 🔨',
      ],
    ),
  ];

  late int _selectedServiceIndex;
  late bool _showCategorySelector;

  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  bool _isInstant = true;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  final List<String> _photos = [
    'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400&fit=crop&q=80',
    'https://images.unsplash.com/photo-1585909695284-32d2985ac9c0?w=400&fit=crop&q=80',
  ];

  final List<String> _samplePhotoPool = [
    'https://images.unsplash.com/photo-1504148455328-c376907d081c?w=400&fit=crop&q=80',
    'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400&fit=crop&q=80',
    'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=400&fit=crop&q=80',
    'https://images.unsplash.com/photo-1542013936693-884638332954?w=400&fit=crop&q=80',
  ];
  int _samplePhotoCounter = 0;

  @override
  void initState() {
    super.initState();

    // Determine initial service index
    int matchedIndex = 0;
    if (widget.serviceName != null && widget.serviceName!.isNotEmpty) {
      final query = widget.serviceName!.toLowerCase();
      final idx = _services.indexWhere((s) =>
          s.name.toLowerCase().contains(query) ||
          query.contains(s.name.toLowerCase()));
      if (idx >= 0) matchedIndex = idx;
    }

    _selectedServiceIndex = matchedIndex;

    // If isCategoryFixed == true (e.g. tapped "Electrician" in home or all-categories),
    // do not show the multi-category selector list! Show only the chosen locked category!
    _showCategorySelector = !widget.isCategoryFixed;

    _descriptionController = TextEditingController();
    _locationController =
        TextEditingController(text: 'No 24, Galle Road, Colombo 03');
    _nameController = TextEditingController(text: 'Alex Johnson');
    _phoneController = TextEditingController(text: '+94 77 123 4567');

    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final details = await SessionManager.getUserDetails();
    if (mounted) {
      setState(() {
        if (details['name'] != null && details['name']!.isNotEmpty) {
          _nameController.text = details['name']!;
        }
        if (details['phone'] != null && details['phone']!.isNotEmpty) {
          _phoneController.text = details['phone']!;
        }
        if (details['address'] != null && details['address']!.isNotEmpty) {
          _locationController.text = details['address']!;
        }
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _addPhotoFromModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Upload Problem Photo',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Take a clear photo of the damaged area or choose from gallery.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _appendSamplePhoto('Camera photo added');
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFBFDBFE)),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            color: Color(0xFF005AC2),
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Take Photo',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF005AC2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      _appendSamplePhoto('Gallery photo added');
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.photo_library_rounded,
                            color: Color(0xFF475569),
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Choose Gallery',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _appendSamplePhoto(String msg) {
    setState(() {
      final newUrl =
          _samplePhotoPool[_samplePhotoCounter % _samplePhotoPool.length];
      _photos.add(newUrl);
      _samplePhotoCounter++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF005AC2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(msg, style: GoogleFonts.inter(color: Colors.white)),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF334155),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content:
            Text('Photo removed', style: GoogleFonts.inter(color: Colors.white)),
        duration: const Duration(milliseconds: 1400),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitRequest() {
    final selectedService = _services[_selectedServiceIndex];
    final problemDesc = _descriptionController.text.trim().isNotEmpty
        ? _descriptionController.text.trim()
        : '${selectedService.name} service needed';
    final userAddress = _locationController.text.trim().isNotEmpty
        ? _locationController.text.trim()
        : '24, Galle Road, Colombo 03';

    // Register active booking in shared state
    BookingService.createActiveBooking(
      workerName: selectedService.defaultWorkerName,
      workerRole: selectedService.defaultWorkerRole,
      avatarUrl: selectedService.defaultAvatar,
      price: selectedService.estPrice,
      serviceName: selectedService.name,
      subServiceName: problemDesc,
      address: userAddress,
    );

    // Navigate to radar search screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FindingWorkersScreen(
          workerName: selectedService.defaultWorkerName,
          workerRole: selectedService.defaultWorkerRole,
          avatarUrl: selectedService.defaultAvatar,
          price: selectedService.estPrice,
          serviceName: selectedService.name,
          subServiceName: problemDesc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedService = _services[_selectedServiceIndex];
    final dateFormat = DateFormat('dd MMM yyyy');

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
              widget.isCategoryFixed
                  ? '${selectedService.name} Request'
                  : 'Request a Service',
              style: GoogleFonts.inter(
                color: const Color(0xFF0F172A),
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Instant on-demand booking',
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
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. SERVICE SELECTION SECTION
                    // IF category is fixed (user tapped e.g. "Electrician" in home/all-categories):
                    // Show ONLY the chosen category card! Do NOT show the full horizontal category list!
                    if (!_showCategorySelector) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1. Chosen Service',
                            style: GoogleFonts.inter(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _showCategorySelector = true;
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: Text(
                                'Change Service',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF005AC2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: const Color(0xFF005AC2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF005AC2)
                                  .withValues(alpha: 0.08),
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
                                color: selectedService.color
                                    .withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                selectedService.icon,
                                color: selectedService.color,
                                size: 28,
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
                                        selectedService.name,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDCFCE7),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'SELECTED',
                                          style: GoogleFonts.inter(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF16A34A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    selectedService.subtitle,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Est. ${selectedService.estPrice}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF005AC2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Coming from Bookings '+' button:
                      // Show ALL 16 service categories to freely choose!
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1. Select Service (${_services.length} Available)',
                            style: GoogleFonts.inter(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Est. ${selectedService.estPrice}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF005AC2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 104,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _services.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final service = _services[index];
                            final isSelected = _selectedServiceIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedServiceIndex = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 96,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF005AC2)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF005AC2)
                                        : const Color(0xFFE2E8F0),
                                    width: isSelected ? 1.8 : 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isSelected
                                          ? const Color(0xFF005AC2)
                                              .withValues(alpha: 0.25)
                                          : Colors.black.withValues(alpha: 0.02),
                                      blurRadius: isSelected ? 10 : 4,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white.withValues(alpha: 0.2)
                                            : service.color
                                                .withValues(alpha: 0.12),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        service.icon,
                                        color: isSelected
                                            ? Colors.white
                                            : service.color,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      service.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: isSelected
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1E293B),
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

                    const SizedBox(height: 24),

                    // 2. DESCRIBE PROBLEM SECTION
                    Text(
                      '2. Describe Your Problem',
                      style: GoogleFonts.inter(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Quick problem suggestion chips for active service
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedService.quickIssues.map((issue) {
                        return ActionChip(
                          onPressed: () {
                            setState(() {
                              _descriptionController.text = issue;
                            });
                          },
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          label: Text(
                            issue,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
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
                        controller: _descriptionController,
                        maxLines: 3,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(0xFF0F172A),
                          height: 1.4,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Describe what needs fixing for ${selectedService.name}...',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 13.5,
                            color: const Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 3. UPLOAD PROBLEM PHOTOS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '3. Upload Problem Photos',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          '${_photos.length} attached',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          // "+ Add Photo" dashed button
                          InkWell(
                            onTap: _addPhotoFromModal,
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFF005AC2),
                                  style: BorderStyle.solid,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Color(0xFF005AC2),
                                    size: 26,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '+ Add',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF005AC2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Uploaded photo thumbnails with delete button
                          ...List.generate(_photos.length, (index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      _photos[index],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Container(
                                        color: const Color(0xFFE2E8F0),
                                        child: const Icon(
                                          Icons.broken_image_rounded,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Red delete cross button
                                Positioned(
                                  top: -4,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: () => _removePhoto(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEF4444),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 4. AUTO-LOADED CUSTOMER & LOCATION DETAILS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '4. Your Details (Auto-filled)',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFF16A34A),
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'GPS Verified',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF16A34A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Name & Phone row
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEFF6FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Color(0xFF005AC2),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _nameController.text,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      _phoneController.text,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Primary User',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child:
                                Divider(height: 1, color: Color(0xFFF1F5F9)),
                          ),
                          // Address Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFEF3C7),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xFFD97706),
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Service Location',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    TextField(
                                      controller: _locationController,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F172A),
                                      ),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_location_alt_rounded,
                                  color: Color(0xFF005AC2),
                                  size: 20,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Location can be edited directly',
                                        style: GoogleFonts.inter(),
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 5. TIMING: INSTANT VS SCHEDULE
                    Text(
                      '5. Service Timing',
                      style: GoogleFonts.inter(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isInstant = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: _isInstant
                                    ? const Color(0xFFEFF6FF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _isInstant
                                      ? const Color(0xFF005AC2)
                                      : const Color(0xFFE2E8F0),
                                  width: _isInstant ? 1.8 : 1.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.bolt_rounded,
                                    color: _isInstant
                                        ? const Color(0xFF005AC2)
                                        : const Color(0xFF64748B),
                                    size: 22,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Instant (15-30m)',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: _isInstant
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                      color: _isInstant
                                          ? const Color(0xFF005AC2)
                                          : const Color(0xFF334155),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isInstant = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: !_isInstant
                                    ? const Color(0xFFEFF6FF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: !_isInstant
                                      ? const Color(0xFF005AC2)
                                      : const Color(0xFFE2E8F0),
                                  width: !_isInstant ? 1.8 : 1.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    color: !_isInstant
                                        ? const Color(0xFF005AC2)
                                        : const Color(0xFF64748B),
                                    size: 22,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Schedule Later',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: !_isInstant
                                          ? FontWeight.w800
                                          : FontWeight.w600,
                                      color: !_isInstant
                                          ? const Color(0xFF005AC2)
                                          : const Color(0xFF334155),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (!_isInstant) ...[
                      const SizedBox(height: 12),
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: _pickDate,
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      dateFormat.format(_selectedDate),
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 1,
                                height: 30,
                                color: const Color(0xFFE2E8F0)),
                            Expanded(
                              child: InkWell(
                                onTap: _pickTime,
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedTime.format(context),
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.access_time_rounded,
                                        color: Color(0xFF64748B),
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // 6. STICKY BOTTOM SUBMIT BUTTON
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005AC2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.radar_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Find Nearby Workers',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
