import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/session_manager.dart';
import '../../../core/services/booking_service.dart';
import '../../../core/widgets/fix_mate_bottom_nav.dart';
import '../../chat/presentation/chat_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name = 'Alex Johnson';
  String _email = 'alex.johnson@fixmate.lk';
  String _phone = '+94 77 123 4567';
  String _address = '24, Galle Road, Colombo 03';
  String _avatarUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop&q=80';
  int _walletBalance = 2500;
  bool _notificationsEnabled = true;
  bool _biometricsEnabled = false;

  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'AC Repair Booking #BK-9021',
      'date': 'Yesterday, 04:30 PM',
      'amount': -3500,
      'isCredit': false,
      'icon': Icons.home_repair_service_rounded,
      'color': Color(0xFFEF4444),
    },
    {
      'title': 'FixMate Welcome Bonus',
      'date': '05 Oct, 11:20 AM',
      'amount': 1000,
      'isCredit': true,
      'icon': Icons.card_giftcard_rounded,
      'color': Color(0xFF16A34A),
    },
    {
      'title': 'Wallet Top-up (Visa)',
      'date': '02 Oct, 09:15 AM',
      'amount': 2500,
      'isCredit': true,
      'icon': Icons.account_balance_wallet_rounded,
      'color': Color(0xFF005AC2),
    },
  ];

  final List<String> _avatarOptions = [
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300&auto=format&fit=crop&q=80',
  ];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final details = await SessionManager.getUserDetails();
    if (mounted) {
      setState(() {
        _name = details['name'] ?? 'Alex Johnson';
        _email = details['email'] ?? 'alex.johnson@fixmate.lk';
        _phone = details['phone'] ?? '+94 77 123 4567';
        _address = details['address'] ?? '24, Galle Road, Colombo 03';
        _avatarUrl = details['avatarUrl'] ?? _avatarOptions.first;
      });
    }
  }

  // Edit Profile Modal
  void _openEditProfileDialog() {
    final nameCtrl = TextEditingController(text: _name);
    final emailCtrl = TextEditingController(text: _email);
    final phoneCtrl = TextEditingController(text: _phone);
    final addressCtrl = TextEditingController(text: _address);
    String selectedAvatar = _avatarUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 20,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Profile Details',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Avatar Picker Strip
                    const Text(
                      'Choose Avatar',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 56,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _avatarOptions.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final opt = _avatarOptions[index];
                          final isSel = opt == selectedAvatar;
                          return GestureDetector(
                            onTap: () => setSheetState(() => selectedAvatar = opt),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSel ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                                  width: isSel ? 2.5 : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(opt, width: 48, height: 48, fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Full Name Input
                    _buildInputField('Full Name', Icons.person_outline_rounded, nameCtrl),
                    const SizedBox(height: 12),

                    // Email Input
                    _buildInputField('Email Address', Icons.email_outlined, emailCtrl, keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 12),

                    // Phone Input
                    _buildInputField('Phone Number', Icons.phone_outlined, phoneCtrl, keyboardType: TextInputType.phone),
                    const SizedBox(height: 12),

                    // Address Input
                    _buildInputField('Service Address', Icons.location_on_outlined, addressCtrl),
                    const SizedBox(height: 20),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final navigator = Navigator.of(context);
                          await SessionManager.updateProfile(
                            name: nameCtrl.text.trim(),
                            email: emailCtrl.text.trim(),
                            phone: phoneCtrl.text.trim(),
                            address: addressCtrl.text.trim(),
                            avatarUrl: selectedAvatar,
                          );
                          if (mounted) {
                            setState(() {
                              _name = nameCtrl.text.trim();
                              _email = emailCtrl.text.trim();
                              _phone = phoneCtrl.text.trim();
                              _address = addressCtrl.text.trim();
                              _avatarUrl = selectedAvatar;
                            });
                            navigator.pop();
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text('Profile updated successfully! ✨'),
                                backgroundColor: Color(0xFF16A34A),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF005AC2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Save Changes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInputField(String label, IconData icon, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF005AC2), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Top Up Wallet Sheet (Modern Fintech Design)
  void _openWalletTopUpSheet() {
    final amountCtrl = TextEditingController(text: '1000');
    int selectedPreset = 1000;
    String selectedMethod = 'Visa (•••• 4242)';

    final paymentMethods = [
      {
        'id': 'visa',
        'name': 'Visa (•••• 4242)',
        'subtitle': 'Primary Debit Card',
        'icon': Icons.credit_card_rounded,
        'color': const Color(0xFF1E3A8A),
      },
      {
        'id': 'frimi',
        'name': 'FriMi / Genie',
        'subtitle': 'Instant Mobile Wallet',
        'icon': Icons.smartphone_rounded,
        'color': const Color(0xFF0D9488),
      },
      {
        'id': 'bank',
        'name': 'Commercial Bank / BOC',
        'subtitle': 'JustPay Direct Bank',
        'icon': Icons.account_balance_rounded,
        'color': const Color(0xFFD97706),
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.88,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: EdgeInsets.only(bottom: keyboardHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  const SizedBox(height: 12),
                  Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Header with Title and Close
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FixMate Wallet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B), size: 22),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 20, color: Color(0xFFF1F5F9)),

                  // Scrollable content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Digital FixMate Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0A2540), Color(0xFF005AC2), Color(0xFF2563EB)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF005AC2).withValues(alpha: 0.35),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.shield_rounded, color: Colors.white, size: 14),
                                          SizedBox(width: 4),
                                          Text(
                                            'FixMate Pay',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.contactless_rounded, color: Colors.white70, size: 22),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  'AVAILABLE BALANCE',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'LKR $_walletBalance.00',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _name.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const Text(
                                      'ID: #FM-7842',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 2. Promotional Offer Chip
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFFDE68A)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.bolt_rounded, color: Color(0xFFD97706), size: 20),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Top-up LKR 2,500+ and get instant 5% cashback on your next repair!',
                                    style: TextStyle(
                                      color: Color(0xFF92400E),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // 3. Amount selection label
                          const Text(
                            'ENTER OR CHOOSE TOP-UP AMOUNT',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Custom Amount TextField
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                            child: Row(
                              children: [
                                const Text(
                                  'LKR',
                                  style: TextStyle(
                                    color: Color(0xFF005AC2),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    controller: amountCtrl,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Enter amount',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
                                    ),
                                    onChanged: (val) {
                                      final parsed = int.tryParse(val) ?? 0;
                                      setSheetState(() {
                                        selectedPreset = parsed;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Preset chips row
                          Row(
                            children: [500, 1000, 2500, 5000].map((amt) {
                              final isSel = selectedPreset == amt;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3),
                                  child: InkWell(
                                    onTap: () {
                                      setSheetState(() {
                                        selectedPreset = amt;
                                        amountCtrl.text = amt.toString();
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 150),
                                      padding: const EdgeInsets.symmetric(vertical: 9),
                                      decoration: BoxDecoration(
                                        color: isSel ? const Color(0xFF005AC2) : const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSel ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '+$amt',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: isSel ? Colors.white : const Color(0xFF334155),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 22),

                          // 4. Payment Method label
                          const Text(
                            'PAYMENT METHOD',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Payment Methods list
                          ...paymentMethods.map((pm) {
                            final isSel = selectedMethod == pm['name'];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  setSheetState(() {
                                    selectedMethod = pm['name'] as String;
                                  });
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSel ? const Color(0xFFF0F7FF) : const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSel ? const Color(0xFF005AC2) : const Color(0xFFE2E8F0),
                                      width: isSel ? 1.5 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: (pm['color'] as Color).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Icon(pm['icon'] as IconData, color: pm['color'] as Color, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pm['name'] as String,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1E293B),
                                              ),
                                            ),
                                            Text(
                                              pm['subtitle'] as String,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFF64748B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        isSel ? Icons.check_circle_rounded : Icons.radio_button_off_rounded,
                                        color: isSel ? const Color(0xFF005AC2) : const Color(0xFFCBD5E1),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 16),

                          // 5. Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                final amt = int.tryParse(amountCtrl.text) ?? 0;
                                if (amt <= 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please enter a valid amount to top up!'),
                                      backgroundColor: Color(0xFFDC2626),
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  _walletBalance += amt;
                                  _transactions.insert(0, {
                                    'title': 'Wallet Top-up ($selectedMethod)',
                                    'date': 'Just now',
                                    'amount': amt,
                                    'isCredit': true,
                                    'icon': Icons.add_circle_outline_rounded,
                                    'color': const Color(0xFF16A34A),
                                  });
                                });

                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            'LKR $amt added to FixMate Wallet! New Balance: LKR $_walletBalance 🎉',
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: const Color(0xFF16A34A),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0047AB),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_card_rounded, size: 20),
                                  const SizedBox(width: 8),
                                  Text('Top Up LKR ${amountCtrl.text.isEmpty ? "0" : amountCtrl.text} Now'),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // 6. Recent Transactions List
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'RECENT TRANSACTIONS',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${_transactions.length} Records',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _transactions.length,
                            separatorBuilder: (context, idx) => const Divider(height: 12, color: Color(0xFFF1F5F9)),
                            itemBuilder: (context, idx) {
                              final tx = _transactions[idx];
                              final isCredit = tx['isCredit'] as bool;
                              final amountVal = tx['amount'] as int;

                              return Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (tx['color'] as Color).withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(tx['icon'] as IconData, color: tx['color'] as Color, size: 18),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tx['title'] as String,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          tx['date'] as String,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${isCredit ? "+" : "-"} LKR ${amountVal.abs()}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: isCredit ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Logout Handler
  Future<void> _handleLogout() async {
    final confirm = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top drag bar
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),

              // Glowing Red Logout Icon Container
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFECACA), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFDC2626),
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'You will need to sign in again with your phone number to access your bookings, live tracking and wallet balance.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Account card preview
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        _avatarUrl,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, color: Color(0xFF005AC2)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name,
                            style: GoogleFonts.inter(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            _phone,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.lock_outline_rounded, size: 12, color: Color(0xFF005AC2)),
                          SizedBox(width: 3),
                          Text('Secured', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF005AC2))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons: Cancel vs Logout
              Row(
                children: [
                  // Cancel / Keep Logged In
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Confirm Logout
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context, true),
                        icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                        label: Text(
                          'Yes, Log Out',
                          style: GoogleFonts.inter(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          elevation: 2,
                          shadowColor: const Color(0xFFDC2626).withValues(alpha: 0.3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (confirm == true) {
      await SessionManager.logout();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final allBookings = BookingService.bookings;
    final activeBookingsCount = allBookings.where((b) => b.status == BookingStatus.inProgress).length;
    final completedCount = allBookings.where((b) => b.status == BookingStatus.completed).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: AppColors.primary,
            size: 26,
          ),
          onPressed: () {},
        ),
        centerTitle: false,
        title: Text(
          'FixMate',
          style: GoogleFonts.inter(
            color: AppColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.primary, size: 24),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined, color: AppColors.primary, size: 22),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.helpAndSupport),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Customer Profile Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF003E8A), Color(0xFF005AC2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF005AC2).withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Avatar with Edit Badge
                        GestureDetector(
                          onTap: _openEditProfileDialog,
                          child: Stack(
                            children: [
                              Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2.5),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    _avatarUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.person, color: Colors.white, size: 36),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.edit, color: Color(0xFF005AC2), size: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Name, Email, Badge
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      _name,
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.verified_rounded, color: Color(0xFF60A5FA), size: 18),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _email,
                                style: const TextStyle(fontSize: 12, color: Colors.white70),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _phone,
                                style: const TextStyle(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Edit Profile Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: _openEditProfileDialog,
                        icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF0047AB)),
                        label: const Text('Edit Personal Info', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0047AB),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // 2. Quick Account Statistics Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'All Bookings',
                      value: '${allBookings.length}',
                      subtitle: '$completedCount Completed',
                      icon: Icons.calendar_month_rounded,
                      color: const Color(0xFF005AC2),
                      bgColor: const Color(0xFFEFF6FF),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.bookingsList),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Active Jobs',
                      value: '$activeBookingsCount',
                      subtitle: activeBookingsCount > 0 ? 'In Progress' : 'No active',
                      icon: Icons.bolt_rounded,
                      color: const Color(0xFF16A34A),
                      bgColor: const Color(0xFFDCFCE7),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.bookingsList),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Wallet',
                      value: 'Rs. $_walletBalance',
                      subtitle: 'Top Up',
                      icon: Icons.wallet_rounded,
                      color: const Color(0xFFD97706),
                      bgColor: const Color(0xFFFEF3C7),
                      onTap: _openWalletTopUpSheet,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // 3. Section: Account & Services
              _buildSectionTitle('ACCOUNT & SERVICES'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'Saved Addresses',
                      subtitle: _address,
                      onTap: _openEditProfileDialog,
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Icons.credit_card_rounded,
                      title: 'Payment Methods & Cards',
                      subtitle: 'Visa •••• 4242 & Cash',
                      onTap: () => Navigator.pushNamed(context, AppRoutes.paymentHistory),
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Icons.receipt_long_rounded,
                      title: 'Invoices & Receipts',
                      subtitle: 'Download past service receipts',
                      onTap: () => Navigator.pushNamed(context, AppRoutes.paymentHistory),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 4. Section: App Preferences
              _buildSectionTitle('PREFERENCES & SETTINGS'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.language_rounded,
                      title: 'Language Preference',
                      subtitle: 'English (US)',
                      onTap: () => Navigator.pushNamed(context, AppRoutes.selectLanguage),
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Icons.public_rounded,
                      title: 'Country & City',
                      subtitle: 'Sri Lanka • Colombo',
                      onTap: () => Navigator.pushNamed(context, AppRoutes.selectCountry),
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.notifications_active_outlined, color: Color(0xFF005AC2), size: 20),
                      ),
                      title: const Text('Push Notifications', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      subtitle: const Text('Booking updates and alerts', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                      trailing: Switch.adaptive(
                        value: _notificationsEnabled,
                        activeTrackColor: const Color(0xFF005AC2),
                        onChanged: (val) => setState(() => _notificationsEnabled = val),
                      ),
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.fingerprint_rounded, color: Color(0xFF005AC2), size: 20),
                      ),
                      title: const Text('Biometric / Fast Login', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      subtitle: const Text('Fingerprint / Face ID unlock', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                      trailing: Switch.adaptive(
                        value: _biometricsEnabled,
                        activeTrackColor: const Color(0xFF005AC2),
                        onChanged: (val) => setState(() => _biometricsEnabled = val),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 5. Section: Support & Legal
              _buildSectionTitle('SUPPORT & SECURITY'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.support_agent_rounded,
                      title: '24/7 FixMate Support Desk',
                      subtitle: 'Chat live with customer care',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(
                              workerName: 'FixMate Support',
                              workerRole: 'Official Help Desk',
                              avatarUrl:
                                  'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&fit=crop&q=80',
                              serviceName: 'Customer Support 24/7',
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center & FAQs',
                      subtitle: 'Frequently asked questions',
                      onTap: () => Navigator.pushNamed(context, AppRoutes.helpAndSupport),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 6. Logout Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _handleLogout,
                  icon: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626), size: 20),
                  label: const Text(
                    'Log Out from FixMate',
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFECACA), width: 1.5),
                    backgroundColor: const Color(0xFFFEF2F2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'FixMate App v2.4.0 (Build 2026) • All Rights Reserved',
                  style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                ),
              ),
            ],
          ),
        ),
      ),

      // 7. Unified Bottom Navigation Bar
      bottomNavigationBar: const FixMateBottomNav(
        currentIndex: 3,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF64748B),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF005AC2), size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
    );
  }
}
