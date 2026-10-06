import 'package:flutter/material.dart';
import 'screens/confirm_booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0047AB)),
        useMaterial3: true,
      ),
      home: const ConfirmBookingScreen(),
    );
  }
}
