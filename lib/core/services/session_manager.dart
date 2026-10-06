class SessionManager {
  static bool _isLoggedIn = false;
  static String _userPhone = '';
  static String _userName = 'Alex Johnson';
  static String _userCountry = 'Sri Lanka';
  static String _deviceId = '';

  // Save active login session
  static Future<void> saveUserSession({
    required String phone,
    String name = 'Alex Johnson',
    String country = 'Sri Lanka',
  }) async {
    _isLoggedIn = true;
    _userPhone = phone;
    _userName = name;
    _userCountry = country;
    _deviceId = DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Check if user is currently logged in
  static Future<bool> isLoggedIn() async {
    return _isLoggedIn;
  }

  // Get user details
  static Future<Map<String, String>> getUserDetails() async {
    return {
      'phone': _userPhone,
      'name': _userName,
      'country': _userCountry,
      'sessionId': _deviceId,
    };
  }

  // Clear session on manual logout
  static Future<void> logout() async {
    _isLoggedIn = false;
    _userPhone = '';
    _deviceId = '';
  }
}
