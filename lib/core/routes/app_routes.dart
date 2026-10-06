import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/onboarding/presentation/select_country_screen.dart';
import '../../features/onboarding/presentation/select_language_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String selectCountry = '/select-country';
  static const String selectLanguage = '/select-language';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        selectCountry: (context) => const SelectCountryScreen(),
        selectLanguage: (context) => const SelectLanguageScreen(),
      };
}
