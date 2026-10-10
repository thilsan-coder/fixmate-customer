import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = 'fixmate_is_logged_in_v2';
  static const String _keyCompletedOnboarding = 'fixmate_has_completed_onboarding_v2';
  static const String _keyHasRegistered = 'fixmate_has_registered_v2';
  static const String _keyUserPhone = 'fixmate_user_phone';
  static const String _keyUserName = 'fixmate_user_name';
  static const String _keyUserEmail = 'fixmate_user_email';
  static const String _keyUserAddress = 'fixmate_user_address';
  static const String _keyUserCountry = 'fixmate_user_country';
  static const String _keyUserCity = 'fixmate_user_city';
  static const String _keyAvatarUrl = 'fixmate_avatar_url';
  static const String _keyDeviceId = 'fixmate_device_id';

  // In-memory fallback states
  static bool _isLoggedIn = false;
  static bool _hasRegistered = false;
  static bool _hasCompletedOnboarding = false;
  static String _userPhone = '+94 77 123 4567';
  static String _userName = 'Alex Johnson';
  static String _userEmail = 'alex.johnson@fixmate.lk';
  static String _userAddress = '24, Galle Road, Colombo 03';
  static String _userCountry = 'Sri Lanka';
  static String _userCity = 'Colombo';
  static String _avatarUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop&q=80';
  static String _deviceId = 'DEV-98124';

  /// Check whether user has ever registered / logged in with OTP
  static Future<bool> hasRegistered() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyHasRegistered) ?? _hasRegistered;
    } catch (_) {
      return _hasRegistered;
    }
  }

  /// Check whether user has ever completed or gone through onboarding/registration
  static Future<bool> hasCompletedOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyCompletedOnboarding) ?? _hasCompletedOnboarding;
    } catch (_) {
      return _hasCompletedOnboarding;
    }
  }

  /// Mark onboarding as completed (e.g. after registration or first successful onboarding)
  static Future<void> setCompletedOnboarding(bool completed) async {
    _hasCompletedOnboarding = completed;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyCompletedOnboarding, completed);
    } catch (_) {}
  }

  /// Check if user is currently logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsLoggedIn) ?? _isLoggedIn;
    } catch (_) {
      return _isLoggedIn;
    }
  }

  /// Save active login session
  static Future<void> saveUserSession({
    required String phone,
    String name = 'Alex Johnson',
    String country = 'Sri Lanka',
  }) async {
    _isLoggedIn = true;
    _hasRegistered = true;
    _hasCompletedOnboarding = true;
    _userPhone = phone;
    _userName = name;
    _userCountry = country;
    _deviceId = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setBool(_keyHasRegistered, true);
      await prefs.setBool(_keyCompletedOnboarding, true);
      await prefs.setString(_keyUserPhone, _userPhone);
      await prefs.setString(_keyUserName, _userName);
      await prefs.setString(_keyUserCountry, _userCountry);
      await prefs.setString(_keyDeviceId, _deviceId);
    } catch (_) {}
  }

  /// Update profile details dynamically
  static Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? avatarUrl,
  }) async {
    if (name != null && name.isNotEmpty) _userName = name;
    if (email != null && email.isNotEmpty) _userEmail = email;
    if (phone != null && phone.isNotEmpty) _userPhone = phone;
    if (address != null && address.isNotEmpty) _userAddress = address;
    if (city != null && city.isNotEmpty) _userCity = city;
    if (avatarUrl != null && avatarUrl.isNotEmpty) _avatarUrl = avatarUrl;

    try {
      final prefs = await SharedPreferences.getInstance();
      if (name != null && name.isNotEmpty) await prefs.setString(_keyUserName, name);
      if (email != null && email.isNotEmpty) await prefs.setString(_keyUserEmail, email);
      if (phone != null && phone.isNotEmpty) await prefs.setString(_keyUserPhone, phone);
      if (address != null && address.isNotEmpty) await prefs.setString(_keyUserAddress, address);
      if (city != null && city.isNotEmpty) await prefs.setString(_keyUserCity, city);
      if (avatarUrl != null && avatarUrl.isNotEmpty) await prefs.setString(_keyAvatarUrl, avatarUrl);
    } catch (_) {}
  }

  /// Get user details
  static Future<Map<String, String>> getUserDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return {
        'phone': prefs.getString(_keyUserPhone) ?? _userPhone,
        'name': prefs.getString(_keyUserName) ?? _userName,
        'email': prefs.getString(_keyUserEmail) ?? _userEmail,
        'address': prefs.getString(_keyUserAddress) ?? _userAddress,
        'country': prefs.getString(_keyUserCountry) ?? _userCountry,
        'city': prefs.getString(_keyUserCity) ?? _userCity,
        'avatarUrl': prefs.getString(_keyAvatarUrl) ?? _avatarUrl,
        'sessionId': prefs.getString(_keyDeviceId) ?? _deviceId,
      };
    } catch (_) {
      return {
        'phone': _userPhone,
        'name': _userName,
        'email': _userEmail,
        'address': _userAddress,
        'country': _userCountry,
        'city': _userCity,
        'avatarUrl': _avatarUrl,
        'sessionId': _deviceId,
      };
    }
  }

  /// Clear session on manual logout (keeps onboarding flag so user goes to Login next time)
  static Future<void> logout() async {
    _isLoggedIn = false;
    _userPhone = '';
    _deviceId = '';

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, false);
      await prefs.remove(_keyUserPhone);
      await prefs.remove(_keyDeviceId);
    } catch (_) {}
  }

  /// Full reset to simulate brand-new install
  static Future<void> resetAll() async {
    _isLoggedIn = false;
    _hasRegistered = false;
    _hasCompletedOnboarding = false;
    _userPhone = '';
    _deviceId = '';

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (_) {}
  }
}
