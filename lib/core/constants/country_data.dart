class CountryModel {
  final String name;
  final String code;
  final String flag;
  final String hint;
  final int digits; // Exact phone number digits required
  final List<String> cities;

  const CountryModel({
    required this.name,
    required this.code,
    required this.flag,
    required this.hint,
    required this.digits,
    required this.cities,
  });
}

class CountryData {
  static final List<CountryModel> allCountries = [
    const CountryModel(
      name: 'Sri Lanka',
      code: '+94',
      flag: '🇱🇰',
      hint: '77 123 4567',
      digits: 9,
      cities: [
        'Colombo',
        'Kandy',
        'Galle',
        'Jaffna',
        'Gampaha',
        'Negombo',
        'Kurunegala',
        'Matara',
        'Batticaloa',
        'Anuradhapura',
        'Trincomalee',
        'Badulla',
        'Ratnapura',
      ],
    ),
    const CountryModel(
      name: 'United States',
      code: '+1',
      flag: '🇺🇸',
      hint: '555 123 4567',
      digits: 10,
      cities: [
        'New York',
        'Los Angeles',
        'Chicago',
        'Houston',
        'Phoenix',
        'San Francisco',
        'Miami',
        'Seattle',
        'Dallas',
        'Austin',
      ],
    ),
    const CountryModel(
      name: 'United Kingdom',
      code: '+44',
      flag: '🇬🇧',
      hint: '7911 123456',
      digits: 10,
      cities: [
        'London',
        'Manchester',
        'Birmingham',
        'Leeds',
        'Glasgow',
        'Liverpool',
        'Edinburgh',
        'Bristol',
        'Sheffield',
      ],
    ),
    const CountryModel(
      name: 'Canada',
      code: '+1',
      flag: '🇨🇦',
      hint: '555 123 4567',
      digits: 10,
      cities: [
        'Toronto',
        'Vancouver',
        'Montreal',
        'Calgary',
        'Ottawa',
        'Edmonton',
        'Winnipeg',
        'Quebec City',
      ],
    ),
    const CountryModel(
      name: 'United Arab Emirates',
      code: '+971',
      flag: '🇦🇪',
      hint: '50 123 4567',
      digits: 9,
      cities: [
        'Dubai',
        'Abu Dhabi',
        'Sharjah',
        'Ajman',
        'Ras Al Khaimah',
        'Fujairah',
        'Al Ain',
      ],
    ),
    const CountryModel(
      name: 'Saudi Arabia',
      code: '+966',
      flag: '🇸🇦',
      hint: '50 123 4567',
      digits: 9,
      cities: [
        'Riyadh',
        'Jeddah',
        'Mecca',
        'Medina',
        'Dammam',
        'Khobar',
        'Tabuk',
      ],
    ),
    const CountryModel(
      name: 'Qatar',
      code: '+974',
      flag: '🇶🇦',
      hint: '3312 3456',
      digits: 8,
      cities: [
        'Doha',
        'Al Rayyan',
        'Al Wakrah',
        'Al Khor',
        'Umm Salal',
        'Lusail',
      ],
    ),
    const CountryModel(
      name: 'India',
      code: '+91',
      flag: '🇮🇳',
      hint: '98765 43210',
      digits: 10,
      cities: [
        'Chennai',
        'Mumbai',
        'Delhi',
        'Bangalore',
        'Hyderabad',
        'Kolkata',
        'Coimbatore',
        'Madurai',
        'Pune',
      ],
    ),
    const CountryModel(
      name: 'Australia',
      code: '+61',
      flag: '🇦🇺',
      hint: '412 345 678',
      digits: 9,
      cities: [
        'Sydney',
        'Melbourne',
        'Brisbane',
        'Perth',
        'Adelaide',
        'Gold Coast',
        'Canberra',
      ],
    ),
    const CountryModel(
      name: 'Singapore',
      code: '+65',
      flag: '🇸🇬',
      hint: '8123 4567',
      digits: 8,
      cities: [
        'Singapore Central',
        'Jurong',
        'Tampines',
        'Woodlands',
        'Yishun',
        'Bedok',
      ],
    ),
    const CountryModel(
      name: 'Malaysia',
      code: '+60',
      flag: '🇲🇾',
      hint: '12 345 6789',
      digits: 9,
      cities: [
        'Kuala Lumpur',
        'George Town',
        'Johor Bahru',
        'Ipoh',
        'Shah Alam',
        'Petaling Jaya',
      ],
    ),
    const CountryModel(
      name: 'Germany',
      code: '+49',
      flag: '🇩🇪',
      hint: '151 23456789',
      digits: 10,
      cities: [
        'Berlin',
        'Munich',
        'Frankfurt',
        'Hamburg',
        'Cologne',
        'Stuttgart',
      ],
    ),
    const CountryModel(
      name: 'France',
      code: '+33',
      flag: '🇫🇷',
      hint: '6 12 34 56 78',
      digits: 9,
      cities: [
        'Paris',
        'Marseille',
        'Lyon',
        'Toulouse',
        'Nice',
        'Nantes',
      ],
    ),
    const CountryModel(
      name: 'Japan',
      code: '+81',
      flag: '🇯🇵',
      hint: '90 1234 5678',
      digits: 10,
      cities: [
        'Tokyo',
        'Osaka',
        'Kyoto',
        'Yokohama',
        'Nagoya',
        'Fukuoka',
      ],
    ),
  ];

  // Active user selected country across whole app (Defaults to Sri Lanka)
  static CountryModel selectedCountry = allCountries.first;

  static CountryModel findByCountryName(String name) {
    return allCountries.firstWhere(
      (c) => c.name.toLowerCase() == name.toLowerCase(),
      orElse: () => allCountries.first,
    );
  }

  static CountryModel findByDialCode(String dialCode) {
    return allCountries.firstWhere(
      (c) => c.code == dialCode,
      orElse: () => allCountries.first,
    );
  }
}
