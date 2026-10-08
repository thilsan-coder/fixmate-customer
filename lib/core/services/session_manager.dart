class SessionManager {
  static bool _isLoggedIn = true;
  static String _userPhone = '+94 77 123 4567';
  static String _userName = 'Alex Johnson';
  static String _userEmail = 'alex.johnson@fixmate.lk';
  static String _userAddress = '24, Galle Road, Colombo 03';
  static String _userCountry = 'Sri Lanka';
  static String _userCity = 'Colombo';
  static String _avatarUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop&q=80';
  static String _deviceId = 'DEV-98124';

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

  // Update profile details dynamically
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
      'email': _userEmail,
      'address': _userAddress,
      'country': _userCountry,
      'city': _userCity,
      'avatarUrl': _avatarUrl,
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
