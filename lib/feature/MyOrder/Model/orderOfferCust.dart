import 'dart:convert';


enum OrderType { immediately, nonImmediately, unknown }

OrderType orderTypeFromString(String? typeStr) {
  switch (typeStr) {
    case 'immediately':
      return OrderType.immediately;
    case 'non_immediately':
      return OrderType.nonImmediately;
    default:
      return OrderType.unknown;
  }
}

class OrderOfferCustModel {
  int id;
  String status;
  CancelReason? cancelReason;
  String? cancelledBy;
  Category mainCategory;
  Category category;
  String? description;
  Address? address;
  DateTime? date;
  String? startAt;
  String? endAt;
  OrderType type;
  double minPrice;
  double maxPrice;
  double? rate;
  provider_offer? prov_offer;
  Provider? provider;
  List<dynamic> gallery;
  Customer customer;
  OrderOfferCustModel({
    required this.id,
    required this.status,
    this.cancelReason,
    this.cancelledBy,
    required this.mainCategory,
    required this.category,
    this.description,
    this.address,
    this.date,
    this.startAt,
    this.endAt,
    required this.type,
    required this.minPrice,
    required this.maxPrice,
    this.prov_offer,
    this.provider,
    this.rate,
    required this.gallery,
    required this.customer,
  });

  factory OrderOfferCustModel.fromRawJson(String str) =>
      OrderOfferCustModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderOfferCustModel.fromJson(
    Map<String, dynamic> json,
  ) => OrderOfferCustModel(
    id: json["id"],
    status: json["status"],
    cancelReason:
        json["cancel_reason"] != null
            ? CancelReason.fromJson(json["cancel_reason"])
            : null,
    cancelledBy: json["cancelled_by"],
    mainCategory: Category.fromJson(json["mainCategory"]),
    category: Category.fromJson(json["category"]),
    description: json["description"],
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    startAt: json["start_at"],
    endAt: json["end_at"] as String?,
    type: orderTypeFromString(json["type"] as String?),
    minPrice: json["min_price"]?.toDouble() ?? 0.0,
    maxPrice: json["max_price"]?.toDouble() ?? 0.0,
    provider:
        json["provider"] != null ? Provider.fromJson(json["provider"]) : null,
    rate: json["rate"] != null ? json["rate"]?.toDouble() ?? 0.0 : null,
    prov_offer:
        json["provider_offer"] != null
            ? provider_offer.fromJson(json["provider_offer"])
            : null,
    gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    if (cancelReason != null) "cancel_reason": cancelReason!.toJson(),
    if (cancelledBy != null) "cancelled_by": cancelledBy,
    "mainCategory": mainCategory.toJson(),
    "category": category.toJson(),
    "description": description,
    "address": address?.toJson(),
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "start_at": startAt,
    "end_at": endAt,
    "type": type.toString().split('.').last,

    "min_price": minPrice,
    "max_price": maxPrice,

    "provider": provider,

    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "customer": customer.toJson(),
  };
}

class CancelReason {
  int id;
  String reasonText;

  CancelReason({required this.id, required this.reasonText});

  factory CancelReason.fromRawJson(String str) =>
      CancelReason.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancelReason.fromJson(Map<String, dynamic> json) =>
      CancelReason(id: json["id"], reasonText: json["reason_text"]);

  Map<String, dynamic> toJson() => {"id": id, "reason_text": reasonText};
}

class Address {
  int id;
  String? title;
  String latitude;
  String longitude;

