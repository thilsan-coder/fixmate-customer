import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/select_country_screen.dart';
import '../../features/onboarding/presentation/select_language_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';
import '../../features/home/presentation/main_nav_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/all_categories_screen.dart';
import '../../features/home/presentation/notifications_screen.dart';
import '../../features/search_workers/presentation/search_results_screen.dart';
import '../../features/worker_profile/presentation/worker_profile_screen.dart';
import '../../features/booking/presentation/extra_service_screen.dart';
import '../../features/booking/presentation/booking_summary_screen.dart';
import '../../features/booking/presentation/booking_confirmed_screen.dart';
import '../../features/booking/presentation/waiting_radar_screen.dart';
import '../../features/booking/presentation/booking_details_screen.dart';
import '../../features/booking/presentation/recent_bookings_screen.dart';
import '../../features/tracking/presentation/live_tracking_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/payment/presentation/payment_methods_screen.dart';
import '../../features/payment/presentation/invoice_screen.dart';
import '../../features/payment/presentation/payment_history_screen.dart';
import '../../features/support/presentation/help_support_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/profile/presentation/job_completed_review_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String selectCountry = '/select-country';
  static const String selectLanguage = '/select-language';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String mainNav = '/main-nav';
  static const String home = '/home';
  static const String allCategories = '/all-categories';
  static const String notifications = '/notifications';
  static const String searchResults = '/search-results';
  static const String workerProfile = '/worker-profile';
  static const String extraService = '/extra-service';
  static const String bookingSummary = '/booking-summary';
  static const String waitingRadar = '/waiting-radar';
  static const String bookingConfirmed = '/booking-confirmed';
  static const String bookingDetails = '/booking-details';
  static const String recentBookings = '/recent-bookings';
  static const String liveTracking = '/live-tracking';
  static const String chat = '/chat';
  static const String paymentMethods = '/payment-methods';
  static const String invoice = '/invoice';
  static const String paymentHistory = '/payment-history';
  static const String helpSupport = '/help-support';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String jobCompletedReview = '/job-completed-review';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        selectCountry: (context) => const SelectCountryScreen(),
        selectLanguage: (context) => const SelectLanguageScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        otpVerification: (context) => const OtpVerificationScreen(),
        mainNav: (context) => const MainNavScreen(),
        home: (context) => const HomeScreen(),
        allCategories: (context) => const AllCategoriesScreen(),
        notifications: (context) => const NotificationsScreen(),
        searchResults: (context) => const SearchResultsScreen(),
        workerProfile: (context) => const WorkerProfileScreen(),
        extraService: (context) => const ExtraServiceScreen(),
        bookingSummary: (context) => const BookingSummaryScreen(),
        waitingRadar: (context) => const WaitingRadarScreen(),
        bookingConfirmed: (context) => const BookingConfirmedScreen(),
        bookingDetails: (context) => const BookingDetailsScreen(),
        recentBookings: (context) => const RecentBookingsScreen(),
        liveTracking: (context) => const LiveTrackingScreen(),
        chat: (context) => const ChatScreen(),
        paymentMethods: (context) => const PaymentMethodsScreen(),
        invoice: (context) => const InvoiceScreen(),
        paymentHistory: (context) => const PaymentHistoryScreen(),
        helpSupport: (context) => const HelpSupportScreen(),
        profile: (context) => const ProfileScreen(),
        editProfile: (context) => const EditProfileScreen(),
        jobCompletedReview: (context) => const JobCompletedReviewScreen(),
      };
}
