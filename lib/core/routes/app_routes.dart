import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/select_country_screen.dart';
import '../../features/onboarding/presentation/select_language_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/otp_verification_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/all_categories_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String selectCountry = '/select-country';
  static const String selectLanguage = '/select-language';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String home = '/home';
  static const String allCategories = '/all-categories';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        selectCountry: (context) => const SelectCountryScreen(),
        selectLanguage: (context) => const SelectLanguageScreen(),
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        otpVerification: (context) => const OtpVerificationScreen(),
        home: (context) => const HomeScreen(),
        allCategories: (context) => const AllCategoriesScreen(),
      };
}