  Address({
    required this.id,
    this.title,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    title: json["title"] ?? "",
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Category {
  int id;
  String title;
  String svg;
  int minPrice;
  List<String>? description;
  int prvCnt;
  List<Keyword> keywords;

  Category({
    required this.id,
    required this.title,
    required this.svg,
    required this.minPrice,
    this.description,
    required this.prvCnt,
    required this.keywords,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    svg: json["svg"],
    minPrice: json["min_price"],
    description:
        json["description"] != null
            ? List<String>.from(json["description"].map((x) => x))
            : null,
    prvCnt: json["prv_cnt"],
    keywords: List<Keyword>.from(
      json["keywords"].map((x) => Keyword.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "svg": svg,
    "min_price": minPrice,
    "description": List<dynamic>.from(description!.map((x) => x)),
    "prv_cnt": prvCnt,
    "keywords": List<dynamic>.from(keywords.map((x) => x.toJson())),
  };
}

class Keyword {
  String? title;

  Keyword({this.title});

  factory Keyword.fromRawJson(String str) => Keyword.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      Keyword(title: json["title"]);

  Map<String, dynamic> toJson() => {"title": title};
}

class Customer {
  int id;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  String nationalId;
  String dialCountryCode;
  String phone;
  DateTime phoneVerifiedAt;
  int isCompleted;
  dynamic gender;
  IDcard avatar;
  IDcard iDcard;
  List<Address> addresses;
  int customerId;
  int rate;
  int ordersCnt;
  int points;
  int pointsInSp;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.nationalId,
    required this.dialCountryCode,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.isCompleted,
    required this.gender,
    required this.avatar,
    required this.iDcard,
    required this.addresses,
    required this.customerId,
    required this.rate,
    required this.ordersCnt,
    required this.points,
    required this.pointsInSp,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    nationalId: json["nationalID"],
    dialCountryCode: json["dial_country_code"],
    phone: json["phone"],
    phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
    isCompleted: json["is_completed"],
    gender: json["gender"],
    avatar: IDcard.fromJson(json["avatar"]),
    iDcard: IDcard.fromJson(json["IDcard"]),
    addresses: List<Address>.from(
      json["addresses"].map((x) => Address.fromJson(x)),
    ),
    customerId: json["customer_id"],
    rate: json["rate"],
    ordersCnt: json["orders_cnt"],
    points: json["points"],
    pointsInSp: json["points_in_sp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "nationalID": nationalId,
    "dial_country_code": dialCountryCode,
    "phone": phone,
    "phone_verified_at": phoneVerifiedAt.toIso8601String(),
    "is_completed": isCompleted,
    "gender": gender,
    "avatar": avatar.toJson(),
    "IDcard": iDcard.toJson(),
    "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
    "customer_id": customerId,
    "rate": rate,
    "orders_cnt": ordersCnt,
    "points": points,
    "points_in_sp": pointsInSp,
  };
}

class IDcard {
  String originalUrl;
  String mediumUrl;
  String smallUrl;

  IDcard({
    required this.originalUrl,
    required this.mediumUrl,
    required this.smallUrl,
  });

  factory IDcard.fromRawJson(String str) => IDcard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IDcard.fromJson(Map<String, dynamic> json) => IDcard(
    originalUrl: json["original_url"],
    mediumUrl: json["medium_url"],
    smallUrl: json["small_url"],
  );

  Map<String, dynamic> toJson() => {
    "original_url": originalUrl,
    "medium_url": mediumUrl,
    "small_url": smallUrl,
  };
}

class Provider {
  int id;
  String name;
  String description;
  String dialCountryCode;
  String phone;
  String? email;
  int? gender;
  int? userId;
  IDcard avatar;
  List<dynamic> gallery;
  double? rate;
  dynamic startAt;
  dynamic endAt;
  List<dynamic>? reviews;
  int balance;
  Address? address;
  int canHaveAChat;

  Provider({
    required this.id,
    required this.name,
    required this.description,
    required this.dialCountryCode,
    required this.phone,
    this.email,
    this.gender,
    this.userId,
    required this.avatar,
    required this.gallery,
    this.rate,
    required this.startAt,
    required this.endAt,
    this.reviews,
    required this.balance,
    this.address,
    required this.canHaveAChat,
  });

  factory Provider.fromRawJson(String str) =>
      Provider.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    dialCountryCode: json["dial_country_code"],
    phone: json["phone"],
    email: json["email"],
    gender: json["gender"],
    userId: json["user_id"],
    avatar: IDcard.fromJson(json["avatar"]),
    gallery: List<dynamic>.from((json["gallery"] ?? []).map((x) => x)),
    rate: json["rate"] != null ? (json["rate"] as num).toDouble() : null,
    startAt: json["start_at"],
    endAt: json["end_at"],
    reviews: List<dynamic>.from((json["reviews"] ?? []).map((x) => x)),
    balance: json["balance"],
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    canHaveAChat: json["can_have_a_chat"],
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
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "rate": rate,
    "start_at": startAt,
    "end_at": endAt,
    "reviews": List<dynamic>.from((reviews ?? []).map((x) => x)),
    "balance": balance,
    "address": address!.toJson(),
    "can_have_a_chat": canHaveAChat,
  };
}

class provider_offer {
  final int id;
  final String description;
  final String price;
  final String time;
  final String timeType;
  final String status;
  final String paymentStatus;
  final String? declineReason;
  final int orderId;
  final List<GalleryItem> gallery; 
  final DateTime createdAt;
  final Provider? provider;

  provider_offer({
    required this.id,
    required this.description,
    required this.price,
    required this.time,
    required this.timeType,
    required this.status,
    required this.paymentStatus,
    this.declineReason,
    required this.orderId,
    required this.gallery,
    required this.createdAt,
    this.provider,
  });

  factory provider_offer.fromJson(Map<String, dynamic> json) => provider_offer(
        id: json["id"],
        description: json["description"],
        price: json["price"],
        time: json["time"],
        timeType: json["time_type"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        declineReason: json["decline_reason"],
        orderId: json["order_id"],
        gallery: (json["gallery"] as List? ?? [])
            .map((e) => GalleryItem.fromJson(e))
            .toList(),
        createdAt: DateTime.parse(json["created_at"]),
        provider:
            json["provider"] != null ? Provider.fromJson(json["provider"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "price": price,
        "time": time,
        "time_type": timeType,
        "status": status,
        "payment_status": paymentStatus,
        "decline_reason": declineReason,
        "order_id": orderId,
        "gallery": gallery.map((x) => x.toJson()).toList(),
        "created_at": createdAt.toIso8601String(),
        "provider": provider?.toJson(),
      };
}

class GalleryItem {
  final String uuid;
  final String originalUrl;
  final String? mediumUrl;
  final String? smallUrl;
  final String? thumbUrl;

  GalleryItem({
    required this.uuid,
    required this.originalUrl,
    this.mediumUrl,
    this.smallUrl,
    this.thumbUrl,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        uuid: json["uuid"] ?? "",
        originalUrl: json["original_url"] ?? "",
        mediumUrl: json["medium_url"],
        smallUrl: json["small_url"],
        thumbUrl: json["thumb_url"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "original_url": originalUrl,
        "medium_url": mediumUrl,
        "small_url": smallUrl,
        "thumb_url": thumbUrl,
      };
}

