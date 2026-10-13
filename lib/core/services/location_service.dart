import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final ValueNotifier<bool> isGpsEnabledNotifier =
      ValueNotifier<bool>(false);
  static final ValueNotifier<Position?> currentPositionNotifier =
      ValueNotifier<Position?>(null);
  static final ValueNotifier<String> currentCityNotifier =
      ValueNotifier<String>('Colombo');

  static bool _hasPromptedThisSession = false;
  static bool get hasPromptedThisSession => _hasPromptedThisSession;
  static void markPrompted() => _hasPromptedThisSession = true;

  /// Check whether GPS hardware service is turned ON and permission is granted
  static Future<bool> isLocationReady() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      isGpsEnabledNotifier.value = serviceEnabled;
      if (!serviceEnabled) return false;

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Request permission and prompt device to enable GPS
  static Future<bool> requestGpsAndPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Directs user to phone's location settings
        await Geolocator.openLocationSettings();
        // Check again
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return false;
      }

      final isReady = serviceEnabled &&
          (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always);

      isGpsEnabledNotifier.value = isReady;

      if (isReady) {
        // Fetch current coordinates in background
        fetchCurrentLocation();
      }

      return isReady;
    } catch (_) {
      return false;
    }
  }

  /// Fetch current GPS coordinates
  static Future<Position?> fetchCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        ),
      );
      currentPositionNotifier.value = position;
      isGpsEnabledNotifier.value = true;
      return position;
    } catch (_) {
      return null;
    }
  }
}
