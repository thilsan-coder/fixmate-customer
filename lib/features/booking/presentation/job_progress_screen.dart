import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../chat/presentation/chat_screen.dart';
import '../../payment/presentation/payment_screen.dart';

class JobProgressScreen extends StatefulWidget {
  final String workerName;
  final String workerRole;
  final String avatarUrl;
  final double rating;
  final int reviewsCount;
  final String price;
  final String serviceName;
  final String? subServiceName;

  const JobProgressScreen({
    super.key,
    this.workerName = 'Nuwan Silva',
    this.workerRole = 'Master Electrician',
    this.avatarUrl = 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&fit=crop&q=80',
    this.rating = 4.9,
    this.reviewsCount = 156,
    this.price = 'LKR 2,000',
    this.serviceName = 'Electrician',
    this.subServiceName,
  });

  @override
  State<JobProgressScreen> createState() => _JobProgressScreenState();
}

class _JobProgressScreenState extends State<JobProgressScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTimeString = '00:00:01';

  int _currentMilestoneIndex = 1; // Step 1 is done, Step 2 is active

  late List<Map<String, dynamic>> _milestones;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final timeFormatted =
        '${now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour)}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';

    _milestones = [
      {
        'title': 'Worker Arrived & Work Started',
        'isDone': true,
        'time': timeFormatted
      },
      {
        'title': 'Diagnosis & Problem Area Inspection',
        'isDone': false,
        'time': 'In Progress'
      },
      {
        'title': 'Active Repair & Component Replacement',
        'isDone': false,
        'time': 'Pending'
      },
      {
        'title': 'Voltage, Safety & Quality Check',
        'isDone': false,
        'time': 'Pending'
      },
      {
        'title': 'Work Finished & Customer Handover',
        'isDone': false,
        'time': 'Pending'
      },
    ];

    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      final totalSeconds = _stopwatch.elapsed.inSeconds;
      final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
      final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
      final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
      setState(() {
        _elapsedTimeString = '$hours:$minutes:$seconds';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _updateMilestoneStatus() {
    setState(() {
      final now = DateTime.now();
      final timeFormatted =
          '${now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour)}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';

      if (_currentMilestoneIndex < _milestones.length) {
        _milestones[_currentMilestoneIndex]['isDone'] = true;
        _milestones[_currentMilestoneIndex]['time'] = timeFormatted;
        _currentMilestoneIndex++;

        if (_currentMilestoneIndex < _milestones.length) {
          _milestones[_currentMilestoneIndex]['time'] = 'In Progress';
        }
      }
    });
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
                'Calling ${widget.workerName}...',
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

  void _showAddPartDialog() {
    final nameController = TextEditingController();
    final costController = TextEditingController();

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
                const SizedBox(height: 16),
                const Text(
                  'Add Extra Part / Material',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'If pro used spare parts, record the amount to invoice',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Part Name (e.g. 16A Trip Switch, 2m Pipe)',
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cost (LKR)',
                    prefixText: 'LKR ',
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Spare part successfully added to live bill'),
                          backgroundColor: Color(0xFF16A34A),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005AC2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Add to Invoice', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _finishWork() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          workerName: widget.workerName,
          workerRole: widget.workerRole,
          avatarUrl: widget.avatarUrl,
          price: widget.price,
          serviceName: widget.serviceName,
          subServiceName: widget.subServiceName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAllCompleted = _currentMilestoneIndex >= _milestones.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 24),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        centerTitle: false,
        title: Text(
          'Live Service Status',
          style: GoogleFonts.inter(
            color: const Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isAllCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isAllCompleted ? const Color(0xFF86EFAC) : const Color(0xFFBFDBFE),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isAllCompleted ? const Color(0xFF16A34A) : const Color(0xFF005AC2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  isAllCompleted ? 'WORK FINISHED' : 'IN PROGRESS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isAllCompleted ? const Color(0xFF166534) : const Color(0xFF005AC2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Live Time Counter Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isAllCompleted
                              ? [const Color(0xFF16A34A), const Color(0xFF15803D)]
                              : [const Color(0xFF005AC2), const Color(0xFF003E8A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: (isAllCompleted
                                    ? const Color(0xFF16A34A)
                                    : const Color(0xFF005AC2))
                                .withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isAllCompleted
                                          ? Icons.check_circle_rounded
                                          : Icons.timer_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isAllCompleted ? 'Total Work Duration' : 'Active Job Timer',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isAllCompleted ? 'Finished' : 'Live Synchronized',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _elapsedTimeString,
                            style: GoogleFonts.inter(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Service: ${widget.subServiceName ?? widget.serviceName}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 2. Active Worker Info Card with Call / Chat
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.avatarUrl,
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person, color: Color(0xFF005AC2), size: 30),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                                    const Icon(Icons.verified_rounded, color: Color(0xFF005AC2), size: 16),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.workerRole,
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
                                    workerName: widget.workerName,
                                    workerRole: widget.workerRole,
                                    avatarUrl: widget.avatarUrl,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 3. Work Stages & Checklist
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Live Job Milestones',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.2,
                          ),
                        ),
                        Text(
                          isAllCompleted
                              ? '5 of 5 Completed'
                              : 'Step ${_currentMilestoneIndex + 1} of 5',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isAllCompleted
                                ? const Color(0xFF16A34A)
                                : const Color(0xFF005AC2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: List.generate(_milestones.length, (index) {
                          final item = _milestones[index];
                          final bool isDone = item['isDone'] == true;
                          final bool isCurrent = !isDone && index == _currentMilestoneIndex;

                          return GestureDetector(
                            onTap: () {
                              if (!isDone && index == _currentMilestoneIndex) {
                                _updateMilestoneStatus();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: isDone
                                          ? const Color(0xFF16A34A)
                                          : isCurrent
                                              ? const Color(0xFF005AC2)
                                              : const Color(0xFFE2E8F0),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        isDone
                                            ? Icons.check
                                            : isCurrent
                                                ? Icons.sync_rounded
                                                : Icons.circle,
                                        color: isDone || isCurrent
                                            ? Colors.white
                                            : const Color(0xFFCBD5E1),
                                        size: isDone ? 15 : (isCurrent ? 14 : 10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: isCurrent || isDone
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            color: isDone
                                                ? const Color(0xFF0F172A)
                                                : isCurrent
                                                    ? const Color(0xFF005AC2)
                                                    : const Color(0xFF94A3B8),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item['time'],
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight:
                                                isCurrent ? FontWeight.bold : FontWeight.normal,
                                            color: isDone
                                                ? const Color(0xFF16A34A)
                                                : isCurrent
                                                    ? const Color(0xFF005AC2)
                                                    : const Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isCurrent)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFF6FF),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Active',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF005AC2),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 4. Billing Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Payment & Billing',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: _showAddPartDialog,
                                icon: const Icon(Icons.add_rounded, size: 16, color: Color(0xFF005AC2)),
                                label: const Text(
                                  'Add Parts',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF005AC2)),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Agreed Standard Fee', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                              Text(widget.price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Platform Safety Fee', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                              Text('FREE', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Amount Payable', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                              Text(widget.price, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF005AC2))),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Action Bar: Update Status or Work Done
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 14,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isAllCompleted ? _finishWork : _updateMilestoneStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAllCompleted
                        ? const Color(0xFF16A34A)
                        : const Color(0xFF005AC2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isAllCompleted
                            ? Icons.check_circle_rounded
                            : Icons.update_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isAllCompleted
                            ? 'Work Done • Proceed to Pay'
                            : 'Update Status (Step ${_currentMilestoneIndex + 1} of 5)',
                        style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold),
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
