class MainProfile {
  int id;
  String firstName;
  String lastName;
  dynamic email;
  String? nationalId;
  String? dialCountryCode;
  String phone;
  DateTime phoneVerifiedAt;
  int isCompleted;
  Gender gender;
  IDcard avatar;
  IDcard iDcard;
  List<dynamic>? addresses;
  int customerId;
  double rate; 
  int? ordersCnt;
  int? points;
  int? pointsInSp;

  ProviderModel? provider;

  MainProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.nationalId,
    this.dialCountryCode,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.isCompleted,
    required this.gender,
    required this.avatar,
    required this.iDcard,
    this.addresses,
    required this.customerId,
    required this.rate, 
    this.ordersCnt,
    this.points,
    this.pointsInSp,
    this.provider,
  });

  MainProfile.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      firstName = json['first_name'],
      lastName = json['last_name'],
      email = json['email'],
      nationalId = json['nationalID'] ?? '',
      dialCountryCode = json['dial_country_code'],
      phone = json['phone'],
      phoneVerifiedAt =
          json['phone_verified_at'] != null
              ? DateTime.parse(json['phone_verified_at'])
              : DateTime(1970),
      isCompleted = json['is_completed'],
      gender =
          json['gender'] != null
              ? Gender.fromJson(json['gender'])
              : Gender(id: 0, name: ''),
      avatar =
          json['avatar'] != null
              ? IDcard.fromJson(json['avatar'])
              : IDcard(originalUrl: ''),
      iDcard =
          json['IDcard'] != null
              ? IDcard.fromJson(json['IDcard'])
              : IDcard(originalUrl: ''),
      addresses = json['addresses'] ?? [],
      customerId = json['customer_id'],
      rate =
          (json['rate'] != null)
              ? (json['rate'] as num).toDouble()
              : 0.0, 
      ordersCnt = json['orders_cnt'],
      points = json['points'],
      pointsInSp = json['points_in_sp'],
      provider =
          json['provider'] != null
              ? ProviderModel.fromJson(json['provider'])
              : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'national_id': nationalId,
    'dial_country_code': dialCountryCode,
    'phone': phone,
    'phone_verified_at': phoneVerifiedAt.toIso8601String(),
    'is_completed': isCompleted,
    'gender': gender.toJson(),
    'avatar': avatar.toJson(),
    'i_dcard': iDcard.toJson(),
    'addresses': addresses,
    'customer_id': customerId,
    'rate': rate,
    'orders_cnt': ordersCnt,
    'points': points,
    'points_in_sp': pointsInSp,
    'provider': provider?.toJson(),
  };
}

class ProviderModel {
  final int id;
  final String name;
  final String? description;
  final String? dialCountryCode;
  final String? phone;
  final String? email;
  final Gender? gender;
  final int? userId;
  final IDcard? avatar;
  final List<GalleryItem> gallery;
  final double rate;
  final List<dynamic>? reviews;
  final int? balance;

  ProviderModel({
    required this.id,
    required this.name,
    this.description,
    this.dialCountryCode,
    this.phone,
    this.email,
    this.gender,
    this.userId,
    this.avatar,
    required this.gallery,
    required this.rate,
    this.reviews,
    this.balance,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      dialCountryCode: json['dial_country_code'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'] != null ? Gender.fromJson(json['gender']) : null,
      userId: json['user_id'],
      avatar: json['avatar'] != null ? IDcard.fromJson(json['avatar']) : null,
      gallery:
          (json['gallery'] as List<dynamic>?)
                  ?.map((e) => GalleryItem.fromJson(e))
                  .toList() ??
              [],
      rate:
          (json['rate'] != null)
              ? (json['rate'] as num).toDouble()
              : 0.0,
      reviews: json['reviews'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'dial_country_code': dialCountryCode,
    'phone': phone,
    'email': email,
    'gender': gender?.toJson(),
    'user_id': userId,
    'avatar': avatar?.toJson(),
    'gallery': gallery.map((e) => e.toJson()).toList(),
    'rate': rate,
    'reviews': reviews,
    'balance': balance,
  };
}

class GalleryItem {
  final String originalUrl;

  GalleryItem({required this.originalUrl});

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      originalUrl: json['original_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original_url': originalUrl,
    };
  }
}

class IDcard {
  String originalUrl;

  IDcard({required this.originalUrl});

  IDcard.fromJson(Map<String, dynamic> json)
    : originalUrl = json['original_url'];

  Map<String, dynamic> toJson() => {'original_url': originalUrl};
}

class Gender {
  int id;
  String name;

  Gender({required this.id, required this.name});

  Gender.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
