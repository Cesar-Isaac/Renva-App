
class OrderOffersModel {
  int id;
  String description;
  String price;
  String time;
  String timeType;
  String status;
  dynamic declineReason;
  Provider provider;
  List<GalleryItem> gallery;
  int orderId;
  String createdAt;

  OrderOffersModel({
    required this.id,
    required this.description,
    required this.price,
    required this.time,
    required this.timeType,
    required this.status,
    this.declineReason,
    required this.provider,
    required this.gallery,
    required this.orderId,
    required this.createdAt,
  });

  factory OrderOffersModel.fromJson(Map<String, dynamic> json) {
    return OrderOffersModel(
      id: json["id"] ?? 0,
      description: json["description"]?.toString() ?? '',
      price: json["price"]?.toString() ?? '',
      time: json["time"]?.toString() ?? '',
      timeType: json["time_type"]?.toString() ?? '',
      status: json["status"]?.toString() ?? '',
      declineReason: json["decline_reason"],
      provider:
          json["provider"] != null
              ? Provider.fromJson(json["provider"])
              : Provider.empty(),
      gallery:
          (json["gallery"] as List?)
              ?.map((e) => GalleryItem.fromJson(e))
              .toList() ??
          [],
      orderId: json["order_id"] ?? 0,
      createdAt: json["created_at"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "price": price,
    "time": time,
    "time_type": timeType,
    "status": status,
    "decline_reason": declineReason,
    "provider": provider.toJson(),
    "gallery": gallery.map((x) => x.toJson()).toList(),
    "order_id": orderId,
    "created_at": createdAt,
  };
}

class GalleryItem {
  String uuid;
  String originalUrl;
  String mediumUrl;
  String smallUrl;
  String thumbUrl;

  GalleryItem({
    required this.uuid,
    required this.originalUrl,
    required this.mediumUrl,
    required this.smallUrl,
    required this.thumbUrl,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
    uuid: json['uuid'] ?? '',
    originalUrl: json['original_url'] ?? '',
    mediumUrl: json['medium_url'] ?? '',
    smallUrl: json['small_url'] ?? '',
    thumbUrl: json['thumb_url'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'original_url': originalUrl,
    'medium_url': mediumUrl,
    'small_url': smallUrl,
    'thumb_url': thumbUrl,
  };
}

class Provider {
  int id;
  String name;
  String description;
  String dialCountryCode;
  String phone;
  String email;
  dynamic gender;
  int userId;
  Avatar avatar;
  List<Avatar> gallery;
  List<Category> categories;
  List<dynamic> regions;
  double rate;
  String startAt;
  String endAt;
  int balance;
  Address? address;
  int canHaveAChat;
  String status;
  String? rejectReason;

  Provider({
    required this.id,
    required this.name,
    required this.description,
    required this.dialCountryCode,
    required this.phone,
    required this.email,
    this.gender,
    required this.userId,
    required this.avatar,
    required this.gallery,
    required this.categories,
    required this.regions,
    required this.rate,
    required this.startAt,
    required this.endAt,
    required this.balance,
    this.address,
    required this.canHaveAChat,
    required this.status,
    this.rejectReason,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    dialCountryCode: json["dial_country_code"] ?? '',
    phone: json["phone"] ?? '',
    email: json["email"] ?? '',
    gender: json["gender"],
    userId: json["user_id"] ?? 0,
    avatar:
        json["avatar"] != null
            ? Avatar.fromJson(json["avatar"])
            : Avatar.empty(),
    gallery:
        json["gallery"] != null
            ? List<Avatar>.from(json["gallery"].map((x) => Avatar.fromJson(x)))
            : [],
    categories:
        json["categories"] != null
            ? List<Category>.from(
              json["categories"].map((x) => Category.fromJson(x)),
            )
            : [],
    regions: json["regions"] != null ? List<dynamic>.from(json["regions"]) : [],
    rate: (json["rate"] != null) ? (json["rate"] as num).toDouble() : 0.0,
    startAt: json["start_at"] ?? '',
    endAt: json["end_at"] ?? '',
    balance: json["balance"] ?? 0,
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    canHaveAChat: json["can_have_a_chat"] ?? 0,
    status: json["status"] ?? '',
    rejectReason: json["reject_reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "dial_country_code": dialCountryCode,
    "phone": phone,
    "email": email,
    "gender": gender,
    "user_id": userId,
    "avatar": avatar.toJson(),
    "gallery": gallery.map((x) => x.toJson()).toList(),
    "categories": categories.map((x) => x.toJson()).toList(),
    "regions": regions,
    "rate": rate,
    "start_at": startAt,
    "end_at": endAt,
    "balance": balance,
    "address": address?.toJson(),
    "can_have_a_chat": canHaveAChat,
    "status": status,
    "reject_reason": rejectReason,
  };

  factory Provider.empty() => Provider(
    id: 0,
    name: '',
    description: '',
    dialCountryCode: '',
    phone: '',
    email: '',
    gender: null,
    userId: 0,
    avatar: Avatar.empty(),
    gallery: [],
    categories: [],
    regions: [],
    rate: 0.0,
    startAt: '',
    endAt: '',
    balance: 0,
    address: Address.empty(),
    canHaveAChat: 0,
    status: '',
  );
}

class Avatar {
  String uuid;
  String originalUrl;
  String mediumUrl;
  String smallUrl;
  String thumbUrl;

  Avatar({
    required this.uuid,
    required this.originalUrl,
    required this.mediumUrl,
    required this.smallUrl,
    required this.thumbUrl,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    uuid: json["uuid"] ?? '',
    originalUrl: json["original_url"] ?? '',
    mediumUrl: json["medium_url"] ?? '',
    smallUrl: json["small_url"] ?? '',
    thumbUrl: json["thumb_url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "original_url": originalUrl,
    "medium_url": mediumUrl,
    "small_url": smallUrl,
    "thumb_url": thumbUrl,
  };

  factory Avatar.empty() => Avatar(
    uuid: '',
    originalUrl: '',
    mediumUrl: '',
    smallUrl: '',
    thumbUrl: '',
  );
}

class Address {
  int id;
  String? title;
  String? latitude;
  String? longitude;

  Address({required this.id, this.title, this.latitude, this.longitude});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] ?? 0,
    title: json["title"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "latitude": latitude,
    "longitude": longitude,
  };

  factory Address.empty() =>
      Address(id: 0, title: '', latitude: '', longitude: '');
}

class Category {
  int id;
  String title;
  dynamic svg;
  int minPrice;
  int maxPrice;
  dynamic description;
  int prvCnt;
  List<dynamic> keywords;

  Category({
    required this.id,
    required this.title,
    this.svg,
    required this.minPrice,
    required this.maxPrice,
    this.description,
    required this.prvCnt,
    required this.keywords,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    svg: json["svg"],
    minPrice: json["min_price"] ?? 0,
    maxPrice: json["max_price"] ?? 0,
    description: json["description"],
    prvCnt: json["prv_cnt"] ?? 0,
    keywords:
        json["keywords"] != null ? List<dynamic>.from(json["keywords"]) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "svg": svg,
    "min_price": minPrice,
    "max_price": maxPrice,
    "description": description,
    "prv_cnt": prvCnt,
    "keywords": keywords,
  };
}
