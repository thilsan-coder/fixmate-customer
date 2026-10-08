import 'package:flutter/material.dart';

// Onboarding & Auth
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/select_country_screen.dart';
import '../../features/onboarding/presentation/select_language_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';

// Home & Search
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/categories_screen.dart';
import '../../features/home/presentation/all_categories_screen.dart';
import '../../features/search/presentation/search_results_screen.dart';

// Workers & Booking
import '../../features/workers/presentation/worker_profile_screen.dart';
import '../../features/booking/presentation/book_service_screen.dart';
import '../../features/booking/presentation/bookings_list_screen.dart';
import '../../features/booking/presentation/confirm_booking_screen.dart';
import '../../features/booking/presentation/finding_workers_screen.dart';
import '../../features/booking/presentation/booking_confirmed_screen.dart';
import '../../features/booking/presentation/booking_details_screen.dart';
import '../../features/booking/presentation/job_completed_screen.dart';

// Payment
import '../../features/payment/presentation/payment_screen.dart';
import '../../features/payment/presentation/payment_history_screen.dart';
import '../../features/payment/presentation/invoice_screen.dart';

// Tracking & Chat
import '../../features/tracking/presentation/live_tracking_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';

// Profile, Notifications & Support
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/support/presentation/help_and_support_screen.dart';

class AppRoutes {
  // Onboarding & Auth
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String selectCountry = '/select-country';
  static const String selectLanguage = '/select-language';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';

  // Core App & Flow
  static const String home = '/home';
  static const String categories = '/categories';
  static const String allCategories = '/all-categories';
  static const String bookingsList = '/bookings-list';
  static const String bookService = '/book-service';
  static const String searchResults = '/search-results';
  static const String workerProfile = '/worker-profile';
  static const String confirmBooking = '/confirm-booking';
  static const String payment = '/payment';
  static const String findingWorkers = '/finding-workers';
  static const String bookingConfirmed = '/booking-confirmed';
  static const String liveTracking = '/live-tracking';
  static const String chat = '/chat';
  static const String bookingDetails = '/booking-details';
  static const String jobCompleted = '/job-completed';
  static const String invoice = '/invoice';
  static const String paymentHistory = '/payment-history';
  static const String editProfile = '/edit-profile';
  static const String notifications = '/notifications';
  static const String helpAndSupport = '/help-support';

  static Map<String, WidgetBuilder> get routes => {
        // Onboarding & Auth
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        selectCountry: (context) => const SelectCountryScreen(),
        selectLanguage: (context) => const SelectLanguageScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        otpVerification: (context) => const OtpVerificationScreen(),

        // Core App & Screens
        home: (context) => const HomeScreen(),
        categories: (context) => const CategoriesScreen(),
        allCategories: (context) => const AllCategoriesScreen(),
        bookingsList: (context) => const BookingsListScreen(),
        bookService: (context) => const BookServiceScreen(),
        searchResults: (context) => const SearchResultsScreen(),
        workerProfile: (context) => const WorkerProfileScreen(),
        confirmBooking: (context) => const ConfirmBookingScreen(),
        payment: (context) => const PaymentScreen(),
        findingWorkers: (context) => const FindingWorkersScreen(),
        bookingConfirmed: (context) => const BookingConfirmedScreen(),
        liveTracking: (context) => const LiveTrackingScreen(),
        chat: (context) => const ChatScreen(),
        bookingDetails: (context) => const BookingDetailsScreen(),
        jobCompleted: (context) => const JobCompletedScreen(),
        invoice: (context) => const InvoiceScreen(),
        paymentHistory: (context) => const PaymentHistoryScreen(),
        editProfile: (context) => const EditProfileScreen(),
        notifications: (context) => const NotificationsScreen(),
        helpAndSupport: (context) => const HelpAndSupportScreen(),
      };
}
