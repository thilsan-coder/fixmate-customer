import 'package:flutter/material.dart';

enum BookingStatus { inProgress, scheduled, completed }

class BookingItem {
  final String id;
  final String title;
  final String time;
  final String date;
  final String address;
  final String workerName;
  final String workerRole;
  final String workerAvatarUrl;
  final IconData serviceIcon;
  final String price;
  final String laborCharge;
  final String platformFee;
  final String materialsCost;
  final BookingStatus status;
  final String statusText;
  final double rating;
  final String? reviewNote;
  final List<String> tags;

  const BookingItem({
    required this.id,
    required this.title,
    required this.time,
    this.date = 'Today',
    this.address = '24, Galle Road, Colombo 03',
    required this.workerName,
    required this.workerRole,
    required this.workerAvatarUrl,
    required this.serviceIcon,
    required this.price,
    this.laborCharge = 'LKR 1,800',
    this.platformFee = 'LKR 200',
    this.materialsCost = 'LKR 0',
    required this.status,
    required this.statusText,
    this.rating = 5.0,
    this.reviewNote,
    this.tags = const [],
  });

  BookingItem copyWith({
    String? id,
    String? title,
    String? time,
    String? date,
    String? address,
    String? workerName,
    String? workerRole,
    String? workerAvatarUrl,
    IconData? serviceIcon,
    String? price,
    String? laborCharge,
    String? platformFee,
    String? materialsCost,
    BookingStatus? status,
    String? statusText,
    double? rating,
    String? reviewNote,
    List<String>? tags,
  }) {
    return BookingItem(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      date: date ?? this.date,
      address: address ?? this.address,
      workerName: workerName ?? this.workerName,
      workerRole: workerRole ?? this.workerRole,
      workerAvatarUrl: workerAvatarUrl ?? this.workerAvatarUrl,
      serviceIcon: serviceIcon ?? this.serviceIcon,
      price: price ?? this.price,
      laborCharge: laborCharge ?? this.laborCharge,
      platformFee: platformFee ?? this.platformFee,
      materialsCost: materialsCost ?? this.materialsCost,
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      rating: rating ?? this.rating,
      reviewNote: reviewNote ?? this.reviewNote,
      tags: tags ?? this.tags,
    );
  }
}

class BookingService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  static final List<BookingItem> _bookings = [
    const BookingItem(
      id: 'BK-1001',
      title: 'Home Deep Cleaning',
      time: 'Today, 10:30 AM',
      date: 'Today',
      address: '24, Galle Road, Colombo 03',
      workerName: 'Marcus Chen',
      workerRole: 'Cleaning Specialist',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&fit=crop&q=80',
      serviceIcon: Icons.cleaning_services_rounded,
      price: 'LKR 3,500',
      laborCharge: 'LKR 3,200',
      platformFee: 'LKR 300',
      materialsCost: 'LKR 0',
      status: BookingStatus.inProgress,
      statusText: 'IN PROGRESS',
    ),
    const BookingItem(
      id: 'BK-1002',
      title: 'Pipe Repair & Leak Fix',
      time: 'Tomorrow, 02:00 PM',
      date: 'Tomorrow',
      address: '45/2, Alfred House Gardens, Colombo 03',
      workerName: 'David Wilson',
      workerRole: 'Licensed Plumber',
      workerAvatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&fit=crop&q=80',
      serviceIcon: Icons.plumbing_rounded,
      price: 'LKR 2,200',
      laborCharge: 'LKR 1,900',
      platformFee: 'LKR 300',
      materialsCost: 'LKR 0',
      status: BookingStatus.scheduled,
      statusText: 'SCHEDULED',
    ),
    const BookingItem(
      id: 'BK-1003',
      title: 'Light & Fan Installation',
      time: 'Oct 24, 09:00 AM',
      date: '24 Oct 2024',
      address: '12/B, Duplication Road, Colombo 04',
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
      reviewNote: 'Outstanding service and very polite! Solved the tripping breaker issue fast.',
      tags: ['On Time ⏱️', 'Clean Work 🧹', 'Expert Service 🛠️'],
    ),
  ];

  static List<BookingItem> get bookings => List.unmodifiable(_bookings);

  static IconData getIconForService(String serviceName) {
    final lowerService = serviceName.toLowerCase();
    if (lowerService.contains('electr')) {
      return Icons.electrical_services_rounded;
    } else if (lowerService.contains('plumb')) {
      return Icons.plumbing_rounded;
    } else if (lowerService.contains('clean')) {
      return Icons.cleaning_services_rounded;
    } else if (lowerService.contains('paint')) {
      return Icons.format_paint_rounded;
    } else if (lowerService.contains('ac') || lowerService.contains('air')) {
      return Icons.ac_unit_rounded;
    } else if (lowerService.contains('carpenter') || lowerService.contains('wood')) {
      return Icons.handyman_rounded;
    } else if (lowerService.contains('mason') || lowerService.contains('tile')) {
      return Icons.foundation_rounded;
    } else if (lowerService.contains('garden')) {
      return Icons.yard_rounded;
    }
    return Icons.build_rounded;
  }

  static BookingItem createActiveBooking({
    required String workerName,
    required String workerRole,
    required String avatarUrl,
    required String price,
    required String serviceName,
    String? subServiceName,
    String address = '24, Galle Road, Colombo 03',
  }) {
    final now = DateTime.now();
    final timeStr = 'Today, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final id = 'BK-${now.millisecondsSinceEpoch.toString().substring(7)}';

    final newBooking = BookingItem(
      id: id,
      title: subServiceName ?? (serviceName.contains('Service') ? serviceName : '$serviceName Service'),
      time: timeStr,
      date: 'Today',
      address: address,
      workerName: workerName,
      workerRole: workerRole,
      workerAvatarUrl: avatarUrl,
      serviceIcon: getIconForService(serviceName),
      price: price,
      laborCharge: price,
      platformFee: 'FREE',
      materialsCost: 'LKR 0',
      status: BookingStatus.inProgress,
      statusText: 'IN PROGRESS',
    );

    _bookings.removeWhere((item) => item.workerName == workerName && item.status == BookingStatus.inProgress);
    _bookings.insert(0, newBooking);
    return newBooking;
  }

  static void completeBooking({
    required String workerName,
    required String workerRole,
    required String avatarUrl,
    required String price,
    required String serviceName,
    required double rating,
    required String reviewNote,
    List<String> tags = const [],
    String address = '24, Galle Road, Colombo 03',
  }) {
    final now = DateTime.now();
    final timeStr = 'Today, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    // Remove any active booking with same worker name
    _bookings.removeWhere((item) => item.workerName == workerName);

    final completedBooking = BookingItem(
      id: 'BK-${now.millisecondsSinceEpoch.toString().substring(7)}',
      title: serviceName.contains('Service') ? serviceName : '$serviceName Service',
      time: timeStr,
      date: 'Today',
      address: address,
      workerName: workerName,
      workerRole: workerRole,
      workerAvatarUrl: avatarUrl,
      serviceIcon: getIconForService(serviceName),
      price: price,
      laborCharge: price,
      platformFee: 'FREE',
      materialsCost: 'LKR 0',
      status: BookingStatus.completed,
      statusText: 'COMPLETED',
      rating: rating,
      reviewNote: reviewNote,
      tags: tags,
    );

    _bookings.insert(0, completedBooking);
  }
}
